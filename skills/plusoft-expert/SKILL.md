---
name: plusoft-expert
description: Use when working on PLUS_SOFT+, a POS/facturación system built with Python CustomTkinter + MariaDB. Handles inventory, sales, purchases, cash register, accounts receivable/payable, multi-payment support, granular permissions, and PDF ticket generation. Invoke for architecture decisions, database queries, module connections, CustomTkinter UI patterns, and business logic for this specific codebase.
license: MIT
compatibility: opencode
metadata:
  author: Luis Pinto
  version: "1.0.0"
  domain: specialized
  triggers: PLUS_SOFT, plusoft, POS, facturacion, CustomTkinter, inventario, ventas, caja
  role: specialist
  scope: implementation
  output-format: code
  related-skills: python-pro, sql-pro, debugging-wizard, database-optimizer, code-reviewer
---

# PLUS_SOFT+ Expert

Experto en el sistema **PLUS_SOFT+** — POS/facturación profesional para supermercados, bodegas y abastos.

## Stack Tecnológico

| Componente | Tecnología |
|------------|-----------|
| **Lenguaje** | Python 3.12 |
| **GUI** | CustomTkinter (tema oscuro) |
| **Base de datos** | MariaDB vía mysql.connector |
| **PDF** | reportlab |
| **Excel** | openpyxl |
| **Hash** | bcrypt |
| **Servidor BD** | XAMPP (MySQL local) |

## Estructura del Proyecto

```
C:\PLUS_SOFT\
├── main.py                          ← Entry point
├── config.py                        ← Constantes, colores, rutas, SUBMODULOS
├── ventas.py                        ← Módulo de ventas + VentanaCobroProfesional
├── inventario.py                    ← Gestión de inventario
├── compras.py                       ← Compras a proveedores
├── caja.py                          ← Apertura/cierre de caja
├── clientes.py                      ← CRUD clientes
├── proveedores.py                   ← CRUD proveedores
├── cuentas_cobrar.py               ← Cuentas por cobrar
├── cuentas_pagar.py                ← Cuentas por pagar
├── movimientos.py                   ← Ingresos/Egresos varios
├── informes.py                      ← Reportes y estadísticas
├── categorias.py                    ← Categorías de productos
├── usuarios.py                      ← Gestión de usuarios y roles
├── configuracion.py                 ← Configuración del sistema
├── empresa.py                       ← Datos de la empresa
├── perfil.py                        ← Perfil del usuario
├── frm_cliente.py                   ← Formulario cliente
├── frm_producto.py                  ← Formulario producto
├── frm_kardex.py                    ← Kardex de productos
├── listado_ventas.py               ← Listado de ventas
├── listado_compras.py              ← Listado de compras
├── ajuste_inventario.py            ← Ajustes de stock
├── migrate_passwords.py            ← Migrador de contraseñas
├── database/
│   ├── init_db.sql                 ← Schema completo de la BD
│   ├── db_manager.py               ← Conexión y ejecución de queries
│   └── queries.py                  ← Queries centralizadas
├── src/
│   ├── logic/
│   │   ├── auth.py                 ← Autenticación (bcrypt, sesiones, rate limiting)
│   │   └── calculator.py           ← Lógica de negocio
│   └── utils/
│       ├── security.py             ← Hash bcrypt, SesionManager, .env
│       ├── pdf_gen.py              ← Generación de tickets PDF
│       ├── excel_export.py         ← Exportación a Excel
│       ├── thermal_printer.py      ← Impresión térmica ESC/POS
│       ├── reporte_z.py            ← Reporte Z (cierre de caja detallado)
│       └── backup_db.py            ← Backup automático de BD
```

## Base de Datos

**Motor:** MariaDB vía XAMPP  
**Base de datos:** `plus_soft_db`  
**Config:** Lee credenciales desde `.env` (DB_HOST, DB_USER, DB_PASSWORD, DB_NAME)

### Tablas principales

| Tabla | Descripción |
|-------|-------------|
| `usuarios` | Usuarios del sistema (id, usuario, password, nombre_completo, id_rol) |
| `roles` | Roles (Administrador, Cajero, Supervisor) |
| `permisos` | Permisos por módulo (id_rol, modulo, permitido) |
| `permisos_detalle` | Permisos granulares por acción (id_rol, modulo, accion, permitido) |
| `productos` | Catálogo con precios, costos, stock, IVA, fechas |
| `categorias` | Categorías de productos |
| `proveedores` | Proveedores con RIF, contacto |
| `clientes` | Clientes con RIF/CI, límite de crédito |
| `ventas` | Cabecera de ventas (número_factura, id_cliente, total) |
| `detalles_ventas` | Detalle de productos por venta |
| `pagos_ventas` | Pagos divididos (múltiples métodos por venta) |
| `compras` | Compras a proveedores (con split de pagos) |
| `detalles_compras` | Detalle de productos por compra |
| `caja` | Apertura/cierre de caja (múltiples monedas) |
| `kardex` | Movimientos de inventario |
| `auditoria` | Log de actividades |
| `movimientos_varios` | Ingresos/Egresos extra |
| `abonos_clientes` | Cuentas por cobrar (abonos) |
| `abonos_proveedores` | Cuentas por pagar (abonos) |
| `notas_credito` | Devoluciones/notas de crédito |
| `configuracion` | Tasa BCV, próxima factura, próxima NC |
| `datos_empresa` | Datos del negocio (nombre, RIF, dirección) |
| `pagos_recibidos_banco` | Validación de referencias de pago |

### Métodos de pago soportados (8)

1. **Efectivo** — Bs
2. **Punto de Venta** — tarjeta crédito/débito
3. **Pago Móvil** — con referencia y teléfono
4. **Divisa ($)** — USD con tasa BCV
5. **Transferencia** — con referencia y banco
6. **Cashea** — cuotas
7. **Binance** — USDT/cripto
8. **Biopago** — huella dactilar

Todos soportan **pagos mixtos** (varios métodos en una misma venta).

## Roles y Permisos

| Rol | ID | Descripción |
|-----|----|-------------|
| Administrador | 1 | Acceso total a todo |
| Cajero | 2 | Ventas básicas, inventario/cliente ver, sin caja |
| Supervisor | 3 | Como Cajero + anular ventas, ver caja, descuentos, informes |

El sistema tiene dos capas de permisos:
- **permisos**: control por módulo (INVENTARIO, VENTAS, etc.)
- **permisos_detalle**: control granular (CREAR_VENTA, VER_CAJA, etc.) — definido en `config.py` > `SUBMODULOS`

## Reglas de Negocio Clave

1. **Caja**: Solo se puede vender si hay una caja ABIERTA. El cajero ve info básica; admin ve montos.
2. **Precios**: Cada producto tiene hasta 3 precios de venta (precio_venta, 2 y 3).
3. **IVA**: Se maneja porcentaje de IVA por producto (default 16%).
4. **Stock**: Control por producto con stock mínimo, alerta de vencimiento.
5. **Facturación**: Numeración automática desde `configuracion.proxima_factura`.
6. **Kardex**: Todos los movimientos de inventario quedan registrados.
7. **Tasa BCV**: Se configura en pantalla de configuración, afecta cálculos en USD.

## Convenciones de Código

- **UI**: CustomTkinter (import `customtkinter as ctk`)
- **Ventanas**: Cada módulo es una clase que extiende `ctk.CTkToplevel` o `ctk.CTkFrame`
- **Sidebar**: Menú lateral con botones por módulo, colores definidos en `MODULE_COLORS`
- **Queries**: Uso de `db.ejecutar_query(query, params, fetch=True/False)` — siempre parametrizadas
- **Estilo**: Tema oscuro (`APPEARANCE_MODE = "Dark"`), fondo sidebar `#0d0d0d`, área trabajo `#161616`

## Referencias

Cargar según contexto:

| Tema | Archivo | Cargar cuando... |
|------|---------|------------------|
| Arquitectura | `references/arquitectura.md` | Decisiones de diseño, conexión entre módulos |
| Base de Datos | `references/base-de-datos.md` | Queries SQL, esquemas, migraciones |
| Módulos | `references/modulos.md` | Trabajar en un módulo específico |

## Referencia Rápida: db_manager.py

```python
from database.db_manager import Database

db = Database()
# SELECT
res = db.ejecutar_query("SELECT * FROM productos WHERE id = %s", (1,), fetch=True)
# INSERT/UPDATE/DELETE
db.ejecutar_query("INSERT INTO productos (nombre) VALUES (%s)", ("Producto X",))
# Logging
db.registrar_log(id_usuario, "Acción realizada")
```

## Referencia Rápida: Auth

```python
from src.logic.auth import AuthManager

auth = AuthManager(db)
user = auth.login("admin", "admin")      # login con bcrypt
auth.is_logged_in()                      # True/False
auth.tiene_permiso("VENTAS")             # True/False
auth.validar_password_segura("pass")     # (True/False, mensaje)
auth.renovar_sesion()                    # mantener sesión activa
auth.tiempo_sesion_restante()            # minutos
```

## Funcionalidades Pendientes (Roadmap)

- [ ] Notas de crédito/débito (devoluciones)
- [ ] Lector de código de barras
- [ ] Impresora térmica ESC/POS
- [ ] Backup automático de BD
- [ ] Historial de compras por cliente
- [ ] Reporte Z (cierre de caja detallado)
- [ ] Aplicar permisos granulares en más módulos
