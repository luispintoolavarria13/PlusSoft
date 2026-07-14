# Tablas (Treeview) en CustomTkinter

## Tabla básica con ttk.Treeview

CustomTkinter no tiene un widget de tabla propio. Se usa `ttk.Treeview` con `CTkScrollbar`:

```python
from tkinter import ttk
import customtkinter as ctk

class TablaView:
    def __init__(self, parent, columnas, ancho_cols=None):
        """
        columnas: dict {"col_id": "Nombre a mostrar"}
        ancho_cols: dict {"col_id": 100} (opcional)
        """
        self.parent = parent
        self.columnas = columnas
        self.ancho_cols = ancho_cols or {}
        
        # Frame contenedor
        self.frame = ctk.CTkFrame(parent)
        
        # Scrollbar vertical
        scroll_y = ctk.CTkScrollbar(self.frame, orientation="vertical")
        scroll_y.pack(side="right", fill="y")
        
        # Scrollbar horizontal
        scroll_x = ctk.CTkScrollbar(self.frame, orientation="horizontal")
        scroll_x.pack(side="bottom", fill="x")
        
        # Treeview
        col_ids = list(columnas.keys())
        self.tree = ttk.Treeview(
            self.frame, columns=col_ids, show="headings",
            yscrollcommand=scroll_y.set,
            xscrollcommand=scroll_x.set,
            height=20
        )
        self.tree.pack(fill="both", expand=True)
        
        scroll_y.configure(command=self.tree.yview)
        scroll_x.configure(command=self.tree.xview)
        
        # Configurar columnas
        for col_id, col_texto in columnas.items():
            ancho = self.ancho_cols.get(col_id, 120)
            self.tree.heading(col_id, text=col_texto)
            self.tree.column(col_id, width=ancho, minwidth=60)
    
    def pack(self, **kwargs):
        self.frame.pack(**kwargs)
    
    def grid(self, **kwargs):
        self.frame.grid(**kwargs)
    
    def limpiar(self):
        self.tree.delete(*self.tree.get_children())
    
    def agregar_fila(self, valores, iid=None):
        """
        valores: tuple en el mismo orden que las columnas
        """
        if iid:
            self.tree.insert("", "end", iid=iid, values=valores)
        else:
            self.tree.insert("", "end", values=valores)
    
    def seleccionado(self):
        """Retorna el item seleccionado o None"""
        seleccion = self.tree.selection()
        if seleccion:
            return self.tree.item(seleccion[0])
        return None
    
    def obtener_fila(self, iid):
        return self.tree.item(iid)
```

### Uso en PLUS_SOFT+
```python
# En cualquier módulo que muestre datos en tabla:
columnas = {
    "id": "Código",
    "nombre": "Nombre",
    "stock": "Stock",
    "precio": "Precio Bs",
}
anchos = {"id": 80, "nombre": 250, "stock": 100, "precio": 120}

tabla = TablaView(self, columnas, anchos)
tabla.pack(fill="both", expand=True, padx=20, pady=10)

# Llenar desde BD
productos = db.ejecutar_query(
    "SELECT id, nombre, stock, precio_venta FROM productos", fetch=True
)
tabla.limpiar()
for p in productos:
    tabla.agregar_fila((
        p['id'], p['nombre'], p['stock'], f"Bs {p['precio_venta']:.2f}"
    ))
```
