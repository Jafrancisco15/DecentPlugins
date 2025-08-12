
# AutoRescue plugin (v0.1)
# Crea/actualiza perfiles en /sdcard/de1plus/profiles/AutoRescue/
# Seguro: no toca BLE ni dispara la máquina.

namespace eval ::AutoRescue {
    variable version "0.1"
    variable profiles_dir "/sdcard/de1plus/profiles/AutoRescue"

    proc log {msg} {
        catch { puts "AutoRescue: $msg" }
    }

    proc write_file {path content} {
        if {![file exists [file dirname $path]]} {
            file mkdir [file dirname $path]
        }
        set f [open $path "w"]
        fconfigure $f -translation lf -encoding utf-8
        puts $f $content
        close $f
    }

    proc ensure_profiles {} {
        variable profiles_dir
        log "Creando/actualizando perfiles en $profiles_dir"
        file mkdir $profiles_dir
        write_file [file join $profiles_dir "AutoCorrect.tcl"] [::AutoRescue::profile_autocorrect]
        write_file [file join $profiles_dir "CoarseSaver.tcl"]  [::AutoRescue::profile_coarse]
        write_file [file join $profiles_dir "FineSaver.tcl"]    [::AutoRescue::profile_fine]
        log "Listo. Verifica la carpeta 'AutoRescue' en el Profile Editor."
    }

    # === Perfiles como comentarios de parámetros (máxima compatibilidad) ===
    variable profile_autocorrect {
# Profile: AutoRescue / AutoCorrect (flow + pressure ceiling)
# - Preinfusión: 0.4 mL/s × 12 s (techo 3 bar)
# - Ramp: 0.4→1.8 mL/s en 8 s (techo 9 bar)
# - Sostener: 1.8 mL/s × 12–18 s (techo 9 bar)
# - Descenso: 1.8→1.3 mL/s en 10 s (techo 7 bar)
# - Corte: ratio 1:2.2 (o por peso); Temp 93–94 °C
    }

    variable profile_coarse {
# Profile: AutoRescue / CoarseSaver (molido más grueso)
# - Preinfusión: 0.8 mL/s × 10–12 s (techo 3 bar)
# - Extracción: 1.6–1.9 mL/s × 20–24 s (techo 9 bar)
# - Final: 1.3 mL/s × 8–10 s (techo 7 bar)
# - Ratio: 1:2.4–1:2.6 (+1–2 °C si procede)
    }

    variable profile_fine {
# Profile: AutoRescue / FineSaver (molido más fino)
# - Preinfusión: 0.3–0.5 mL/s × 18–25 s (techo 2.5–3 bar)
# - Extracción: 1.2–1.5 mL/s (techo 6–7 bar) con descenso
# - Final: 1.0–1.2 mL/s × 5–8 s (techo 6 bar)
# - Ratio: ≈1:2
    }

    # Ejecutar al cargar el plugin
    ensure_profiles
}
