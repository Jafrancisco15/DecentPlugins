
# AutoRescueAuto (v0.2) — DE1app 1.37 (Preconfigured)

**Ready to use.** This build ships with **active bindings** for stock DE1app 1.37. No file edits required.
It auto-selects **CoarseSaver**, **FineSaver**, or **AutoCorrect** after a short **AutoProbe** based on early pressure/flow.

## Install
1) Copy **`AutoRescueAuto`** to `de1plus/plugins/` on your DE1 tablet.
2) In DE1app: **Settings → App → Extensions** → enable **AutoRescueAuto**.
3) Profiles are created/updated under:
   `/sdcard/de1plus/profiles/AutoRescue/` (AutoProbe, AutoCorrect, CoarseSaver, FineSaver).

## Use
- From console or a UI button: call `::AutoRescueAuto::auto_shot`.
- The plugin loads **AutoProbe** (flow 0.6 mL/s × 6 s, ceiling 3 bar), measures around t≈3 s, decides the profile, switches, and continues.
- **Start/stop are manual by default** (safe). You can enable automation later in `bindings.tcl` if desired.

## Defaults (config.tcl)
- PRESSURE_HIGH = 3.0 bar
- PRESSURE_LOW  = 1.5 bar
- FLOW_HIGH     = 1.8 mL/s
- FLOW_LOW      = 0.7 mL/s
- PROBE_TIME_MS = 3000 ms

## Notes
- These bindings target **stock DE1app 1.37**. If you run a custom branch where telemetry variables differ, the plugin will log a warning and fall back gracefully.
- This plugin does not change BLE or safety behavior. Always supervise first runs.

## Changelog
- v0.1 AutoRescue: flow-mode rescue profiles (file-only plugin).
- v0.2 AutoRescueAuto: adds AutoProbe + automatic profile selection (this build is preconfigured for DE1app 1.37).
