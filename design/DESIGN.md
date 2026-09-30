# trenck.net design direction

Proposal, 2026-09-29. Applies the four decisions in [TRENCK-NET-REVIEW.md](TRENCK-NET-REVIEW.md). The site source is not in this repo, so this is a spec to hand to whoever edits the site. Token names below are the ones the live CSS already uses.

## Keep

Navy `--c-navy` #002349 and gold as the brand pair. Sora headings, Libre Franklin body. The network-graph hero motif. Real diagrams and photos. The accessible structure that already scores 100 in Lighthouse.

## Change

| Flag | Change |
|------|--------|
| Radial gold and teal glows (hero, latest posts, contact, footer) | Delete the `radial-gradient(...)` layers. Keep the existing bottom fade in the hero only if it is needed to blend the graph into the page. Give sections definition with flat bands (paper and white, or navy) and the existing 1px `--c-line` rules. |
| Colored navy box-shadow glow | The `--sh-1` and `--sh-2` tokens are themselves tinted `rgba(0,20,45,...)` (an earlier draft of this file wrongly called them neutral). Change the tint to `rgba(0,0,0,...)` in the tokens, the stylesheet's own shadows, and the four inline shadows in page markup. |
| Cream ground `--c-paper` #F5F3EC | Replace with a cool off-white, proposed **#F4F6F9**. Also retint `--c-sand` #ECE8DC, `--c-sand-2`, `--c-code-bg` and the `--c-line*` family toward the same cool hue so warm greys do not clash. |
| Uppercase tracked eyebrow in the hero | Remove it, or fold the role into the lead sentence ("IT systems engineer and infrastructure architect" as plain sentence-case text under the name). The `<title>` and meta already carry the role for search. |

## Contrast on the new ground

Ratios against #F4F6F9, computed with the WCAG formula.

| Token | Value | Ratio | Use |
|-------|-------|-------|-----|
| `--c-ink` | #1A1D24 | 15.6 | Headings |
| `--c-body` | #454A54 | 8.2 | Body |
| `--c-slate` | #5A5F68 | 5.9 | Secondary text |
| `--c-placeholder` | #686C74 | 4.9 | Placeholders |
| `--c-gold-dark` | #6E5629 | 6.4 | Gold text, focus ring |
| `--c-navy` | #002349 | 14.5 | Buttons, nav |
| `--c-gold` | #A8894F | 3.1 | Decoration only, never text |
| `--c-signal` | #2FA39A | 2.8 | Decoration only, never text |

Rule: gold #A8894F and teal #2FA39A stay off text on the light ground. Use `--c-gold-dark` for any gold text. The existing palette already follows this; the new ground preserves it.

## Scope from the source (added after reading the site repo)

- Glows: about 25 rules across every page hero, homelab, about, experience, projects sections and the footer.
- Eyebrow: shared header pattern on nearly every page, inline styles on the home page.
- Cream: also in `site.webmanifest` and one inline value on the certifications page. The social card and banner artwork used it too, so the card images need regenerating.
- Dark mode exists (`prefers-color-scheme: dark`, paper #0A1526). The cool-ground change applies to the light theme. The dark tokens already read as navy, so they likely need only a check, not a change.

## Verify after the edit

1. `npx impeccable detect https://trenck.net`: expect `radial-spotlight-glow`, `dark-glow`, `cream-palette`, `ai-color-palette`, `wide-tracking` and `hero-eyebrow-chip` to clear. Ignore the `low-contrast` findings, which were false positives before and may remain so.
2. Lighthouse accessibility stays 100 on all nine pages.
3. Look at the hero and the contact block by eye at 375 and 1280 wide. Removing the glows is the change most likely to make sections feel flat, so check rhythm, not just scores.
