The [[20230616 Learning to simulate|previous]] simulation efforts worked all very well and good but I want a way to have some super small toy problems (say with 10 particles) that behave similarly to the sims from the paper. No problem, we shall simply write our own:
```python

def fluid_step(state: torch.Tensor):
    # The simulation takes places within a box of size BOX_SIZE x BOX_SIZE in the positive quadrant
    dt = 1
    gravity_str = 1e-4
    repel_str = 1e-8
    wall_str = 1e-6
    # state is a B x N x 4 tensor, where  B is the batch size, N is the number of particles
    # and the last dimension is [x, y, vx, vy]
    orig_shape = state.shape
    if len(state.shape) == 2:  # add batch dim if necessary
        state = state.unsqueeze(0)

    x_diff = (state[:, :, X_IDX].unsqueeze(-2) - state[:, :, X_IDX].unsqueeze(-1))  # B * N * N
    y_diff = (state[:, :, Y_IDX].unsqueeze(-2) - state[:, :, Y_IDX].unsqueeze(-1))  # B * N * N
    x_diff_sq = x_diff ** 2 # B * N * N
    y_diff_sq = y_diff ** 2 # B * N * N
    # x_diff_sq += 1e-9  # avoid divide by zero in range_
    range_ = torch.sqrt(x_diff_sq + y_diff_sq)
    relative_displacement = (range_ - PARTICLE_SIZE) / PARTICLE_SIZE
    exp_scale = torch.log(torch.tensor(0.01)) / INTERACTION_RADIUS
    repel_mag = relative_displacement ** 3  * torch.exp(exp_scale * torch.abs(relative_displacement))
    # repel_mag = 1 / relative_displacement 
    # repel_mag = x_diff_sq + y_diff_sq

    # Add in the inter-particle repulsion:
    repel_direction = torch.stack([
        (x_diff / (range_ + 1e-9)),
        (y_diff / (range_ + 1e-9)),
    ], dim=1)  # B * 2 * N * N
    N = state.shape[1]
    repel_direction = repel_direction.masked_fill(torch.eye(N, dtype=torch.bool).unsqueeze(0).unsqueeze(0), 0)
    mutual_repel = repel_mag.unsqueeze(1) * repel_direction
    mutual_repel = mutual_repel.sum(dim=-2)  # B * 2 * N
    mutual_repel = -mutual_repel.transpose(-1, -2)  # B * N * 2

    # add in repulsion from the walls:
    wall_dist = torch.stack([
        torch.stack(
        [  # horizontal walls
            state[:, :, X_IDX],
            state[:, :, X_IDX] - BOX_SIZE,
        ], dim=-1),
        torch.stack(
        [ # vertical walls
            state[:, :, Y_IDX],
            state[:, :, Y_IDX] - BOX_SIZE,
        ], dim=-1),
    ], dim=-1)  # B * N * 2 * 2
    wall_dist_inv = torch.exp(-1e1 * torch.abs(wall_dist)) / wall_dist**3  # cube to maintain sign
    # remove nans:
    wall_dist_inv[torch.isinf(wall_dist_inv)] = 0
    wall_repel = wall_dist_inv.sum(dim=-2)

    # add in gravity:
    gravity = torch.zeros_like(mutual_repel)
    gravity[:, :, 1] = -gravity_str
    
    accel = mutual_repel * repel_str + wall_repel * wall_str + gravity
    # no nan's allowed:
    assert not torch.isnan(accel).any()

    # update velocities:
    state[:, :, 2:4] += dt * accel
    # update positions:
    state[:, :, 0:2] += dt * state[:, :, 2:4]

    # make the fluid particles stop when they hit the walls.
    out_x_p = (state[:, :, X_IDX] >= BOX_SIZE)
    out_x_n = (state[:, :, X_IDX] < 0)
    out_x = out_x_p | out_x_n
    out_y_p = (state[:, :, Y_IDX] >= BOX_SIZE)
    out_y_n = (state[:, :, Y_IDX] < 0)
    out_y = out_y_p | out_y_n
    state[:, :, X_IDX] = state[:, :, X_IDX].masked_fill(out_x_p,  BOX_SIZE)
    state[:, :, X_IDX] = state[:, :, X_IDX].masked_fill(out_x_n, 0)
    state[:, :, Y_IDX] = state[:, :, Y_IDX].masked_fill(out_y_p,  BOX_SIZE)
    state[:, :, Y_IDX] = state[:, :, Y_IDX].masked_fill(out_y_n, 0)
    state[:, :, VX_IDX] = state[:, :, VX_IDX].masked_fill(out_x, 0)
    state[:, :, VY_IDX] = state[:, :, VY_IDX].masked_fill(out_y, 0)
    return state.reshape(orig_shape)
```

![[Screencast from 07-01-2023 01:56:28 PM.webm]]
ta-da!
OK it's not that great. main thing missing is the fact the particles pass through each other, and the lack of viscous forces to slow stuff down. Given that particles passing through each other means that there might be a /0 somewhere in the sim and this is the thing  that killed the N body simulation as a learning tool I feel that I may be repeating myself.
