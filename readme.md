# ListaLoop B2B Industrial

Plataforma de gestión de listas de precios, catálogo y disponibilidad B2B para distribuidores autorizados. Producto propio de Conaccion BPS / Loop Comercial, licenciado a empresas industriales que necesitan que su canal de distribuidores cotice rápido, con información actualizada y de forma controlada.

La plataforma es **multi-empresa por diseño**: el nombre de la empresa contratante, su logo y sus datos de catálogo se configuran desde el panel administrador — no hay ningún nombre de cliente, marca ni razón social escrita en el código. Cada despliegue (repo + proyecto Supabase) sirve a una empresa contratante distinta.

## Arquitectura

- **Frontend:** una sola página (`index.html`), sin frameworks — HTML/CSS/JS vanilla + cliente JS de Supabase.
- **Backend:** Supabase (Postgres + Auth + Storage), acceso vía `@supabase/supabase-js` con la anon key.
- **Hosting:** Netlify, con auto-deploy desde este repositorio.
- **Seguridad:** lectura de catálogo abierta (anon key); escritura de precios/catálogo/disponibilidad protegida por Supabase Auth (el panel admin abre sesión con `signInWithPassword`) y Row Level Security por rol `authenticated`.

## Archivos del deploy

- `index.html` — aplicación completa (registro, Consultar, Cotización, Destacados, panel admin)
- `cmx30_app_config.json` — textos y configuración estática de la app
- `manifest.json` — manifiesto PWA

## Estructura de datos (Supabase)

| Tabla / vista / función | Uso |
|---|---|
| `productos` | Catálogo activo: referencia, descripción, gama, producto, precio C01 |
| `margin_rules` | Reglas de margen de distribuidor por prefijo/exacto de gama |
| `app_settings` | Empresa contratante, logo, tema visual, etiquetas de Destacados |
| `catalogo_destacados` | Foco / Best Sellers / Ofertas / Productos Sugeridos (venta cruzada) |
| `producto_media` | Imágenes, planos, manuales y videos por referencia |
| `producto_disponibilidad` | Tipo de abastecimiento MTS/MTO, unidades disponibles/próximas a llegar, días de entrega |
| `consultas_log` | Registro anónimo y agregado de consultas (solo referencia + fecha, sin dato de usuario) — alimenta "más consultados" |
| `cotizacion_items_log` | Registro anónimo y agregado de líneas cotizadas, agrupadas por `cotizacion_session_id` (UUID de sesión, no de persona) — alimenta el motor de co-ocurrencia |
| `vw_consultas_ranking` | Vista: conteo de consultas por referencia |
| `productos_relacionados(referencia, límite)` | Función: productos que más se cotizan junto con una referencia dada |

Los registros de `consultas_log` y `cotizacion_items_log` son deliberadamente anónimos y agregados — no se cruzan con la tabla de usuarios registrados, para mantenerlos fuera del alcance de tratamiento de datos personales de la Ley 1581/2012.

## Funcionalidades actuales

**Acceso**
- Registro de usuario: nombre, celular, correo, empresa/distribuidor, ciudad, punto de venta, cargo, con consentimiento de tratamiento de datos.
- Visibilidad de margen/PVD/ganancia según el cargo declarado (Administrador/Propietario ven margen; el resto no).

**Consultar**
- Búsqueda por referencia o nombre con autocompletado.
- Ficha de precio: PVP con/sin IVA, descuento en sala, PVD con/sin IVA, ganancia estimada, por cantidad.
- Restricción de cotización por gama de producto (líneas no disponibles para el canal).
- Información técnica (imágenes, planos, manuales, video) en panel plegable, oculto por defecto.
- Disponibilidad: MTS (unidades disponibles / próximas a llegar) o MTO (días de entrega aproximados), cuando el dato existe para esa referencia.
- Productos Sugeridos: definidos por el administrador (venta cruzada dirigida).
- Productos comprados en conjunto normalmente: calculado automáticamente por co-ocurrencia en cotizaciones históricas.
- Explorar catálogo: lista filtrable por gama/producto, ordenable (nombre, más consultados, precio) y paginada; filtro "Mostrar" para ver solo Productos Sugeridos o Comprados en conjunto de la referencia consultada.
- Copia de resultado y de cotización individual formateada para WhatsApp.

**Cotización**
- Carrito de cotización múltiple con cantidad y descuento editables por línea.
- Aviso si la cantidad pedida de un producto MTS supera las unidades disponibles.
- Totales generales (PVP, PVD, ganancia estimada) y copia formateada para WhatsApp.

**Destacados**
- Bloques Foco, Best Sellers y Ofertas, con imagen, definidos por el administrador.
- Overlay de detalle con opción de agregar directo a la cotización.

**Panel administrador** (correo autorizado + sesión Supabase Auth)
- Actualización de precio individual y carga masiva por CSV (reemplaza la lista activa completa).
- Carga de información técnica por referencia (imagen/PDF directo, video por enlace).
- Ajustes generales: nombre de empresa contratante, logo, tema visual (claro/oscuro/pastel).
- Gestión de Destacados (Foco/Best Sellers/Ofertas) y de Productos Sugeridos (venta cruzada).
- Gestión de disponibilidad MTS/MTO: formulario individual y carga masiva por CSV.
- Exportación CSV de usuarios registrados y de log de uso local.

## Pendiente / decisiones para versiones futuras
- **Lista negra de dominios/correos bloqueados:** no implementada.
- **Multi-tenant a nivel de base de datos:** hoy cada empresa contratante usa un proyecto Supabase propio; está pendiente decidir si se migra a un solo proyecto con aislamiento por `empresa_id` a medida que se comercialice a más clientes.
- **Motor de co-ocurrencia:** mejora en precisión a medida que crece el volumen de cotizaciones registradas; hoy es más útil cuantas más cotizaciones múltiples se hayan hecho.
- **Autenticación de administrador:** Supabase Auth + correo autorizado en código. Suficiente para esta etapa; se evaluará algo más robusto si la comercialización escala.

## Historial de cambios

- **Textos y UI:** eliminada la denominación "calculador de precios" de toda la interfaz; información técnica convertida en panel plegable oculto por defecto; encabezado principal plegable para mejorar la vista en móvil.
- **Explorar catálogo:** lista filtrable, ordenable y paginada agregada a Consultar, con filtro "Mostrar" independiente para ver solo Productos Sugeridos o Comprados en conjunto.
- **Venta cruzada:** Productos Sugeridos (definidos por admin) y Comprados en conjunto normalmente (co-ocurrencia automática), ambos visibles en Consultar.
- **Disponibilidad MTS/MTO:** nueva sección de disponibilidad de inventario, con actualización manual y por CSV, y aviso en el carrito de cotización si se excede el stock disponible.
- **Carrito de cotización:** corregido el desbordamiento horizontal en móvil.
- **Origen:** construido sobre un motor de precios previo (registro de usuario + panel administrador + cálculo de precios), evolucionado a plataforma multi-empresa con catálogo, disponibilidad y analítica agregada de comportamiento de consulta.
