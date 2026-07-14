# Comodísimos Partner v3.0.2

Calculador de precios para distribuidores autorizados y equipo comercial. Evolución de CMX30 con registro de usuario y panel administrativo.

## Origen
Construido sobre el motor de precios de CMX30. Mantiene la numeración de versión de CMX30 para dar continuidad al historial (decisión tomada al iniciar el repositorio: se descartó reiniciar en v1.2, que era el número mostrado en el título de esta primera versión).

## Archivos del deploy
- `index.html`
- `cmx30_products_core.json`
- `cmx30_margin_rules.json`
- `cmx30_app_config.json`
- Backups incluidos: `backup_index_v302.html`, `backup_cmx30_products_core_v302.json`, `backup_cmx30_margin_rules_v302.json`, `backup_cmx30_app_config_v302.json`

## Funcionalidades actuales
- Registro obligatorio de usuario: nombre, celular, correo, empresa/distribuidor, ciudad, punto de venta, cargo (Vendedor / Dependiente / Administrador / Propietario), con consentimiento de tratamiento de datos.
- Calculador de precios: PVP con IVA, PVP sin IVA, PVP con descuento en sala, PVD con/sin IVA, ganancia estimada del distribuidor.
- Restricción de cotización por gama de producto (líneas no disponibles para el canal).
- Copia de resultado y de cotización formateada para WhatsApp.
- Registro de uso: cada consulta de precio queda asociada al usuario que la realizó.
- Panel administrador (correos autorizados fijos en el código + clave de acceso): exporta CSV de usuarios registrados y CSV de uso/consultas.

## Pendiente / decisiones para versiones futuras
- **Lista negra de dominios/correos bloqueados:** no implementada. Se definirá más adelante.
- **Acceso diferenciado según perfil (cargo):** el campo se captura en el registro, pero todavía no cambia qué puede ver o hacer cada perfil.
- **Autenticación de administrador:** hoy es correo autorizado + clave fija en el código (nivel básico). Es suficiente para esta etapa de uso interno; se evaluará una autenticación más robusta si la herramienta se convierte en una versión para cliente externo.

## v3.0.2 - Comodísimos Partner
- Se agrega pantalla de registro/activación de acceso para distribuidores y equipo comercial.
- Se agrega panel administrador con exportación de usuarios registrados y logs de uso.
- Base de cálculo de precios heredada del motor de CMX30.
