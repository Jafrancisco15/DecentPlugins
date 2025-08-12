
# bindings.tcl — preconfigured for DE1app 1.37
namespace eval ::ARbind {
    proc get_pressure {} {
        if {[info exists ::de1(state,pressure)]} { return $::de1(state,pressure) }
        return 0.0
    }
    proc get_flow {} {
        if {[info exists ::de1(state,flow)]} { return $::de1(state,flow) }
        return 0.0
    }
    proc set_active_profile {path} {
        set ::settings(profile_active_file) $path
        return ""
    }
    proc start_shot {} {
        # Manual by default.
        # de1_start_shot
        return ""
    }
    proc stop_shot {} {
        # Manual by default.
        # de1_stop_shot
        return ""
    }
}
