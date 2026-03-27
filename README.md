# 🎯 Clone Website Skill for OpenCode

> Clona cualquier sitio web de forma pixel-perfect con OpenCode

## 🛠 Herramientas de Extracción

Esta skill soporta **múltiples herramientas** en orden de prioridad:

### 1. WebFetch (Gratis - Incluido)

La herramienta integrada de OpenCode — funciona sin instalar nada.

- ✅ Funciona inmediatamente
- ⚠️ Solo HTML estático (sin JS)
- Mejor para: Extraction básica, siempre disponible

**Uso:**
```
Usa webfetch en OpenCode para obtener el HTML de la página
```

### 2. Simplerasp.io (Gratis - Sin auth)

Scraper web gratuito con buen free tier.

- ✅ Sin autenticación para uso básico
- ✅ Bueno para páginas estáticas

**Web:** https://simplescraper.io/

### 3. Apify (Free tier)

Tiene scrapers de texto gratuitos.

- ✅ Free tier disponible
- ⚠️ Requiere cuenta de Apify

### 4. Firecrawl (Mejor calidad - Requiere API key)

La mejor herramienta de extracción pero requiere crear una cuenta y configurar tu API key.

**1. Crear cuenta:**
👉 https://www.firecrawl.dev/signin?utm_source=firecrawl_docs&utm_medium=nav_bar&utm_content=sign_up

**2. Obtener tu API key:**
- Iniciá sesión en Firecrawl
- Vas a Settings → API Keys
- Copiá tu API key (comienza con `fc-`)

**3. Instalación:**
```bash
# npm
npm install -g firecrawl-cli
# bun
bun add -g firecrawl-cli
# pnpm
pnpm add -g firecrawl-cli
```

**4. Configurar tu API key:**
```bash
npx firecrawl login --api-key fc-TU-API-KEY
# Reemplaza "fc-TU-API-KEY" con tu API key real
```

**Verificar:**
```bash
firecrawl --version
```

**Incluye:**
- Extracción de HTML y CSS
- Descubrimiento de assets/imágenes
- Renderizado de JavaScript
- Modo interactivo para clicks/scrolls

### 5. Browserbase (Avanzado - Paid)

Para screenshots y automatización completa de browser.

- ✅ Browser real, screenshots, JS completo
- ⚠️ Requiere cuenta y pago

**Web:** https://www.browserbase.com/

---

## IMPORTANTE: Antes de clonar

Si tenés API key de Firecrawl → Configurala para mejores resultados

Si no tenés → La skill usa WebFetch automáticamente (funciona, pero es más básico)

**No esperes** — la skill comienza con lo que tiene disponible.

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
| Firecrawl CLI (opcional) | `npm install -g firecrawl-cli` para mejor extracción |
| Node.js | 20+ para proyectos Next.js |
| Proyecto base | Next.js + shadcn/ui + Tailwind v4 |

**La skill funciona con o sin Firecrawl** — si no está, usa WebFetch automáticamente.

## 🤝 Contributing

¿Encontraste un bug? ¿Querés mejorar la skill?
1. Fork del repo
2. Rama con tus cambios
3. PR

## 📝 Licencia

MIT

---

⭐ Si te fue útil,考虑 dar una estrella al repo de JCodesMore: [ai-website-cloner-template](https://github.com/JCodesMore/ai-website-cloner-template)