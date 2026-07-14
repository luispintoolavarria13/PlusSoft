# Base de Datos de PLUS_SOFT+

## Conexión

```python
# Configuración por defecto (config.py)
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'plus_soft_db'
}

# O desde .env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=plus_soft_db
```

## Schema Completo

Ver `C:\PLUS_SOFT\database\init_db.sql` para el DDL completo.

### Tabla: usuarios
```sql
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,       -- bcrypt hash
    nombre_completo VARCHAR(150) NOT NULL,
    id_rol INT DEFAULT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id) ON DELETE SET NULL
);
```

### Tabla: productos
```sql
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) DEFAULT NULL,
    codigo_barras VARCHAR(50) DEFAULT NULL UNIQUE,
    nombre VARCHAR(200) NOT NULL,
    nombre_corto VARCHAR(100) DEFAULT NULL,
    id_categoria INT DEFAULT NULL,
    id_proveedor INT DEFAULT NULL,
    ubicacion VARCHAR(100) DEFAULT NULL,
    stock DECIMAL(12,2) DEFAULT 0.00,
    stock_minimo DECIMAL(12,2) DEFAULT 5.00,
    precio_costo DECIMAL(12,2) DEFAULT 0.00,
    iva_porcentaje DECIMAL(5,2) DEFAULT 16.00,
    precio_costo_iva DECIMAL(12,2) DEFAULT 0.00,
    precio_costo_usd DECIMAL(12,2) DEFAULT 0.00,
    precio_venta DECIMAL(12,2) DEFAULT 0.00,
    precio_venta_2 DECIMAL(12,2) DEFAULT 0.00,
    precio_venta_3 DECIMAL(12,2) DEFAULT 0.00,
    fecha_vencimiento DATE DEFAULT NULL,
    alerta_vencimiento INT DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id) ON DELETE SET NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id) ON DELETE SET NULL
);
```

### Tabla: pagos_ventas (pagos divididos)
```sql
CREATE TABLE pagos_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    metodo VARCHAR(50) NOT NULL,
    monto DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    referencia VARCHAR(100) DEFAULT NULL,
    banco VARCHAR(100) DEFAULT NULL,
    card_type VARCHAR(50) DEFAULT NULL,
    approval_code VARCHAR(50) DEFAULT NULL,
    divisa_monto DECIMAL(12,2) DEFAULT NULL,
    telefono_pm VARCHAR(20) DEFAULT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES ventas(id) ON DELETE CASCADE
);
```

## Consultas Útiles

### Dashboard (ventas hoy)
```sql
SELECT COUNT(*) as total_ventas, COALESCE(SUM(total), 0) as total_ingresos
FROM ventas WHERE DATE(fecha) = CURDATE();
```

### Productos con stock bajo
```sql
SELECT nombre, stock, stock_minimo
FROM productos WHERE stock <= stock_minimo
ORDER BY (stock / stock_minimo) ASC;
```

### Estado de caja actual
```sql
SELECT * FROM caja WHERE estado = 'ABIERTA' ORDER BY fecha_apertura DESC LIMIT 1;
```
