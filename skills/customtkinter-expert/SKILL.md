---
name: customtkinter-expert
description: Use when building Python GUI applications with CustomTkinter. Handles theming, widgets, layout management, responsive design, dark/light mode, and integration with Tkinter/TTk. Invoke for CTk widgets (CTkButton, CTkEntry, CTkComboBox, CTkTabview, etc.), custom themes, window management, and event-driven UI patterns.
license: MIT
compatibility: opencode
metadata:
  author: Luis Pinto
  version: "1.0.0"
  domain: framework
  triggers: CustomTkinter, CTk, ctk, GUI, interfaz, UI, customtkinter, tema oscuro, ventana
  role: specialist
  scope: implementation
  output-format: code
  related-skills: python-pro, plusoft-expert
---

# CustomTkinter Expert

Experto en **CustomTkinter** — la librería moderna de UI para Python basada en Tkinter.

## Conceptos Clave

CustomTkinter extiende Tkinter con widgets modernos, temas personalizados y modo oscuro/claro nativo.

```python
import customtkinter as ctk

# Configuración global (hacer al inicio)
ctk.set_appearance_mode("Dark")   # "Dark" | "Light" | "System"
ctk.set_default_color_theme("blue")  # "blue" | "green" | "dark-blue" o .json personalizado
```

## Widgets Principales

| Widget | Descripción | Reemplaza a (Tkinter) |
|--------|-------------|----------------------|
| `CTk` | Ventana principal | `Tk` |
| `CTkToplevel` | Ventana secundaria | `Toplevel` |
| `CTkFrame` | Contenedor | `Frame` |
| `CTkButton` | Botón moderno | `Button` |
| `CTkLabel` | Etiqueta | `Label` |
| `CTkEntry` | Campo de texto | `Entry` |
| `CTkTextbox` | Área de texto multilínea | `Text` |
| `CTkComboBox` | Desplegable | `Combobox` |
| `CTkOptionMenu` | Menú de opciones | `OptionMenu` |
| `CTkCheckBox` | Casilla de verificación | `Checkbutton` |
| `CTkSwitch` | Interruptor | - |
| `CTkRadioButton` | Botón de radio | `Radiobutton` |
| `CTkSlider` | Deslizador | `Scale` |
| `CTkProgressBar` | Barra de progreso | `Progressbar` |
| `CTkScrollbar` | Barra de scroll | `Scrollbar` |
| `CTkScrollableFrame` | Frame con scroll | - |
| `CTkTabview` | Pestañas | - |
| `CTkSegmentedButton` | Botón segmentado | - |
| `CTkInputDialog` | Diálogo de entrada | `simpledialog` |
| `CTkFont` | Fuente personalizada | `Font` |
| `CTkImage` | Imagen para CTk | `PhotoImage` |

## Patrón de Ventana Modular (como PLUS_SOFT+)

```python
import customtkinter as ctk

class VentanaModulo(ctk.CTkToplevel):
    def __init__(self, parent, db, usuario):
        super().__init__(parent)
        self.db = db
        self.usuario = usuario
        
        # Configuración de la ventana
        self.title("Módulo")
        self.geometry("1200x700")
        
        # Centrar en pantalla
        self.centrar()
        
        # Construir UI
        self.setup_ui()
        
        # Hacer modal
        self.grab_set()
        self.focus()
    
    def centrar(self):
        self.update_idletasks()
        ancho = self.winfo_width()
        alto = self.winfo_height()
        x = (self.winfo_screenwidth() // 2) - (ancho // 2)
        y = (self.winfo_screenheight() // 2) - (alto // 2)
        self.geometry(f"{ancho}x{alto}+{x}+{y}")
    
    def setup_ui(self):
        # Título del módulo
        titulo = ctk.CTkLabel(
            self, text="Título del Módulo",
            font=ctk.CTkFont(size=24, weight="bold")
        )
        titulo.pack(pady=20)
        
        # Frame contenedor
        container = ctk.CTkFrame(self)
        container.pack(fill="both", expand=True, padx=20, pady=10)
```

## Layout Management

### pack (apilamiento)
```python
widget.pack(side="top", fill="x", padx=10, pady=5)
widget.pack(side="left", padx=5)
widget.pack(fill="both", expand=True)
```

### grid (rejilla)
```python
widget.grid(row=0, column=0, padx=5, pady=5, sticky="ew")
parent.grid_columnconfigure(0, weight=1)  # expandir columna
parent.grid_rowconfigure(1, weight=1)     # expandir fila
```

## Referencias

Cargar según contexto:

| Tema | Archivo | Cargar cuando... |
|------|---------|------------------|
| Widgets | `references/widgets.md` | Usar widgets específicos |
| Temas | `references/themes.md` | Personalizar colores y apariencia |
| Tablas | `references/tablas.md` | Crear Treeview con datos |

## Patrones Comunes para PLUS_SOFT+

### Sidebar con botones de módulo
```python
sidebar = ctk.CTkFrame(self, width=200, fg_color="#0d0d0d")
sidebar.pack(side="left", fill="y", padx=0, pady=0)

for modulo, color in MODULE_COLORS.items():
    btn = ctk.CTkButton(
        sidebar, text=modulo,
        fg_color="transparent", text_color=color,
        hover_color="#1a1a1a", anchor="w",
        command=lambda m=modulo: self.abrir_modulo(m)
    )
    btn.pack(fill="x", padx=10, pady=2)
```

### Treeview con scroll
```python
frame_tabla = ctk.CTkFrame(parent)
frame_tabla.pack(fill="both", expand=True, padx=20, pady=10)

# Scrollbar
scrollbar = ctk.CTkScrollbar(frame_tabla, orientation="vertical")
scrollbar.pack(side="right", fill="y")

# Treeview (usar ttk.Treeview directamente)
from tkinter import ttk
tree = ttk.Treeview(frame_tabla, columns=("col1", "col2"), show="headings",
                    yscrollcommand=scrollbar.set)
tree.pack(fill="both", expand=True)
scrollbar.configure(command=tree.yview)
```

### Diálogo de confirmación
```python
dialog = ctk.CTkInputDialog(
    text="¿Está seguro?", title="Confirmar",
    button_fg_color="#dc3545"
)
respuesta = dialog.get_input()
```
