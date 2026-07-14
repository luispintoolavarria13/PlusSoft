# Administración MySQL / MariaDB (XAMPP)

## XAMPP — Comandos básicos

### Iniciar/Detener MySQL desde terminal
```powershell
# Iniciar MySQL
& "C:\xampp\mysql\bin\mysqld.exe" --console

# Detener (en otro terminal)
& "C:\xampp\mysql\bin\mysqladmin.exe" -u root shutdown

# Cliente MySQL
& "C:\xampp\mysql\bin\mysql.exe" -u root -p
```

### Acceso directo a la BD de PLUS_SOFT+
```powershell
& "C:\xampp\mysql\bin\mysql.exe" -u root plus_soft_db
```

## Backup y Restauración

### Backup de la BD
```powershell
# Con mysqldump
& "C:\xampp\mysql\bin\mysqldump.exe" -u root plus_soft_db > C:\backups\plus_soft_backup.sql

# Con marca de tiempo
$fecha = Get-Date -Format "yyyy-MM-dd_HHmm"
$archivo = "C:\PLUS_SOFT\backups\plus_soft_$fecha.sql"
& "C:\xampp\mysql\bin\mysqldump.exe" -u root plus_soft_db > $archivo
```

### Restaurar
```powershell
& "C:\xampp\mysql\bin\mysql.exe" -u root plus_soft_db < C:\backups\plus_soft_backup.sql
```

### Backup automático desde Python (backup_db.py)
```python
import subprocess, os, datetime
from config import BACKUPS_DIR

def hacer_backup():
    fecha = datetime.datetime.now().strftime("%Y-%m-%d_%H%M")
    archivo = os.path.join(BACKUPS_DIR, f"plus_soft_{fecha}.sql")
    
    cmd = [
        r"C:\xampp\mysql\bin\mysqldump.exe",
        "-u", "root",
        "plus_soft_db",
        f"--result-file={archivo}"
    ]
    subprocess.run(cmd, capture_output=True)
    return archivo
```

## Usuarios y Permisos

```sql
-- Crear usuario para la app
CREATE USER 'plusoft_app'@'localhost' IDENTIFIED BY 'clave_segura';

-- Dar permisos solo a la BD de la app
GRANT SELECT, INSERT, UPDATE, DELETE ON plus_soft_db.* TO 'plusoft_app'@'localhost';

-- Ver permisos
SHOW GRANTS FOR 'plusoft_app'@'localhost';
```

## Reparación y Optimización

```sql
-- Verificar tablas
CHECK TABLE ventas, productos;

-- Reparar
REPAIR TABLE ventas;

-- Optimizar (reorganizar espacio)
OPTIMIZE TABLE productos;

-- Ver tamaño de la BD
SELECT table_name, ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.tables
WHERE table_schema = 'plus_soft_db'
ORDER BY (data_length + index_length) DESC;
```
