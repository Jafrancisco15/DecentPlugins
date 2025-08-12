
# AutoRescue (v0.1) — DE1app 1.37

**Qué hace:** instala 3 perfiles de "rescate" (AutoCorrect, CoarseSaver, FineSaver) que usan **modo flujo + techo de presión** para compensar molidos un poco **más finos** o **más gruesos**. Es seguro (no toca BLE ni dispara tiros).

## Instalación
1) Copia la carpeta `AutoRescue` dentro de `de1plus/plugins/` de tu tablet (quedaría `de1plus/plugins/AutoRescue`).  
2) En la DE1app: **Settings → App → Extensions** y activa **AutoRescue**.  
3) Al activarse, crea/actualiza los perfiles en **`/sdcard/de1plus/profiles/AutoRescue/`**.

## Perfiles (resumen)
**AutoCorrect**  
- Preinfusión: 0.4 mL/s × 12 s (techo 3 bar)  
- Ramp: 0.4→1.8 mL/s en 8 s (techo 9 bar)  
- Sostener: 1.8 mL/s × 12–18 s (techo 9 bar)  
- Descenso: 1.8→1.3 mL/s en 10 s (techo 7 bar)  
- Corte: ratio 1:2.2 (o por peso), Temp 93–94 °C

**CoarseSaver**  
- Preinfusión: 0.8 mL/s × 10–12 s (techo 3 bar)  
- Extracción: 1.6–1.9 mL/s × 20–24 s (techo 9 bar)  
- Final: 1.3 mL/s × 8–10 s (techo 7 bar)  
- Ratio: 1:2.4–1:2.6

**FineSaver**  
- Preinfusión: 0.3–0.5 mL/s × 18–25 s (techo 2.5–3 bar)  
- Extracción: 1.2–1.5 mL/s (techo 6–7 bar) con descenso al final  
- Final: 1.0–1.2 mL/s × 5–8 s (techo 6 bar)  
- Ratio: ≈1:2

## Notas por versión
- Esta variante está pensada para DE1app 1.37. La lógica del plugin es la misma entre 1.37 y 1.45, pero la **importación directa** de `.tcl` y el **editor de perfiles** tienen pequeñas diferencias visuales. Si tu app no importa `.tcl`, abre cada perfil y **replica los parámetros** en el Profile Editor.
- Recomendación: antes de usar, haz un **backup** de tu carpeta `de1plus/profiles/`.

## Próxima versión (opcional)
Si quieres una v0.2 con **auto-selección** (elige el perfil Coarse/Fine en tiempo real), puedo adaptar los hooks para tu versión exacta.
