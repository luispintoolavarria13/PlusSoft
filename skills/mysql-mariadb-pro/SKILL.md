---
name: mysql-mariadb-pro
description: Use when working with MySQL or MariaDB databases. Handles query optimization, schema design, indexing strategies, stored procedures, transactions, backup/restore, and MariaDB-specific features like sequences, dynamic columns, and storage engines. Invoke for CREATE/ALTER TABLE, SELECT optimization, JOIN tuning, EXPLAIN plans, and database administration tasks.
license: MIT
compatibility: opencode
metadata:
  author: Luis Pinto
  version: "1.0.0"
  domain: database
  triggers: MySQL, MariaDB, SQL, database, query, XAMPP, mysql.connector, DDL, DML
  role: specialist
  scope: implementation
  output-format: code
  related-skills: sql-pro, database-optimizer, plusoft-expert
---

# MySQL / MariaDB Pro

Experto en bases de datos **MySQL y MariaDB** — optimización, administración y desarrollo.

## Stack de PLUS_SOFT+

| Componente | Detalle |
|------------|---------|
| **Motor** | MariaDB (vía XAMPP) |
| **BD** | `plus_soft_db` |
| **Charset** | `utf8mb4` / `utf8mb4_unicode_ci` |
| **Conector** | `mysql.connector` (Python) |
| **Engine** | `InnoDB` (transaccional) |
| **Host** | `localhost` |
| **Puerto** | `3306` |

## MariaDB vs MySQL — Diferencias Clave

| Característica | MariaDB | MySQL |
|---------------|---------|-------|
| **Engine por defecto** | InnoDB + XtraDB | InnoDB |
| **Secuencias** | `CREATE SEQUENCE` ✅ | ❌ |
| **Columnas dinámicas** | `COLUMN_CREATE()` ✅ | ❌ |
| **WITH (CTEs)** | ✅ (desde 10.2) | ✅ (desde 8.0) |
| **Ventanas (WINDOW)** | ✅ (desde 10.2) | ✅ (desde 8.0) |
| **JSON** | `JSON` + `LONGTEXT` | `JSON` nativo |
| **Roles** | ✅ SQL roles | ✅ SQL roles |

## Patrones para PLUS_SOFT+

### Conexión desde Python (db_manager.py)
```python
import mysql.connector

config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'plus_soft_db'
}
conn = mysql.connector.connect(**config)
cursor = conn.cursor(dictionary=True)
cursor.execute("SELECT * FROM productos WHERE id = %s", (1,))
res = cursor.fetchall()
conn.close()
```

### Queries parametrizadas (obligatorio)
```python
# ✅ CORRECTO — parametrizado
cursor.execute("SELECT * FROM usuarios WHERE usuario = %s AND password = %s", (user, pwd))

# ❌ INCORRECTO — SQL injection
cursor.execute(f"SELECT * FROM usuarios WHERE usuario = '{user}' AND password = '{pwd}'")
```

### Transacciones manuales
```python
conn = db.conectar()
try:
    cursor = conn.cursor()
    cursor.execute("INSERT INTO ventas (...) VALUES (...)")
    cursor.execute("INSERT INTO detalles_ventas (...) VALUES (...)")
    conn.commit()
except:
    conn.rollback()
finally:
    conn.close()
```

## Tipos de Datos Recomendados

| Dato | Tipo | Ejemplo |
|------|------|---------|
| IDs autoincrementales | `INT AUTO_INCREMENT` | `id INT AUTO_INCREMENT PRIMARY KEY` |
| Precios / montos | `DECIMAL(12,2)` | `precio_venta DECIMAL(12,2)` |
| Texto corto | `VARCHAR(200)` | `nombre VARCHAR(200)` |
| Texto largo | `TEXT` | `direccion TEXT` |
| Fechas | `DATE` / `DATETIME` | `fecha DATETIME DEFAULT CURRENT_TIMESTAMP` |
| Booleanos | `TINYINT(1)` | `permitido TINYINT(1) DEFAULT 1` |
| Porcentajes | `DECIMAL(5,2)` | `iva_porcentaje DECIMAL(5,2) DEFAULT 16.00` |

## Referencias

Cargar según contexto:

| Tema | Archivo | Cargar cuando... |
|------|---------|------------------|
| Optimización | `references/optimization.md` | Queries lentas, índices, EXPLAIN |
| Administración | `references/administration.md` | Backup, restauración, XAMPP |
| MariaDB Features | `references/mariadb-features.md` | Usar características específicas de MariaDB |
