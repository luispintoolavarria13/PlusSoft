# Arquitectura de PLUS_SOFT+

## Patrón General

PLUS_SOFT+ usa un patrón **modular monolítico** con ventanas independientes:

```
main.py
  │
  ├── Configuración global (config.py)
  ├── Conexión BD (database/db_manager.py)
  ├── Autenticación (src/logic/auth.py)
  │
  ├── Módulo VENTAS → ventas.py
  ├── Módulo INVENTARIO → inventario.py
  ├── Módulo COMPRAS → compras.py
  ├── Módulo CLIENTES → clientes.py
  ├── Módulo PROVEEDOR → proveedores.py
  ├── Módulo CAJA → caja.py
  ├── Módulo CARTERA → cuentas_cobrar.py / cuentas_pagar.py
  ├── Módulo MOVIMIENTOS → movimientos.py
  ├── Módulo INFORMES → informes.py
  ├── Módulo OPCIONES → configuracion.py / usuarios.py / empresa.py
  │
  └── Utilidades (src/utils/)
      ├── security.py   → Hash bcrypt, sesiones, .env
      ├── pdf_gen.py    → Tickets PDF
      ├── excel_export.py → Exportación Excel
      └── thermal_printer.py → Impresión térmica
```

## Flujo de una Venta

```
1. Usuario hace clic en VENTAS en el sidebar
2. Se abre ventana de ventas (ventas.py)
3. Usuario selecciona productos, cantidades
4. Al presionar COBRAR → VentanaCobroProfesional
5. VentanaCobroProfesional maneja pagos mixtos
6. Se inserta en ventas + detalles_ventas + pagos_ventas
7. Se actualiza stock en kardex
8. Se genera ticket PDF
```

## Gestión de Estado

- **Caja**: Estado global (ABIERTA/CERRADA) en tabla `caja`. Solo una caja activa a la vez.
- **Sesión**: `SesionManager` con timeout de 30 min, renovable.
- **Sidebar**: Se filtra por permisos del usuario actual.
- **DB**: Una instancia de `Database` por módulo, conexión por query.
