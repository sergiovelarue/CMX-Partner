# ListaLoop B2B — v2.9 (2026-09-02)

Este paquete contiene el archivo listo para desplegar en Netlify vía GitHub. Súbelo directamente al repositorio (reemplazando `index.html`) para actualizar ambos sitios espejo.

## Contenido

- `index.html` — archivo canónico único de la app (frontend completo, sin dependencias externas de build).

## Cambios en esta versión (v2.9)

- **Asistente de IA — Ajustes Generales**: nuevo bloque en la pestaña "Ajustes Generales" con switch para habilitar/deshabilitar la función y campo de límite de preguntas por mes (control de costo). Guardado vía RPC `guardar_asistente_ia_config` en Supabase, restringido a administradores.
- **Asistente de IA — Widget de chat**: en la pestaña "Consultar", al buscar un producto aparece la tarjeta "Preguntar al asistente" (solo si la función está habilitada). El vendedor puede preguntar por complementarios y disponibilidad del producto consultado. El asistente nunca menciona precios, márgenes, PVD ni descuentos — ese dato jamás se le pasa al modelo. Muestra contador de uso mensual.
- Backend: Edge Function `asistente-ia` ya desplegada en Supabase, valida el switch y el límite mensual antes de responder (nunca confía en el frontend para el control de costo).

## Pendiente para activar el Asistente de IA en producción

Falta configurar el secreto `ANTHROPIC_API_KEY` en Supabase → Edge Functions → `asistente-ia` → Secrets. Sin esa clave, el botón aparece si activas el switch pero cualquier pregunta devuelve un error controlado. Requiere cuenta en Anthropic Console (console.anthropic.com) con método de pago.

## Historial reciente

- **v2.8 (2026-09-02)**: corrección de responsive móvil (botón "Mi Equipo" ya no se desborda ni desestabiliza el scroll), auditoría y recorte de ~25 textos largos en toda la app, texto legal provisional de transferencia internacional de datos (Ley 1581/2012) en el consentimiento de registro.

## Notas de seguridad

- El asistente de IA opera bajo un contrato de contexto estricto: solo referencia, descripción, gama, disponibilidad (MTS/MTO) y productos complementarios ya definidos. Nunca recibe ni puede exponer precios o márgenes, documentado como comentario en el código de la Edge Function.
