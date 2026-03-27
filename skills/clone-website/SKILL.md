---
name: clone-website
description: >
  Reverse-engineer and clone a website in one shot — extracts assets, CSS, and content section-by-section and proactively dispatches parallel builder agents. Use this whenever the user wants to clone, replicate, rebuild, reverse-engineer, or copy any website. Also triggers on phrases like "make a copy of this site", "rebuild this page", "pixel-perfect clone". Provide the target URL as an argument.
  Trigger: clone, replicate, rebuild, reverse-engineer, copy website, clone this site, rebuild this page, pixel-perfect clone
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## When to Use

- User wants to clone/replicate any website
- Rebuild a site from a URL
- Reverse-engineer a design
- Create a pixel-perfect copy of a webpage

## Pre-Flight

1. Read `TARGET.md` for URL and scope. If the URL doesn't match the provided argument, update it.
2. Verify the base project builds: `npm run build`. The Next.js + shadcn/ui + Tailwind v4 scaffold should already be in place. If not, tell the user to set it up first.
3. Create the output directories if they don't exist: `docs/research/`, `docs/research/components/`, `docs/design-references/`, `scripts/`.

## Guiding Principles

### 1. Completeness Beats Speed

Every builder agent must receive **everything** it needs to do its job perfectly: screenshot, exact CSS values, downloaded assets with local paths, real text content, component structure. If a builder has to guess anything — a color, a font size, a padding value — you have failed at extraction.

### 2. Small Tasks, Perfect Results

When an agent gets "build the entire features section," it glosses over details. When it gets a single focused component with exact CSS values, it nails it every time.

**Complexity budget rule:** If a builder prompt exceeds ~150 lines of spec content, the section is too complex for one agent. Break it into smaller pieces.

### 3. Real Content, Real Assets

Extract the actual text, images, videos, and SVGs from the live site. This is a clone, not a mockup.

**Layered assets matter.** A section that looks like one image is often multiple layers — a background watercolor/gradient, a foreground UI mockup PNG, an overlay icon.

### 4. Foundation First

Nothing can be built until the foundation exists: global CSS with the target site's design tokens (colors, fonts, spacing), TypeScript types for the content structures, and global assets.

### 5. Extract How It Looks AND How It Behaves

A website is not a screenshot — it's a living thing. Elements move, change, appear, and disappear in response to scrolling, hovering, clicking, resizing, and time.

### 6. Identify the Interaction Model Before Building

Is this section driven by clicks, scrolls, hovers, time, or some combination?

### 7. Extract Every State, Not Just the Default

Many components have multiple visual states — a tab bar shows different cards per tab, a header looks different at scroll position 0 vs 100.

### 8. Spec Files Are the Source of Truth

Every component gets a specification file in `docs/research/components/` BEFORE any builder is dispatched.

### 9. Build Must Always Compile

Every builder agent must verify `npx tsc --noEmit` passes before finishing. After merging worktrees, verify `npm run build` passes.

## Phase 1: Reconnaissance

Navigate to the target URL.

### Screenshots
- Take **full-page screenshots** at desktop (1440px) and mobile (390px) viewports
- Save to `docs/design-references/` with descriptive names

### Global Extraction
Extract these from the page before doing anything else:

**Fonts** — Inspect `<link>` tags for Google Fonts or self-hosted fonts. Document every family, weight, and style actually used.

**Colors** — Extract the site's color palette from computed styles across the page. Update `src/app/globals.css` with the target's actual colors.

**Favicons & Meta** — Download favicons, apple-touch-icons, OG images to `public/seo/`.

**Global UI patterns** — Identify any site-wide CSS or JS: custom scrollbar, scroll-snap, keyframe animations, backdrop filters, smooth scroll libraries.

### Mandatory Interaction Sweep

**Scroll sweep:** Scroll the page slowly. At each section, pause and observe:
- Does the header change appearance?
- Do elements animate into view?
- Are there scroll-snap points?

**Click sweep:** Click every element that looks interactive.

**Hover sweep:** Hover over every element that might have hover states.

**Responsive sweep:** Test at 3 viewport widths: Desktop (1440px), Tablet (768px), Mobile (390px).

Save all findings to `docs/research/BEHAVIORS.md`.

### Page Topology
Map out every distinct section of the page. Document their visual order, fixed/sticky overlays, layout structure, and interaction model.

Save this as `docs/research/PAGE_TOPOLOGY.md`.

## Phase 2: Foundation Build

This is sequential:

1. **Update fonts** in `layout.tsx`
2. **Update globals.css** with the target's color tokens, spacing values, animations
3. **Create TypeScript interfaces** in `src/types/`
4. **Extract SVG icons** to `src/components/icons.tsx`
5. **Download global assets** to `public/`
6. Verify: `npm run build` passes

## Phase 3: Component Specification & Dispatch

For each section: **extract**, **write the spec file**, then **dispatch builders**.

### Step 1: Extract

1. **Screenshot** the section in isolation
2. **Extract CSS** for every element using getComputedStyle
3. **Extract multi-state styles** for scroll-triggered, hover, active states
4. **Extract real content** — all text, alt attributes, aria labels
5. **Identify assets** this section uses

### Step 2: Write the Component Spec File

**File path:** `docs/research/components/<component-name>.spec.md`

```markdown
# <ComponentName> Specification

## Overview
- **Target file:** `src/components/<ComponentName>.tsx`
- **Screenshot:** `docs/design-references/<screenshot-name>.png`
- **Interaction model:** <static | click-driven | scroll-driven | time-driven>

## DOM Structure
<Describe the element hierarchy>

## Computed Styles (exact values from getComputedStyle)
### Container
- display: ...
- padding: ...
- maxWidth: ...

### <Child element>
- fontSize: ...
- color: ...

## States & Behaviors
### <Behavior name>
- **Trigger:** <exact mechanism>
- **State A (before):** ...
- **State B (after):** ...
- **Transition:** ...

## Assets
- Background image: `public/images/<file>.webp`
- Icons used: <ArrowIcon>, <SearchIcon> from icons.tsx

## Text Content (verbatim)
<All text content from the live site>

## Responsive Behavior
- **Desktop (1440px):** ...
- **Mobile (390px):** ...
- **Breakpoint:** ~<N>px
```

### Step 3: Dispatch Builders

Use the `delegate()` tool to dispatch builder agents in background:

**Simple section:** One builder agent gets the entire section.

**Complex section:** Break it up. One agent per sub-component.

**What every builder agent receives:**
- The full contents of its component spec file
- Path to the section screenshot
- Which shared components to import
- The target file path
- Instruction to verify with `npx tsc --noEmit` before finishing

### Step 4: Merge

As builder agents complete:
- Merge their branches into main
- Verify the build still passes: `npm run build`

## Phase 4: Page Assembly

After all sections are built:
- Import all section components in `src/app/page.tsx`
- Implement the page-level layout from topology doc
- Connect real content to component props
- Verify: `npm run build` passes

## Phase 5: Visual QA Diff

After assembly, do NOT declare complete. Take side-by-side comparison screenshots:
1. Open original site and clone side-by-side
2. Compare section by section at desktop and mobile
3. Test all interactive behaviors: scroll, click, hover

## Pre-Dispatch Checklist

- [ ] Spec file written with ALL sections filled
- [ ] Every CSS value from getComputedStyle()
- [ ] Interaction model identified and documented
- [ ] Every state's content and styles captured
- [ ] All images identified (including overlays)
- [ ] Responsive behavior documented
- [ ] Text content verbatim from site
- [ ] Builder prompt under ~150 lines

## What NOT to Do

- Don't build click-based tabs when the original is scroll-driven
- Don't extract only the default state
- Don't miss overlay/layered images
- Don't approximate CSS classes — extract exact values
- Don't build everything in one commit
- Don't skip asset extraction
- Don't give a builder agent too much scope
- Don't dispatch builders without a spec file

## Completion

When done, report:
- Total sections built
- Total components created
- Total spec files written
- Total assets downloaded
- Build status
- Visual QA results
