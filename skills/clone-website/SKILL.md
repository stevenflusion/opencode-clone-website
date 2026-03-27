---
name: clone-website
description: >
  Reverse-engineer and clone a website in one shot — extracts assets, CSS, and content section-by-section and dispatches builder agents to rebuild. Use this whenever the user wants to clone, replicate, rebuild, reverse-engineer, or copy any website. Also triggers on phrases like "make a copy of this site", "rebuild this page", "pixel-perfect clone". Provide the target URL as an argument.
  Trigger: clone, replicate, rebuild, reverse-engineer, copy website, clone this site, rebuild this page, pixel-perfect clone
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.2"
allowed-tools:
  - webfetch
  - websearch
  - read
  - write
  - edit
  - glob
  - grep
  - bash
  - delegate
  - task
  - chrome-devtools
---

## When to Use

- User wants to clone/replicate any website
- Rebuild a site from a URL
- Reverse-engineer a design
- Create a pixel-perfect copy of a webpage

---

## 🔧 Installation Guide

### Priority Order (Best → Fallback)

```
┌─────────────────────────────────────────────────────────────────────┐
│  1. CHROME DEVTOOLS MCP   ←── RECOMENDADO (oficial de Google)     │
│  2. Firecrawl                                                      │
│  3. Browserbase                                                    │
│  4. Apify                                                          │
│  5. Simplerasp                                                     │
│  6. WebFetch           ←── fallback (siempre disponible)          │
└─────────────────────────────────────────────────────────────────────┘
```

---

### 1️⃣ Chrome DevTools MCP ⭐ (Recommended)

**El más nuevo y potente** — oficial de Google, 31k+ estrellas en GitHub.

**Instalación:**

```bash
# Instalar el paquete (OFICIAL de Google)
npm install -g chrome-devtools-mcp
```

**Configuración en OpenCode:**

Agregar a tu `mcpServers` en settings:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp"]
    }
  }
}
```

**Verificar:**
```bash
npx chrome-devtools-mcp --version
```

**Capacidades:**
- ✅ Screenshot completo de páginas
- ✅ Extracción de DOM completo
- ✅ Console logs, network, performance
- ✅ Interacción con la página (click, scroll, etc.)
- ✅ Mejor que Firecrawl para sitios complejos

**🎯 Best for:** Todo — es el reemplazo oficial de Google para automatización de browser

---

### 2️⃣ Firecrawl

**Potente pero requiere API key.**

**1. Crear cuenta:**
👉 https://www.firecrawl.dev/signin

**2. Obtener API key:**
- Settings → API Keys
- Copiar key (comienza con `fc-`)

**Instalación:**
```bash
npm install -g firecrawl-cli
```

**Configurar:**
```bash
npx firecrawl login --api-key fc-TU-API-KEY
```

**Verificar:**
```bash
npx firecrawl --version
```

**Uso:**
```bash
npx firecrawl https://example.com
npx firecrawl interact https://example.com  # Con interacción
```

- ✅ Excelente calidad de extracción
- ✅ CSS, JS, assets
- ⚠️ Requiere cuenta gratuita
- Best for: Fallback cuando no hay Chrome DevTools MCP

---

### 3️⃣ Browserbase

**Automación de browser avanzada.**

**1. Crear cuenta:**
👉 https://browserbase.com

**2. Obtener API key:**
- Project Settings → API Keys

**Instalación:**
```bash
npm install -g @browserbase/cli
```

**Configurar:**
```bash
export BROWSERBASE_API_KEY="bb-TU-API-KEY"
```

**Verificar:**
```bash
npx browserbase --version
```

- ✅ Browser real, screenshots, JS completo
- ⚠️ Requiere cuenta (tier gratuito disponible)
- Best for: Cuando necesitas screenshots avanzados

---

### 4️⃣ Apify

**Plataforma de web scraping.**

**1. Crear cuenta:**
👉 https://apify.com

**2. Obtener token:**
- Settings → Personal Access Tokens

**Instalación:**
```bash
npm install -g apify-cli
apify auth
```

**Verificar:**
```bash
apify --version
```

- ✅ Gratis para开始
- ⚠️ Requiere cuenta
- Best for: Cuando necesitas actors específicos

---

### 5️⃣ Simplerasp.io

**Scraper simple y gratuito.**

**1. Usar directamente:**
👉 https://simplescraper.io

- ✅ Sin registro para básico
- ⚠️ Limitado
- Best for: Extracción rápida sin setup

---

### 6️⃣ WebFetch (Fallback)

**Tool incorporado de OpenCode — siempre funciona.**

```bash
webfetch(url="https://example.com", format="markdown")
```

- ✅ No requiere setup
- ⚠️ Solo HTML estático
- Best for: Siempre funciona como fallback

---

## 🔄 Auto-Detection Flow

Al iniciar un clone, el agente detecta automáticamente qué herramienta está disponible:

```bash
# Prioridad de detección
1. Chrome DevTools MCP → si está configurado en OpenCode, USARLO
2. Firecrawl CLI → npx firecrawl --version
3. Browserbase CLI → npx browserbase --version  
4. Apify CLI → apify --version
5. Simplerasp → verificar si existe en PATH
6. WebFetch → SIEMPRE disponible como fallback
```

**Mensaje al usuario según disponibilidad:**

| Disponible | Mensaje |
|------------|---------|
| Chrome DevTools MCP | "🤖 Usando Chrome DevTools MCP (Google) — mejor calidad" |
| Firecrawl | "🔥 Usando Firecrawl para extracción completa" |
| Browserbase | "🌐 Usando Browserbase para browser automation" |
| Apify | "⚡ Usando Apify para scraping" |
| Solo WebFetch | "📄 Usando WebFetch (fallback). Para mejor resultado, instala Chrome DevTools MCP o configura Firecrawl." |

**Regla de oro:** No bloquees al usuario esperando setup — inicia con lo que esté disponible y sugiere mejoras.

## Pre-Flight

1. Read `TARGET.md` for URL and scope. If URL doesn't match, update it.
2. **Check available extraction tools** (en orden de prioridad):
   ```bash
   # 1. Chrome DevTools MCP - verificar en config de OpenCode
   # (si está en mcpServers, USARLO)
   
   # 2. Firecrawl
   npx firecrawl --version 2>/dev/null || echo "Firecrawl not found"
   
   # 3. Browserbase
   npx browserbase --version 2>/dev/null || echo "Browserbase not found"
   
   # 4. Apify
   apify --version 2>/dev/null || echo "Apify not found"
   
   # 5. WebFetch - SIEMPRE disponible (fallback)
   ```
3. **Inform user** about available tools (ver tabla en sección anterior)
4. Verify project exists:
   - If `package.json` doesn't exist, prompt user to initialize a Next.js + shadcn/ui + Tailwind v4 project first
   - If exists but doesn't build (`npm run build` fails), fix or prompt user
5. Create directories: `docs/research/`, `docs/research/components/`, `docs/design-references/`, `scripts/`.
6. **Clean up template files**: If copying from any template that includes CLAUDE.md, delete it — OpenCode uses AGENTS.md, not CLAUDE.md.

### Template Cleanup

When initializing or copying template files:
- ✅ Keep: `AGENTS.md`, `README.md`, `package.json`, `next.config.ts`, etc.
- ❌ Delete: `CLAUDE.md` (OpenCode doesn't use it)

## Guiding Principles

### 1. Completeness Beats Speed

Every builder agent must receive **everything** it needs: screenshot, CSS values, downloaded assets with local paths, real text, component structure. If a builder has to guess — color, font size, padding — you failed.

### 2. Small Tasks, Perfect Results

When an agent gets "build entire features section," it glosses over details. With exact CSS values per component, it nails it every time.

**Complexity rule:** If prompt exceeds ~150 lines, break into smaller pieces.

### 3. Real Content, Real Assets

Extract actual text, images, videos, SVGs. This is a clone, not a mockup.

**Layered assets:** A section that looks like one image often has multiple layers — background gradient, foreground mockup, overlay icon.

### 4. Foundation First

Build foundation first: global CSS with design tokens, TypeScript types, global assets. Everything else can be parallel.

### 5. Extract How It Looks AND Behaves

A website is not a screenshot — it's a living thing. Elements move, change, appear in response to scroll, hover, click, resize, time.

### 6. Identify Interaction Model

Is the section driven by clicks, scrolls, hovers, time? Determine FIRST before building.

### 7. Extract Every State

Tabs show different cards per tab? Header looks different at scroll position 0 vs 100? Extract ALL states.

### 8. Spec Files Are Source of Truth

Every component gets a spec file in `docs/research/components/` BEFORE dispatching builders.

### 9. Build Must Always Compile

Verify `npx tsc --noEmit` passes before finishing. After merges, verify `npm run build`.

## Phase 1: Reconnaissance

### Available Tools Check

**Orden de prioridad para screenshots y extracción:**

| Prioridad | Herramienta | Screenshots | Extracción | Setup |
|-----------|-------------|-------------|------------|-------|
| 1 | Chrome DevTools MCP | ✅ Excelente | ✅ Completo | Required |
| 2 | Firecrawl | ✅ Bueno | ✅ Completo | API Key |
| 3 | Browserbase | ✅ Excelente | ✅ Completo | Cuenta |
| 4 | Apify | ⚠️ Básico | ✅ Bueno | Cuenta |
| 5 | Simplerasp | ❌ No | ✅ Básico | No |
| 6 | WebFetch | ❌ No | ⚠️ HTML estático | No (siempre) |

### Screenshots

**Usar en este orden:**
1. **Chrome DevTools MCP** — screenshot completo de página, DOM, console, network
2. **Browserbase** — screenshots avanzados si está configurado
3. **Firecrawl interact** — para extracción con interacción

Guardar screenshots en `docs/design-references/`

### Global Extraction

Extract from the page:

**Fonts** — Check `<link>` tags for Google Fonts, document families, weights, styles.

**Colors** — Extract palette from computed styles. Update `src/app/globals.css`.

**Favicons & Meta** — Download favicons, OG images to `public/seo/`.

**Global UI patterns** — Custom scrollbar, scroll-snap, animations, smooth scroll libs.

### Extract Images and Videos

**Critical for a complete clone:**

1. **Find all images:**
   - From HTML: `<img src="...">`, `<picture>`, `srcset`
   - From CSS: `background-image`, `background`
   - From HTML: `<video>`, `<source>`, `<iframe>`

2. **Download to local:**
   ```bash
   # Create directory for assets
   mkdir -p public/images public/videos public/seo

   # Download each image/video found
   curl -L "IMAGE_URL" -o "public/images/FILENAME"
   # or use wget
   wget -P public/images "IMAGE_URL"
   ```

3. **Preserve original filenames** when possible, or use meaningful names (e.g., `hero-background.webp`, `footer-logo.png`)

4. **Track all downloaded assets** in a list to reference in component specs

**Note:** Sin Chrome DevTools MCP, Firecrawl o Browserbase no hay screenshots — enfocate en extraer la estructura HTML y descargar assets manualmente.

### Interaction Sweep

**Scroll sweep:** Scroll slowly, observe header changes, animations, scroll-snap points.

**Click sweep:** Click interactive elements, record what happens.

**Hover sweep:** Hover over elements with hover states.

**Responsive sweep:** Test at Desktop (1440px), Tablet (768px), Mobile (390px).

Save to `docs/research/BEHAVIORS.md`.

### Page Topology

Map every section: visual order, fixed/sticky overlays, layout structure, interaction model.

Save to `docs/research/PAGE_TOPOLOGY.md`.

## Phase 2: Foundation Build

Sequential:

1. **Update fonts** in `layout.tsx`
2. **Update globals.css** with color tokens, spacing, animations
3. **Create TypeScript interfaces** in `src/types/`
4. **Extract SVG icons** to `src/components/icons.tsx`
5. **Download assets** to `public/`
6. Verify: `npm run build`

## Phase 3: Component Specification & Dispatch

For each section: **extract**, **write spec**, **dispatch builders**.

### Step 1: Extract

1. **Screenshot** the section
2. **Extract CSS** for each element
3. **Extract multi-state styles** (scroll, hover, active)
4. **Extract content** — text, alt attributes, aria labels
5. **Identify assets** the section uses

### Step 2: Write Component Spec

**File:** `docs/research/components/<component-name>.spec.md`

```markdown
# <ComponentName> Specification

## Overview
- **Target file:** `src/components/<ComponentName>.tsx`
- **Screenshot:** `docs/design-references/<screenshot>.png`
- **Interaction model:** <static | click-driven | scroll-driven | time-driven>

## DOM Structure
<Element hierarchy>

## CSS Values (exact)
### Container
- display: ...
- padding: ...

### <Child element>
- fontSize: ...
- color: ...

## States & Behaviors
### <Behavior name>
- **Trigger:** <mechanism>
- **State A:** ...
- **State B:** ...
- **Transition:** ...

## Assets
- Background: `public/images/<file>.webp`
- Icons: <Icon> from icons.tsx

## Content (verbatim)
<All text from site>

## Responsive
- **Desktop:** ...
- **Mobile:** ...
- **Breakpoint:** ~<N>px
```

### Step 3: Dispatch Builders

Use `delegate()` to dispatch builder agents:

**Simple section:** One builder.

**Complex section:** Break into sub-components.

**What builders receive:**
- Full spec file content
- Screenshot path
- Which components to import
- Target file path
- Verify `npx tsc --noEmit`

### Step 4: Merge

As builders complete:
- Merge to main
- Verify `npm run build`

## Phase 4: Page Assembly

- Import all section components in `src/app/page.tsx`
- Implement layout from topology
- Connect content to props
- Verify `npm run build`

## Phase 5: Visual QA

1. Compare original vs clone side-by-side
2. Test at desktop and mobile
3. Test all interactions

## Pre-Dispatch Checklist

- [ ] Spec file written
- [ ] CSS values extracted (not estimated)
- [ ] Interaction model identified
- [ ] All states captured
- [ ] All images identified
- [ ] Responsive behavior documented
- [ ] Content verbatim from site

## What NOT to Do

- Don't build click-based when original is scroll-driven
- Don't extract only default state
- Don't miss layered images
- Don't approximate CSS — extract exact values
- Don't build everything in one commit
- Don't skip asset extraction
- Don't give builders too much scope
- Don't dispatch without spec file

## Completion

Report:
- Total sections built
- Total components created
- Total spec files written
- Total assets downloaded
- Build status
- Visual QA results
