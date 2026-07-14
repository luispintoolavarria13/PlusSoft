# Temas y Apariencia en CustomTkinter

## Modo Oscuro/Claro
```python
import customtkinter as ctk

# Global
ctk.set_appearance_mode("Dark")     # "Dark" | "Light" | "System"
ctk.set_default_color_theme("blue") # "blue" | "green" | "dark-blue"

# Por widget (opcional)
widget = ctk.CTkButton(parent, fg_color="#3B8ED0")
```

## Tema Personalizado (archivo .json)

Crear `tema.json`:
```json
{
    "CTk": {
        "fg_color": ["#161616", "#f0f0f0"]
    },
    "CTkFrame": {
        "fg_color": ["#111111", "#e0e0e0"],
        "border_color": ["#2b2b2b", "#d0d0d0"],
        "corner_radius": 6
    },
    "CTkButton": {
        "fg_color": ["#3B8ED0", "#1F6AA5"],
        "hover_color": ["#36719F", "#144870"],
        "text_color": ["#FFFFFF", "#FFFFFF"],
        "corner_radius": 8
    },
    "CTkEntry": {
        "fg_color": ["#2b2b2b", "#ffffff"],
        "border_color": ["#3B8ED0", "#1F6AA5"],
        "text_color": ["#ffffff", "#000000"],
        "placeholder_text_color": ["#888888", "#888888"],
        "corner_radius": 6
    },
    "CTkLabel": {
        "text_color": ["#ffffff", "#000000"]
    },
    "CTkComboBox": {
        "fg_color": ["#2b2b2b", "#ffffff"],
        "border_color": ["#3B8ED0", "#1F6AA5"],
        "text_color": ["#ffffff", "#000000"],
        "corner_radius": 6
    }
}
```

Cargarlo:
```python
ctk.set_default_color_theme("ruta/al/tema.json")
```

## Paleta de Colores PLUS_SOFT+
```python
# Tomado de config.py
COLORS = {
    "primary":       "#3B8ED0",   # Azul principal
    "success":       "#28a745",   # Verde éxito
    "danger":        "#dc3545",   # Rojo error
    "warning":       "#ffc107",   # Amarillo advertencia
    "info":          "#17a2b8",   # Celeste info
    "dark":          "#0d0d0d",   # Sidebar bg
    "sidebar_bg":    "#0d0d0d",
    "work_area_bg":  "#161616",
    "card_bg":       "#111111",
}
```

## Modificar apariencia dinámicamente
```python
# Cambiar modo en tiempo real
ctk.set_appearance_mode("Light")  # o "Dark"

# Escalar UI
ctk.set_widget_scaling(1.0)       # 0.8 = 80% del tamaño
ctk.set_window_scaling(1.0)
```
