# trenck.net review, page by page

Reviewed 2026-09-29 against the checklist in [REPOS.md](REPOS.md).

## Method and confidence

1. First pass: a summarizing page fetch. It was wrong in several places (it claimed missing alt text, no résumé `<h1>`, placeholder-only form labels, system-default fonts). Those claims are retracted below.
2. Second pass: the live DOM in a real browser. This is the source for everything marked verified. Checked: headings, alt text, landmarks, form labels, fonts, text contrast (WCAG ratios computed per text node), horizontal overflow at 375px, SVG diagram markup.
3. Tool pass (Node 24 installed 2026-09-29): Lighthouse 13 on nine pages and `npx impeccable detect https://trenck.net`. Results are in the next section.
4. Not done: visual judgment of every page by eye. Only the home page was screenshotted at desktop width.

## Tool results

**Lighthouse (headless Chrome, mobile profile, which is Lighthouse's default. I first wrote "desktop" here by mistake. One run per page; a second sweep gave the same scores except where noted)**

| Page | Perf | A11y | Best practices | SEO | LCP | CLS |
|------|------|------|----------------|-----|-----|-----|
| Home | 51 | 100 | 77 | 100 | 3.3 s | 0 |
| About | 96 | 100 | 77 | 100 | 2.7 s | 0 |
| Experience | 96 | 100 | 77 | 100 | 2.3 s | 0 |
| Skills | 94 | 100 | 77 | 100 | 3.0 s | 0 |
| Resume | 97 | 100 | 77 | 100 | 2.5 s | 0 |
| Projects | 95 | 100 | 77 | 100 | 2.7 s | 0 |
| Homelab | 94 | 100 | 77 | 100 | 2.9 s | 0 |
| Blog | 97 | 100 | 77 | 100 | 2.4 s | 0 |
| Contact | 97 | 100 | 77 | 100 | 2.3 s | 0 |

- Accessibility 100 and CLS 0 everywhere. The missing badge dimensions I flagged earlier cause no measured layout shift, so that item is dropped.
- Best practices 77 on every page comes from console errors and deprecation warnings that trace to Cloudflare, not site code: a blocked `cloudflareinsights` beacon (connection refused in this environment) and `cdn-cgi/challenge-platform` scripts using deprecated APIs.
- Home performance 51 was an intermittent artifact, not a home page defect. Runs 1 and 2 (home) showed about 9.3 s Total Blocking Time from one 10 s unattributed long task. Later runs of home scored 92 to 93 whether or not Cloudflare or analytics scripts were blocked. In the second full sweep the same 10 s stall hit `/experience/` instead (perf 54, TBT 10.9 s) and home scored 93. It moves between pages, site scripts account for under 0.5 s, and a real browser showed no long tasks. Best explanation is a Cloudflare challenge-script or headless timing stall, not proven. Treat as noise unless it appears in field data.
- Mistake caught in my first Lighthouse run: I requested `https://trenck.net//` for the home page, which produced a false canonical failure. Rerun with the correct URL.

**impeccable detect (27 findings, exit 0)**

| Rule | Count | My read |
|------|-------|---------|
| low-contrast | 12 | False positives. Hero text is ink #1A1D24 on paper #F5F3EC, 15.2:1. Body copy #454A54 is 8.0:1, slate #5A5F68 is 5.8:1. Lighthouse's axe color-contrast audit passes on all nine pages. The tool's estimate through the translucent gradient overlays is what fails. |
| radial-spotlight-glow | 5 | Real. Gold radial haze behind the hero, contact block and footer. The tool calls it a reflex AI decoration. Taste call. |
| ai-color-palette | 4 | Matched `--c-signal` #2FA39A (a teal) used at 9 to 10% alpha in radial gradients on the hero, latest-posts block, contact block and footer. Same radial-glow motif as the row above, so one change fixes both. |
| dark-glow | 3 | Colored box-shadow (#00142d) on the dark header or panels. Swap for neutral elevation if disliked. |
| cream-palette | 1 | Real. Page background rgb(245, 243, 236). The tool treats warm cream as a default. Taste call, and it fits the brand. |
| wide-tracking | 1 | Wide letter spacing on body-level text, probably the uppercase eyebrow. |
| hero-eyebrow-chip | 1 | The small uppercase "IT SYSTEMS ENGINEER & INFRASTRUCTURE ARCHITECT" label above the name. |

## Decisions (2026-09-29)

Arly chose to treat all four taste flags as things to change:

1. Radial gold and teal glows behind hero, latest posts, contact block and footer: remove or replace with a flat or material treatment. This also clears the ai-color-palette hits.
2. Colored navy box-shadow glow: swap for neutral elevation shadows (the site already defines `--sh-1` and `--sh-2`).
3. Cream background `--c-paper` #F5F3EC: replace with a deliberate alternative. Note that this token is the ground for the whole palette, so contrast ratios above need rechecking after any change.
4. Uppercase tracked eyebrow above the hero name: drop or restyle. Superseded: kept uppercase and tracked, moved below the name (see Applied).

The site source is not in this repo, so none of this is applied. Two checks stay valid after any redesign: rerun `npx impeccable detect https://trenck.net` and the Lighthouse accessibility audit.

## Site-wide (verified)

- Type is deliberate: Sora for headings, Libre Franklin for body, 16px on a 24px line height. Not system defaults.
- Palette: navy header, warm cream ground, a network-graph hero. Neither monochrome nor a gradient-and-glow template.
- Every page has one `<h1>`, one `<main>`, `lang="en-US"`, a viewport meta, a meta description, and a skip link.
- Navs carry `aria-label`s (Primary, Footer, plus "Résumé sections" and "On this page" where relevant).
- No horizontal overflow at 375px on any of the nine main pages checked.
- No text failed WCAG AA contrast on the home page at desktop width. Other pages were not run for contrast.
- Every content image has descriptive alt text.

## Page by page

| Page | Verified | Open items |
|------|----------|------------|
| Home `/` | One h1, sensible h2s, two images with alt, no overflow, no contrast failures. | "What I run" is three h3 feature blocks, the default three-pillar pattern. Two generic "read" links. |
| About `/about/` | Portrait with alt, clean heading order, no overflow. | "At a glance" styling not judged visually. |
| Experience `/experience/` | Four responsibility blocks, three roles, no images. | One generic "read" link. Text-only page, could use a timeline treatment. |
| Skills `/skills/` | All ten badges have alt. | Badge images lack `width` and `height`, but Lighthouse measured CLS 0, so no visible impact. |
| Resume `/resume/` | Has an h1, a "Résumé sections" nav, two header landmarks. | Acronym density is a content call, not a defect. Print stylesheet not tested. |
| Projects `/projects/` | Rack photo has alt. | Two generic "read" links ("READ ABOUT" repeated). Homelab rack photo file is named `headshot-full-...`, a naming oddity only. |
| Homelab `/homelab/` | Both diagrams are SVGs with `role="img"`, `<title>` and `<desc>`. On mobile each swaps to a text alternative (a flow list and an ordered list). | Two generic "read" links. The same rack photo file is reused on home, projects and here. |
| Blog `/blog/` | Search input has a real label. Featured post plus "Earlier posts" list. | Not visually reviewed for date and tag contrast. |
| Contact `/contact/` | Every field has a real `<label>`, required fields flagged, a honeypot, a consent checkbox. | Inline error states and the submit flow were not exercised (submitting would send a real message). |
| Privacy, Terms | No uppercase text and nothing under 13px. Article body is 19px at about 68 characters per line, which is fine. (An earlier version of this row said 14px and 94 characters. That was wrong: it measured the small "Last updated" line, not the article.) The h1 was 82px, the only inner pages not stepped down. Fixed: now 64px like the rest. |

## Retracted from the first pass

- "Missing alt text on the rack photo and cert badges": alt text is present on all of them.
- "Résumé has no h1": it has one.
- "Form labels may be placeholders": labels are real.
- "System-default typography": the site loads Sora and Libre Franklin.
- "Homelab diagrams may fail screen readers": they have title and desc, plus mobile text alternatives.

## Genuine findings so far

1. Investigate the home page Lighthouse performance score of 51 on a real device before deciding it matters.
2. Replace the generic "read" link text on home, experience, projects and homelab with names, or add `aria-label`s that include the target.
3. Consider replacing the home "What I run" three-pillar block. Low priority, taste call.
4. Reuse of one rack photo on three pages is fine, but a different crop per page would reduce the repetition.

## Source-level findings (read from the site's own repo, 2026-09-29)

The site is hand-written static HTML with one stylesheet. Everything in this section can be seen in the HTML and CSS the public site serves.

- **Dark mode exists.** The stylesheet has 12 `prefers-color-scheme: dark` blocks, and `--c-paper`, `--c-sand`, `--c-sand-2` and `--c-code-bg` each have a dark value (paper #0A1526). This corrects the earlier note that dark mode was unsupported. Any palette change needs a light and a dark value, and the dark theme was never reviewed.
- **The glows are site-wide, not four spots.** There are 50 `radial-gradient` declarations in the stylesheet, which is about 25 rules once light and dark copies are counted. They sit on the hero of every page (home, about, experience, skills, projects, homelab, blog, contact, résumé, 404) plus several section blocks (homelab intro, rack, services, stack; about career and lab; experience areas and close; projects feature and close) and the footer. Removing them is one pass through those selectors, not four edits.
- **Shadows** are all the same navy-tinted family, `rgba(0,20,45,...)`, at 0.12 to 0.22 opacity and large blur (for example 0 24px 64px). That tint is what impeccable calls a colored glow. Replace the color with plain black at lower opacity, or keep the size and drop the tint.
- **The eyebrow is inline markup, not a class.** On the home page it is a `<p>` with inline styles (12px, .24em tracking, uppercase gold-dark). The same wide-tracking pattern appears on nearly every page (contact, homelab, privacy, terms, projects and the four project pages, résumé, about, skills), so "drop the eyebrow" is a site-wide edit, and it is the site's shared page-header pattern.
- **Cream is hard-coded outside the tokens** in a few places: `site.webmanifest` (`background_color`), an inline style on the certifications page, and the artwork behind the social card and banner. Changing `--c-paper` alone will leave those, and the generated OG card images, cream.
- `theme-color` is navy #002349 and does not need to change.

## Applied on a branch (2026-09-29)

All four decisions were implemented on branch `design-cool-ground` in a local clone of the site repo. Merged to the site repo's main branch on 2026-09-30 through a reviewed pull request that passed its CI checks. Merging does not publish: deploying is a separate manual step. The commit leaves out unrelated uncommitted work that was already in the clone.

- Radial glows: 77 `radial-gradient` layers removed from 26 rule groups. Every affected rule kept its linear layer, so no background became empty.
- Shadows: navy tint replaced with black in the stylesheet (9 places) and 4 inline shadows in page markup.
- Ground: `--c-paper` #F5F3EC to #F4F6F9, with `--c-sand`, `--c-sand-2`, `--c-code-bg`, the four `--c-line*` tokens and `--c-field-line` (now #78828F, 3.6:1 on the new ground and 3.9:1 on white) retinted cool, plus the paper-derived rgba fades. `site.webmanifest` `background_color` and one inline style on the certifications page updated.
- Eyebrow: first done as a sentence-case line under the home page name, then reversed by Arly (2026-09-30). Final state on the home page: the role line is uppercase and letter-spaced, in `--c-gold-dark`, placed below the name. The About page keeps its uppercase line above the title. Other pages' similar labels were left alone. As a result the impeccable `wide-tracking` and `hero-eyebrow-chip` findings are expected to remain.
- The stylesheet was re-hashed with the site's own script, which rewrote the stylesheet link in every page, including drafts.

**Results against a local copy of the branch**

| Check | Before | After |
|-------|--------|-------|
| Site's own `check --strict` | pass | pass, 37 pages |
| impeccable findings | 27 | 6, all `low-contrast` (the same false positives as before) |
| Lighthouse accessibility, 9 pages | 100 | 100 |
| Lighthouse best practices, 9 pages | 77 | 100 (the 77 was Cloudflare scripts, absent locally, which confirms that read) |
| Lighthouse axe color-contrast | pass | pass on all 9 |
| Cumulative layout shift | 0 | 0 |

Lighthouse performance is not comparable, because the local server has no compression or caching (84 to 96 across pages).

**Looked at by eye:** light theme home page at 1280 wide, dark theme About page at 1280 wide. Both read correctly. Dark theme tokens were not edited. The browser's color-scheme emulation flipped unpredictably between page loads, so dark mode on the other pages was not seen.

**Screenshot pass (375 wide, nine pages):** no horizontal overflow in light or dark, body background is the new #F4F6F9 in light and #0A1526 in dark on every page, and dark-theme headings are light on dark on every page. Screenshots were taken of the home page (dark), contact (light and dark) and homelab (dark). Several dark-theme shots caught the page mid fade-in, so text looked dim in them. That is the existing reveal animation, not a change from this work. The 1280 pass was done for the home page (light) and About (dark) only.

**OG card and banner artwork:** the cream hex in the card and banner artwork was updated. A preview render of the OG card looked right on the new ground. No new image was published: the cards are cached immutably, so a new file name has to be repointed in every page and template first. The card keeps its uppercase tracked role line, which no longer matches the home page. The social banner background still uses its own navy radial gradient, which was not among the flagged items.

**Not done:** publishing a new OG image; the other uppercase labels.

## Skill-lens review, page by page (2026-09-29)

Lenses: the `frontend-design` skill (generic-template tells) and the audit checklist from the `web-design` skill. That skill's build demands, such as motion quotas, scroll-jacking and WebGL, were not applied: they suit a marketing site, and this one is a static, hardened engineering portfolio where those would cost performance and clarity. Measured on the committed branch state, served locally at 1280 wide, light theme. The screenshots caught pages mid fade-in, so visual judgments below rest mostly on measurements, not on looking.

**Site-wide, passes:** two border radii only (2px controls, 6px cards) and at most two distinct shadows per page, so none of the "same rounded card everywhere" look. No arrow suffixes, no middle-dot meta strings (one exception, homelab), no numbered markers, no spaced em-dash labels. Focus-visible rules (24), hover rules (82) and reduced-motion blocks (10) exist. Inline hex is 0 to 4 per page. Body text is 18 to 20px.

**Site-wide, findings:**
1. All-caps tracked labels are the site's main "template" tell. Counts of uppercase text elements in main content: skills 53, about 13, resume 15, projects 11, experience 8, contact 7, home 7. Correction: the skills count was inflated. It counted any all-caps text, which includes real acronyms (SAML SSO, DNS / DHCP, COMPTIA, ISC2). The label-style caps there were the credential issue and expiry lines and the dates on Experience. The skill calls out all caps and eyebrow labels above content specifically.
2. Every content page opens with an 82px h1 (home 100px). Five pages compete for the same loudness, against the "spend boldness in one place" rule. Inner pages could drop to roughly 56px and let the home page and homelab diagrams carry the weight.
3. The same network-graph hero art repeats on every page. It is on brand, but the memorable element is the homelab diagrams, which appear on one page.

| Page | Notes from the lenses |
|------|----------------------|
| Home | 7 uppercase items (buttons, section links), 8 wide-tracked. Paragraph measure about 77 characters, at the limit. 5 items under 13px. The role line is uppercase and tracked, by choice, below the name. |
| About | Still opens with the uppercase tracked role line that the home page no longer has. Paragraph measure about 95 characters, well over the 80 limit. Label trio (Location, Experience, Credentials) is all caps. |
| Experience | Measure about 69, fine. Dates set in all caps ("MAY 2025 TO PRESENT"), which reads as label chrome, not information. |
| Skills | 53 uppercase elements, but most are acronyms or issuer names that should stay caps. The real label caps were the credential lines ("ISSUED JUN 2021 / VALID TO NOV 2027"). Fixed, see below. |
| Resume | Body 14px, 12 elements under 13px, measure about 81. Acceptable for a print-oriented page, but the small sizes are worth a check against the print stylesheet. |
| Projects | "FEATURED: DOCKER COMPOSE" is a tracked eyebrow above the feature title, plus "READ ABOUT ..." links in caps. Language badges (BASH, POWERSHELL) in caps. |
| Homelab | Best page structurally. Seven " · " joined meta strings are the only instance of that tell on the site. Measure about 59, good. |
| Blog | No uppercase in main content, 10 elements under 13px (dates and tags). Measure about 71. Cleanest of the content pages. |
| Contact | Labels (Response time, Location, Elsewhere) and the submit button in caps. Measure about 44, comfortable. |
| Privacy, Terms | Run afterwards. No uppercase text and nothing under 13px. Two findings: body text is 14px with lines about 94 characters long, well over the 80 limit for long legal prose; and the h1 is still 82px because the step-down did not cover these pages, so they are now the largest inner-page headings. Neither was changed. |

**Implemented and merged (2026-09-29 to 09-30):** (a) credential lines on Skills and dates on Experience in sentence case with no tracking, (c) About body paragraphs held to 36em (measured 57 to 65 characters per line, was about 95), (d) inner-page h1 on About, Experience, Skills, Projects, Homelab, Blog and topic pages at `--fs-display-sm` (64px at 1280 wide, was 82px). Verified: the site's strict check passes on 37 pages, Lighthouse accessibility and SEO stay 100 on the six changed pages, impeccable stays at 6 findings (the same false-positive contrast items).

**Not done, chosen not to:** (b) the eyebrow treatment on About and Projects (About keeps its uppercase role line above the title, by choice).

**Dark theme at 1280 wide (all 11 pages, after the changes):** each page reports the dark scheme, no horizontal overflow, and no text failing WCAG AA against its nearest solid background (47 to 140 text elements checked per page; text over gradient or image backgrounds is not covered by that method). One dark screenshot was looked at (terms).

## Still to run

- Lighthouse desktop preset (`--preset=desktop`); only the mobile default was run.
- A by-eye pass on each page: most screenshots so far caught the existing fade-in and were unreadable.
- Dark mode renders differently: see the source-level section. It was not looked at in a browser.
