# Módulos de PLUS_SOFT+

## Ventas (`ventas.py`)

- Clase principal `Ventas` (hereda de `ctk.CTkToplevel`)
- `VentanaCobroProfesional` para pagos mixtos
- Soporta 8 métodos de pago
- Genera ticket PDF automático
- Verifica caja abierta antes de vender
- Tablas: `ventas`, `detalles_ventas`, `pagos_ventas`, `kardex`

## Inventario (`inventario.py`)

- CRUD completo de productos
- Filtros por categoría, proveedor, stock bajo
- Vista en Treeview con scrollbar
- Precios con IVA y USD
- Alertas de vencimiento

## Compras (`compras.py`)

- Registro de compras a proveedores
- Split de pagos (múltiples métodos)
- Actualización automática de kardex
- Crédito con días de plazo
- Tablas: `compras`, `detalles_compras`

## Caja (`caja.py`)

- Apertura con efectivo Bs + USD + saldo digital
- Cierre con conteo físico (efectivo, punto, pago móvil, transferencia)
- Compara esperado vs real (diferencias)
- Solo admin ve montos completos

## Cuentas por Cobrar (`cuentas_cobrar.py`)

- Ventas a crédito con abonos
- Seguimiento de saldos pendientes
- Tabla: `abonos_clientes`

## Cuentas por Pagar (`cuentas_pagar.py`)

- Compras a crédito con abonos
- Seguimiento de deudas
- Tabla: `abonos_proveedores`

## Movimientos (`movimientos.py`)

- Ingresos y egresos no operativos
- Categorización personalizable
- Tabla: `movimientos_varios`

## Informes (`informes.py`)

- Dashboard resumido
- Reportes parametrizables
- Exportación a Excel
- Filtros por fechas
