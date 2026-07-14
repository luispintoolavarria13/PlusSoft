# Optimización MySQL / MariaDB

## EXPLAIN — Analizar queries lentas

```sql
EXPLAIN SELECT p.nombre, p.precio_venta, c.nombre AS categoria
FROM productos p
LEFT JOIN categorias c ON c.id = p.id_categoria
WHERE p.stock > 0
ORDER BY p.nombre;
```

### Qué buscar en EXPLAIN:
- **type = ALL** → scan completo (agregar índice)
- **rows** muy alto → query no óptima
- **Extra = "Using filesort"** → agregar índice para ORDER BY
- **Extra = "Using temporary"** → necesita índice para GROUP BY

## Índices Recomendados para PLUS_SOFT+

```sql
-- Productos: búsqueda por código de barras
CREATE INDEX idx_productos_codigo_barras ON productos(codigo_barras);

-- Productos: búsqueda por nombre
CREATE INDEX idx_productos_nombre ON productos(nombre);

-- Ventas: búsqueda por fecha (reportes diarios)
CREATE INDEX idx_ventas_fecha ON ventas(fecha);

-- Ventas: búsqueda por cliente
CREATE INDEX idx_ventas_cliente ON ventas(id_cliente);

-- Movimientos de inventario por producto
CREATE INDEX idx_kardex_producto ON kardex(id_producto);
CREATE INDEX idx_kardex_fecha ON kardex(fecha);

-- Pagos por venta
CREATE INDEX idx_pagos_ventas_venta ON pagos_ventas(id_venta);
```

## Consultas comunes optimizadas

### Dashboard (velocidad con índices en fecha)
```sql
SELECT
    COUNT(*) AS total_ventas,
    COALESCE(SUM(total), 0) AS total_ingresos,
    COALESCE(AVG(total), 0) AS ticket_promedio
FROM ventas
WHERE DATE(fecha) = CURDATE();
```

### Productos más vendidos (TOP 10)
```sql
SELECT p.nombre, SUM(dv.cantidad) AS vendidos
FROM detalles_ventas dv
JOIN productos p ON p.id = dv.id_producto
JOIN ventas v ON v.id = dv.id_venta
WHERE v.fecha >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY dv.id_producto, p.nombre
ORDER BY vendidos DESC
LIMIT 10;
```

### Estado de caja actual
```sql
SELECT *
FROM caja
WHERE estado = 'ABIERTA'
ORDER BY fecha_apertura DESC
LIMIT 1;
```

## Configuración MariaDB (my.ini / my.cnf)

```ini
[mysqld]
# Caracteres
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci

# Motor por defecto
default-storage-engine = InnoDB

# Memoria (ajustar según RAM disponible)
innodb_buffer_pool_size = 256M
innodb_log_file_size = 64M
query_cache_size = 32M

# Conexiones
max_connections = 50
```
