# Características Específicas de MariaDB

## Secuencias (MariaDB 10.3+)
```sql
CREATE SEQUENCE seq_factura
START WITH 1
INCREMENT BY 1;

-- Obtener siguiente valor
SELECT NEXTVAL(seq_factura);

-- Reiniciar
ALTER SEQUENCE seq_factura RESTART WITH 1000;
```

## Columnas Dinámicas (MariaDB 10.0+)
Útil para atributos variables de productos:
```sql
-- Crear con columna dinámica
ALTER TABLE productos ADD COLUMN atributos BLOB;

-- Insertar datos dinámicos
UPDATE productos SET atributos = COLUMN_CREATE(
    'color', 'rojo',
    'talla', 'XL',
    'material', 'algodón'
) WHERE id = 1;

-- Leer un atributo específico
SELECT COLUMN_GET(atributos, 'color' AS CHAR(50)) FROM productos WHERE id = 1;
```

## Vistas Materializadas (MariaDB 10.2+ via triggers)
```sql
-- MariaDB no tiene vistas materializadas nativas,
-- pero se simulan con tablas + triggers
CREATE TABLE resumen_diario_ventas (
    fecha DATE PRIMARY KEY,
    total_ventas DECIMAL(12,2),
    cantidad INT
);

-- Trigger para mantenerla actualizada
DELIMITER //
CREATE TRIGGER tr_after_insert_venta
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    INSERT INTO resumen_diario_ventas (fecha, total_ventas, cantidad)
    VALUES (DATE(NEW.fecha), NEW.total, 1)
    ON DUPLICATE KEY UPDATE
        total_ventas = total_ventas + NEW.total,
        cantidad = cantidad + 1;
END //
DELIMITER ;
```

## IF EXISTS / IF NOT EXISTS (MariaDB)
```sql
-- MariaDB soporta sintaxis más flexible
DROP TABLE IF EXISTS temporal;
ALTER TABLE productos ADD COLUMN IF NOT EXISTS descuento DECIMAL(5,2) DEFAULT 0;
```

## System Versioning (MariaDB 10.3+)
```sql
-- Tabla con control de versiones (historial automático)
CREATE TABLE productos_versioned (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200),
    precio_venta DECIMAL(12,2),
    -- Columnas de versionado automáticas
    row_start TIMESTAMP(6) AS ROW START,
    row_end TIMESTAMP(6) AS ROW END,
    PERIOD FOR SYSTEM_TIME(row_start, row_end)
) WITH SYSTEM VERSIONING;

-- Ver historial de cambios
SELECT * FROM productos_versioned
FOR SYSTEM_TIME ALL
WHERE id = 1;
```
