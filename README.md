# 🧠 LuisPinto — OpenCode Skills

Skills personalizados para OpenCode, creados y mantenidos por **Luis Pinto**.

## 📦 Skills incluidos

| Skill | Descripción |
|-------|-------------|
| **plusoft-expert** | 🏪 Experto en PLUS_SOFT+ (sistema POS/facturación con CustomTkinter + MariaDB) |
| **python-pro** | 🐍 Desarrollo Python 3.11+ con type hints, async, pytest |
| **sql-pro** | 🗄️ Optimización SQL, CTEs, window functions, indexing |
| **customtkinter-expert** | 🎨 Desarrollo GUI con CustomTkinter: widgets, temas, tablas, layouts |
| **mysql-mariadb-pro** | 🗃️ MySQL y MariaDB: optimización, administración, XAMPP, backup |
| **debugging-wizard** | 🐛 Debugging sistemático multi-lenguaje |
| **secure-code-guardian** | 🔒 Código seguro: OWASP, bcrypt, parametrized queries |
| **test-master** | ✅ Tests: unit, integración, E2E, performance, TDD |
| **code-reviewer** | 👀 Code reviews estructurados |
| **database-optimizer** | ⚡ Tuning de bases de datos (MySQL/MariaDB) |
| **architecture-designer** | 🏗️ Diseño de arquitectura y ADRs |
| **legacy-modernizer** | 🔄 Refactorización de código legacy |

## 🚀 Instalación

### Opción 1: Clonar y copiar (recomendado)

```powershell
git clone https://github.com/luispintoolavarria13/PlusSoft.git
cd LuisPinto
.\install.ps1
```

### Opción 2: Manual

Copia las carpetas de `skills/` que quieras a tu `C:\Users\Ronald\.opencode\skills\`

### Opción 3: Vía URL en `opencode.json`

```json
{
  "skills": {
    "urls": ["https://github.com/luispintoolavarria13/PlusSoft"]
  }
}
```

## 🔄 Mantenimiento

Para actualizar los skills cuando haya nuevos cambios:

```powershell
git pull
.\install.ps1
```

## ⚙️ Configuración de LSPs

Este repo incluye un archivo `opencode.template.json` con la configuración de **Language Server Protocol (LSP)** para OpenCode, que habilita autocompletado y análisis de código en tiempo real.

### LSPs incluidos

| Lenguaje | LSP | Extensiones |
|----------|-----|-------------|
| **Python** | pyright (vía npx) | `.py` |
| **TypeScript/JavaScript** | typescript-language-server (vía npx) | `.ts`, `.tsx`, `.js`, `.jsx` |

### Cómo usarlo

1. Copia el template a tu carpeta de configuración:
   ```powershell
   copy opencode.template.json "$env:USERPROFILE\.opencode\opencode.json"
   ```
2. Edita el archivo y reemplaza `TU_API_KEY_AQUI` con tu API key de OpenRouter.
3. Asegúrate de tener Node.js instalado (los LSPs se ejecutan via `npx`).

## 📝 Licencia

MIT — haz lo que quieras con estos skills.
