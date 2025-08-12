
# config.tcl — thresholds and timings
namespace eval ::ARcfg {
    variable PRESSURE_HIGH 3.0     ;# bar
    variable PRESSURE_LOW  1.5     ;# bar
    variable FLOW_HIGH     1.8     ;# mL/s
    variable FLOW_LOW      0.7     ;# mL/s
    variable PROBE_TIME_MS 3000    ;# ~3 s
}
