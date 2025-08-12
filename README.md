---

AutoRescue for Decent DE1

Flow-mode rescue profiles + optional automatic profile selection


AutoRescue helps stabilize espresso shots when the grind is a bit off by driving flow while capping pressure.

v0.1 — AutoRescue: installs three safe, ready-to-use rescue profiles.

v0.2 — AutoRescueAuto: adds a short AutoProbe and auto-selects the best profile (Fine/Coarse/Auto) based on early pressure/flow. Preconfigured builds for DE1app 1.37 and 1.45 are included.

---

Why this exists

Small grind drifts can push extractions into sour/astringent territory. Controlling flow with a pressure ceiling preserves contact time without over-stressing the puck. This won’t fix severe channeling or poor puck prep, but it often “saves” shots into the good-drinkable range.


---

Packages

You’ll find these ZIPs in Releases:

v0.1 (profiles only)

AutoRescue_DE1app_1.37.zip

AutoRescue_DE1app_1.45.zip

AutoRescue_ProfilesOnly.zip (just the .tcl profiles)


v0.2 (automatic selection)

AutoRescueAuto_v0_2_Preconfigured_DE1app_1.37.zip

AutoRescueAuto_v0_2_Preconfigured_DE1app_1.45.zip


> The preconfigured v0.2 builds ship with active bindings for stock DE1app 1.37/1.45—no file edits required. Start/stop remains manual by default (safe).




---

What you get

v0.1 — AutoRescue (profiles)

Creates three profiles under /sdcard/de1plus/profiles/AutoRescue/:

AutoCorrect — adaptive base (flow targets + pressure ceilings)

CoarseSaver — for slightly coarser than ideal grind

FineSaver — for slightly finer than ideal grind


Defaults (quick reference)
AutoCorrect:

Preinf: 0.4 mL/s × 12 s (ceil 3 bar)

Ramp: 0.4→1.8 mL/s in 8 s (ceil 9 bar)

Hold: 1.8 mL/s × 12–18 s (ceil 9 bar)

Decline: 1.8→1.3 mL/s in 10 s (ceil 7 bar)

Stop: ratio 1:2.2 (or by weight), 93–94 °C


CoarseSaver (coarser):

Preinf: 0.8 mL/s × 10–12 s (ceil 3 bar)

Extract: 1.6–1.9 mL/s × 20–24 s (ceil 9 bar)

Finish: 1.3 mL/s × 8–10 s (ceil 7 bar)

Ratio: 1:2.4–1:2.6 (+1–2 °C if roast allows)


FineSaver (finer):

Preinf (long/soft): 0.3–0.5 mL/s × 18–25 s (ceil 2.5–3 bar)

Extract: 1.2–1.5 mL/s (ceil 6–7 bar), slight decline at end

Finish: 1.0–1.2 mL/s × 5–8 s (ceil 6 bar)

Ratio: ≈1:2



---

v0.2 — AutoRescueAuto (automatic selection)

Adds a very short AutoProbe stage (flow 0.6 mL/s × 6 s, ceiling 3 bar) to measure early pressure/flow (~3 s), then picks:

FineSaver if pressure high & flow low (typical “too fine”)

CoarseSaver if pressure low & flow high (typical “too coarse”)

otherwise AutoCorrect


Config defaults (editable in config.tcl):

PRESSURE_HIGH = 3.0 bar
PRESSURE_LOW  = 1.5 bar
FLOW_HIGH     = 1.8 mL/s
FLOW_LOW      = 0.7 mL/s
PROBE_TIME_MS = 3000

Preconfigured builds (recommended):
Just copy the AutoRescueAuto folder to de1plus/plugins/ and enable in Settings → App → Extensions.
Bindings for telemetry/profile switching are already active for stock 1.37/1.45. Start/stop remains manual unless you enable it.


---

Installation

v0.1 (profiles)

1. Copy AutoRescue to de1plus/plugins/ on your tablet.


2. In DE1app: Settings → App → Extensions → enable AutoRescue.


3. Profiles appear under /sdcard/de1plus/profiles/AutoRescue/.


4. Open Profile Editor, review/adjust, save.



> If your build ignores .tcl imports, open each file and replicate the commented parameters in Profile Editor (same result).



v0.2 (auto)

Option A — Preconfigured (1.37 or 1.45):

1. Copy AutoRescueAuto to de1plus/plugins/.


2. Enable in Settings → App → Extensions. Done.


3. Call ::AutoRescueAuto::auto_shot (from console or a UI button). The plugin runs AutoProbe, decides, switches profile, and you continue the shot.



Option B — Manual bindings (custom branches):

1. Copy AutoRescueAuto, enable it.


2. Edit bindings.tcl to map:

get_pressure (bar), get_flow (mL/s)

set_active_profile <path> (full path under /sdcard/de1plus/profiles/AutoRescue/)

(Optional) start_shot / stop_shot for full automation



3. Adjust thresholds in config.tcl if desired.




---

Safety & limitations

Does not change BLE or machine safety. Supervise first runs.

Won’t fix severe channeling or poor puck prep—dial-in and distribution still matter first.

Start/stop is manual by default; enable only if you understand your build’s hooks.



---

Compatibility

Tested on DE1app 1.37 and 1.45 (stable).

v0.1 is “file-only” (max compatibility).

v0.2 needs telemetry/profile-switch bindings; preconfigured for stock 1.37/1.45, editable for custom branches.



---

Troubleshooting

Profiles not visible? Check /sdcard/de1plus/profiles/AutoRescue/; restart DE1app.

v0.2 not deciding? If pressure/flow read as 0, your bindings aren’t active—use the preconfigured build or fix bindings.tcl.

Profile didn’t switch? Ensure set_active_profile points to the correct absolute path.

Taste still off? Improve grind & puck prep; tweak thresholds in config.tcl (v0.2).



---

Roadmap

Built-in UI panel (button + live readouts).

Local REST API (POST /autoshot, GET /status) for web/mobile control.

WebSocket telemetry; per-shot logging.



---

Credits & License

Made by Jairon Francisco — Escuela de Café / Café Maguana.
Feedback and PRs are welcome.


---
