# 🎯 Clone Website Skill for OpenCode

> Clona cualquier sitio web de forma pixel-perfect con OpenCode

## 🛠 Herramientas de Extracción

Esta skill soporta **múltiples herramientas** para adaptarse a tus necesidades:

### Firecrawl (Recomendado)

**Instalación (elegí tu gestor):**

```bash
# npm
npm install -g firecrawl-cli

# bun
bun add -g firecrawl-cli

# pnpm
pnpm add -g firecrawl-cli
```

**Verificar instalación:**
```bash
firecrawl --version
```

**Incluye:**
- Extracción de HTML y CSS
- Descubrimiento de assets/imágenes
- Renderizado de JavaScript
- Modo interactivo para clicks/scrolls

**Web:** https://www.browserbase.com/

### Fallback: WebFetch

Si no tenés herramientas externas, usá el `webfetch` de OpenCode para obtener HTML básico.

---

## Inspirado en JCodesMore

Este proyecto fue inspirado y adaptado del trabajo de **[JCodesMore](https://github.com/JCodesMore)** y su skill [`ai-website-cloner-template`](https://github.com/JCodesMore/ai-website-cloner-template) para Claude Code.

Su trabajo usa Chrome MCP. Esta versión está **adaptada para OpenCode** usando Firecrawl y Browserbase.

## 🙏 Agradecimiento

Gracias a **JCodesMore** por inspirar este proyecto.

---

## ⚡ Instalación

### Windows

```batch
git clone https://github.com/stevenflusion/opencode-clone-website.git
cd opencode-clone-website
.\install.bat
```

### macOS / Linux

```bash
git clone https://github.com/stevenflusion/opencode-clone-website.git
cd opencode-clone-website
chmod +x install.sh
./install.sh
```

## 🚀 Uso

Una vez instalada, simplemente describí lo que necesitás:

- `"Clone este sitio: https://ejemplo.com"`
- `"Quiero hacer un clone de esta página"`
- `"Reverse-engineer esta web"`

## 📋 Requisitos

| Requisito | Descripción |
|-----------|-------------|
| OpenCode | Instalado y configurado |
| Firecrawl CLI | `npm install -g firecrawl-cli` (o bun/pnpm) |
| Node.js | 20+ para proyectos Next.js |
| Proyecto base | Next.js + shadcn/ui + Tailwind v4 |

## 🤝 Contributing

¿Encontraste un bug? ¿Querés mejorar la skill?
1. Fork del repo
2. Rama con tus cambios
3. PR

## 📝 Licencia

MIT

---

⭐ Si te fue útil,考虑 dar una estrella al repo de JCodesMore: [ai-website-cloner-template](https://github.com/JCodesMore/ai-website-cloner-template)