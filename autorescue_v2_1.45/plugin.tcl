
# AutoRescueAuto v0.2 — preconfigured build
source [file join [file dirname [info script]] "config.tcl"]
source [file join [file dirname [info script]] "bindings.tcl"]

namespace eval ::AutoRescueAuto {
    variable version "0.2"
    variable base_profiles_dir "/sdcard/de1plus/profiles/AutoRescue"
    variable probe_profile [file join $base_profiles_dir "AutoProbe.tcl"]
    variable autocorrect_profile [file join $base_profiles_dir "AutoCorrect.tcl"]
    variable coarse_profile [file join $base_profiles_dir "CoarseSaver.tcl"]
    variable fine_profile [file join $base_profiles_dir "FineSaver.tcl"]
    variable probe_started 0
    variable probe_start_ms 0

    proc log {msg} { catch { puts "AutoRescueAuto: $msg" } }

    proc ensure_profiles {} {
        variable base_profiles_dir
        file mkdir $base_profiles_dir
        ::AutoRescueAuto::write_file [file join $base_profiles_dir "AutoProbe.tcl"]    [::AutoRescueAuto::profile_probe]
        ::AutoRescueAuto::write_file [file join $base_profiles_dir "AutoCorrect.tcl"]  [::AutoRescueAuto::profile_autocorrect]
        ::AutoRescueAuto::write_file [file join $base_profiles_dir "CoarseSaver.tcl"]  [::AutoRescueAuto::profile_coarse]
        ::AutoRescueAuto::write_file [file join $base_profiles_dir "FineSaver.tcl"]    [::AutoRescueAuto::profile_fine]
    }

    proc write_file {path content} {
        if {![file exists [file dirname $path]]} { file mkdir [file dirname $path] }
        set f [open $path "w"]
        fconfigure $f -translation lf -encoding utf-8
        puts $f $content
        close $f
    }

    # Simple console UI
    proc menu {} {
        ::AutoRescueAuto::log "Call '::AutoRescueAuto::auto_shot' to run an Auto Shot."
    }

    # Auto Shot sequence
    proc auto_shot {} {
        variable probe_profile
        ::AutoRescueAuto::log "Auto Shot: selecting AutoProbe and starting probe..."
        ::ARbind::set_active_profile $probe_profile
        # Manual by default (safe). Uncomment ARbind::start_shot in bindings.tcl if you want auto-start.
        ::ARbind::start_shot
        set ::AutoRescueAuto::probe_started 1
        set ::AutoRescueAuto::probe_start_ms [clock milliseconds]
        after 100 ::AutoRescueAuto::tick
    }

    proc tick {} {
        if {!$::AutoRescueAuto::probe_started} { return }
        set now [clock milliseconds]
        set elapsed [expr {$now - $::AutoRescueAuto::probe_start_ms}]
        if {$elapsed >= $::ARcfg::PROBE_TIME_MS} {
            ::AutoRescueAuto::decide_and_continue
            return
        }
        after 100 ::AutoRescueAuto::tick
    }

    proc decide_and_continue {} {
        set p [::ARbind::get_pressure]
        set f [::ARbind::get_flow]
        ::AutoRescueAuto::log "Probe reading: pressure=$p bar, flow=$f mL/s"

        set chosen "::AutoRescueAuto::autocorrect_profile"
        if {$p >= $::ARcfg::PRESSURE_HIGH && $f <= $::ARcfg::FLOW_LOW} {
            set chosen "::AutoRescueAuto::fine_profile"
        } elseif {$p <= $::ARcfg::PRESSURE_LOW && $f >= $::ARcfg::FLOW_HIGH} {
            set chosen "::AutoRescueAuto::coarse_profile"
        }

        ::ARbind::stop_shot
        set next [set $chosen]
        ::ARbind::set_active_profile $next
        ::AutoRescueAuto::log "Chosen profile: $next. Start/continue the shot."
        ::ARbind::start_shot

        set ::AutoRescueAuto::probe_started 0
    }

    # Profiles (commented parameters for compatibility)
    variable profile_probe {
# AutoRescue / AutoProbe — probe stage
# Flow 0.6 mL/s × 6 s, Pressure ceiling 3 bar
    }
    variable profile_autocorrect {
# AutoRescue / AutoCorrect — adaptive base
# Preinfusion: 0.4 mL/s × 12 s (ceil 3 bar)
# Ramp: 0.4→1.8 mL/s in 8 s (ceil 9 bar)
# Hold: 1.8 mL/s × 12–18 s (ceil 9 bar)
# Decline: 1.8→1.3 mL/s in 10 s (ceil 7 bar)
# Stop: ratio 1:2.2; Temp 93–94 °C
    }
    variable profile_coarse {
# AutoRescue / CoarseSaver — coarser grind
# Preinfusion: 0.8 mL/s × 10–12 s (ceil 3 bar)
# Extraction: 1.6–1.9 mL/s × 20–24 s (ceil 9 bar)
# Finish: 1.3 mL/s × 8–10 s (ceil 7 bar)
# Ratio: 1:2.4–1:2.6
    }
    variable profile_fine {
# AutoRescue / FineSaver — finer grind
# Preinfusion: 0.3–0.5 mL/s × 18–25 s (ceil 2.5–3 bar)
# Extraction: 1.2–1.5 mL/s (ceil 6–7 bar) with decline
# Finish: 1.0–1.2 mL/s × 5–8 s (ceil 6 bar)
# Ratio: ≈1:2
    }

    ensure_profiles
    menu
}
