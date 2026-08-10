-- =====================================================================
-- ListaLoop B2B Industrial — Fase 4 (parte SQL)
-- Vista de ranking de "productos más consultados"
-- Proyecto Supabase: hixsuoiwdptzyrbgexli
-- =====================================================================
-- Pega este archivo directamente en el SQL Editor (no lo retipees a mano).
-- =====================================================================

create or replace view public.vw_consultas_ranking as
select referencia, count(*) as veces_consultado
from public.consultas_log
group by referencia;

-- La vista hereda la seguridad (RLS) de consultas_log, que ya permite
-- lectura agregada con la anon key. No requiere política propia.

-- =====================================================================
-- Después de correrlo, confírmame para que despliegues el index.html
-- de la Fase 4 (lista filtrable/paginada/ordenable en Consultar).
-- =====================================================================
