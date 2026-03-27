# 🎯 Clone Website Skill for OpenCode

> Clona cualquier sitio web de forma pixel-perfect con OpenCode

## 🛠 Herramientas de Extracción

Esta skill soporta **múltiples herramientas** para adaptarse a tus necesidades:

### Firecrawl (Recomendado - Primario)

API de scraping con modo `/interact` para interacción avanzada.

**Instalación:**
```bash
npm install -g firecrawl-cli
```

**Uso:**
```bash
npx firecrawl https://ejemplo.com
npx firecrawl interact https://ejemplo.com  # Para interacción
```

**Incluye:**
- Extracción de HTML y CSS
- Descubrimiento de assets/imágenes
- Renderizado de JavaScript
- Modo interactivo para clicks/scrolls

### Browserbase (Opcional - Avanzado)

Browser cloud para screenshots reales y automatización completa.

- Browser real en la nube
- Screenshots a cualquier viewport
- Interacción JS completa (clicks, scrolls, hovers)

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
| Firecrawl (recomendado) | `npm install -g firecrawl-cli` |
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