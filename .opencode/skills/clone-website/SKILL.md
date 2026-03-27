---
name: clone-website
description: >
  Reverse-engineer and clone a website in one shot — extracts assets, CSS, and content section-by-section and dispatches builder agents to rebuild. Use this whenever the user wants to clone, replicate, rebuild, reverse-engineer, or copy any website. Also triggers on phrases like "make a copy of this site", "rebuild this page", "pixel-perfect clone". Provide the target URL as an argument.
  Trigger: clone, replicate, rebuild, reverse-engineer, copy website, clone this site, rebuild this page, pixel-perfect clone
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.1"
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
---

## When to Use

- User wants to clone/replicate any website
- Rebuild a site from a URL
- Reverse-engineer a design
- Create a pixel-perfect copy of a webpage

## Prerequisites

### Available Extraction Tools (in priority order)

#### 1. WebFetch (Free - Default)

**OpenCode's built-in tool** — no installation needed, works out of the box.

```bash
# Use webfetch to get HTML
webfetch(url="https://example.com", format="markdown")
```

- ✅ Works immediately, no setup
- ⚠️ Limited to static HTML (no JS rendering)
- Best for: Simple sites, fallback option

#### 2. Simplerasp.io (Free tier - No auth for basic)

Free web scraper with generous free tier.

**Usage:**
```bash
# Via their web interface: https://simplescraper.io/
# Or API with free key
```

- ✅ No authentication for basic use
- ✅ Good for static pages
- Best for: Quick extraction without setup

#### 3. Apify (Free tier)

Has free text scraper actors.

**Usage:**
```bash
npx apify run karamelo/text-scraper-free
```

- ✅ Free tier available
- ⚠️ Requires Apify account
- Best for: When you need more than basic scraping

#### 4. Firecrawl (Preferred - Requires API key)

Best extraction tool but requires authentication.

**Installation:**
```bash
npm install -g firecrawl-cli
```

**Setup before using:**
```bash
# Option 1: Login interactively
npx firecrawl login

# Option 2: Set API key
export FIRECRAWL_API_KEY="your-key-here"
# or
npx firecrawl config set-api-key YOUR_API_KEY
```

**Usage:**
```bash
npx firecrawl https://example.com
npx firecrawl interact https://example.com  # For interaction
```

- ✅ Best quality extraction
- ✅ CSS, JS rendering, assets
- ⚠️ Requires free API key (get at https://firecrawl.dev)
- Best for: Complex sites, full extraction

#### 5. Browserbase (Advanced - Paid)

For screenshots and full browser automation.

- ✅ Real browser, screenshots, full JS
- ⚠️ Requires account and payment
- Best for: When you need visual verification

### Tool Selection Flow

```
1. Start with WebFetch (always works)
   ↓ If not enough
2. Try Simplerasp.io or Apify (free, minimal setup)
   ↓ If still not enough
3. Configure Firecrawl with API key (best quality)
   ↓ If need screenshots
4. Use Browserbase (paid, advanced)
```

**IMPORTANT:** Before starting a clone:
- If you have Firecrawl API key → Use it for best results
- If not → Start with WebFetch, it's built-in
- Don't block the user waiting for setup — start with what works

### Check Firecrawl Availability

At start of clone, check if Firecrawl is configured:

```bash
npx firecrawl --version
npx firecrawl test  # Will prompt for auth if not configured
```

If not available → Use WebFetch and inform user:
"Firecrawl not configured. Using WebFetch for basic extraction. For full results, set FIRECRAWL_API_KEY."

## Pre-Flight

1. Read `TARGET.md` for URL and scope. If URL doesn't match, update it.
2. Check available extraction tools:
   - Run `firecrawl --version` to check if Firecrawl is configured
   - If not, WebFetch is always available (built into OpenCode)
3. **Inform user** about available tools:
   - If Firecrawl available: "Using Firecrawl for best extraction"
   - If not: "Firecrawl not configured. Using WebFetch. For full results, set FIRECRAWL_API_KEY"
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

At the start, determine which extraction tool is available:

```bash
# Check what's available
which firecrawl || echo "Firecrawl not found"
firecrawl --version 2>/dev/null || echo "Firecrawl not configured"
```

Use the best available tool according to the priority order in Prerequisites section.

### Screenshots

Use whatever is available:
- Browserbase (if configured)
- Firecrawl with /interact mode
- WebFetch (for HTML only, no screenshots)

Save screenshots to `docs/design-references/`

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

**Note:** Without Firecrawl/Browserbase, you won't get screenshots — focus on extracting the HTML structure and downloading all visible assets manually via URLs found in the HTML.

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