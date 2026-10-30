

# Cogging

The cogging with this linear rail is extremely severe. the motor jerks is extremely jerky in a start-stop fashion at low speeds, it practically comes to a stop then leaps forward again. It is however being run with an odrive, which is of course open source. So I asked claude to build a table of motor currents as a function of position so that it could invert this cogging in the driven motor currents to get a smooth velocity, which resulted in this:

<object type="image/svg+xml" data="/static/plots/odesc-cogging-sweep.svg" style="display:block;width:100%;height:auto;aspect-ratio:1000 / 560"><img src="/static/plots/odesc-cogging-sweep.svg"></object>




