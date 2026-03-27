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

### Required: Firecrawl (Primary)

**Firecrawl** is the recommended extraction tool. It provides:
- HTML content extraction
- CSS extraction
- Image/assets discovery
- JavaScript rendering
- `/interact` mode for clicking, scrolling, interacting

**Installation:**
```bash
npm install -g firecrawl-cli
# or use the MCP server
```

**Usage in skill:**
```
Use Firecrawl to extract the page:
npx firecrawl https://example.com
# or with interact mode
npx firecrawl interact https://example.com
```

### Optional: Browserbase (Advanced)

For screenshots and full browser interaction when Firecrawl isn't enough:
- Real browser in the cloud
- Screenshots at any viewport
- Full JS interaction (clicks, scrolls, hovers)

**Install:** https://www.browserbase.com/

### Fallback: WebFetch

If no external tools available, use OpenCode's `webfetch` to get the HTML and extract what you can manually.

## Pre-Flight

1. Read `TARGET.md` for URL and scope. If URL doesn't match, update it.
2. Verify project exists:
   - If `package.json` doesn't exist, prompt user to initialize a Next.js + shadcn/ui + Tailwind v4 project first
   - If exists but doesn't build (`npm run build` fails), fix or prompt user
3. Create directories: `docs/research/`, `docs/research/components/`, `docs/design-references/`, `scripts/`.
4. **Clean up template files**: If copying from any template that includes CLAUDE.md, delete it — OpenCode uses AGENTS.md, not CLAUDE.md.

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

### Screenshots

Use Browserbase or take screenshots via Firecrawl's `/interact`:
- Desktop (1440px) and mobile (390px) viewports
- Save to `docs/design-references/`

### Global Extraction

Extract from the page:

**Fonts** — Check `<link>` tags for Google Fonts, document families, weights, styles.

**Colors** — Extract palette from computed styles. Update `src/app/globals.css`.

**Favicons & Meta** — Download favicons, OG images to `public/seo/`.

**Global UI patterns** — Custom scrollbar, scroll-snap, animations, smooth scroll libs.

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