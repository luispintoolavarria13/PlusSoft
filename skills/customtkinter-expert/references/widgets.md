# Referencia de Widgets CustomTkinter

## CTk — Ventana principal
```python
app = ctk.CTk()
app.title("Mi App")
app.geometry("1200x700")
app.resizable(True, True)
app.mainloop()
```

## CTkButton — Botón
```python
btn = ctk.CTkButton(
    parent, text="Guardar",
    command=mi_funcion,
    fg_color="#3B8ED0",           # color de fondo
    hover_color="#36719F",        # color al pasar mouse
    text_color="white",
    font=ctk.CTkFont(size=14, weight="bold"),
    width=120, height=40,
    corner_radius=8,
    border_width=0,
    state="normal"                # "normal" | "disabled"
)
```

## CTkEntry — Campo de texto
```python
entry = ctk.CTkEntry(
    parent, placeholder_text="Buscar producto...",
    width=300, height=35,
    border_width=2,
    border_color="#3B8ED0",
    corner_radius=6
)
valor = entry.get()              # obtener texto
entry.delete(0, "end")           # limpiar
entry.insert(0, "texto")         # insertar
```

## CTkComboBox — Desplegable
```python
combo = ctk.CTkComboBox(
    parent, values=["Opción 1", "Opción 2"],
    command=on_select,            # callback al seleccionar
    width=200, height=35,
    corner_radius=6
)
combo.set("Opción 1")            # valor por defecto
valor = combo.get()              # obtener selección
```

## CTkTabview — Pestañas
```python
tabview = ctk.CTkTabview(parent, width=500, height=400)
tabview.pack(fill="both", expand=True)

tab1 = tabview.add("Datos Generales")
tab2 = tabview.add("Configuración")

ctk.CTkLabel(tab1, text="Contenido de la pestaña").pack()
```

## CTkScrollableFrame — Frame con scroll
```python
scroll = ctk.CTkScrollableFrame(parent, width=400, height=300)
scroll.pack(fill="both", expand=True)

for i in range(50):
    ctk.CTkLabel(scroll, text=f"Item {i}").pack(pady=2)
```

## CTkSwitch — Interruptor
```python
switch = ctk.CTkSwitch(
    parent, text="Activar notificaciones",
    command=on_toggle,
    onvalue=True, offvalue=False
)
estado = switch.get()  # True/False
```

## CTkProgressBar — Barra de progreso
```python
progress = ctk.CTkProgressBar(parent, width=300, height=15)
progress.set(0.5)  # 50%
```

## CTkOptionMenu — Menú de opciones
```python
menu = ctk.CTkOptionMenu(
    parent, values=["Admin", "Cajero", "Supervisor"],
    command=on_change,
    width=150
)
menu.set("Admin")
```

## CTkFont — Fuente personalizada
```python
fuente_titulo = ctk.CTkFont(size=24, weight="bold", family="Segoe UI")
fuente_normal = ctk.CTkFont(size=13)
fuente_mono = ctk.CTkFont(size=12, family="Consolas")
```

## CTkImage — Imagen
```python
from PIL import Image
img = ctk.CTkImage(
    light_image=Image.open("icono.png"),
    dark_image=Image.open("icono_dark.png"),
    size=(24, 24)
)
btn = ctk.CTkButton(parent, text="", image=img, width=40)
```
