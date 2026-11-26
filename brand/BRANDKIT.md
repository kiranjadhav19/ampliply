# Ampliply — Brand Kit

Version 1.0 · 27 November 2026

Everything needed to keep Ampliply looking like one company across a website, a Play Store
listing, an app icon and a screenshot frame. A rendered version of this document lives at
[/brand/](../brand.html) on the site.

---

## 1. The name

**Ampliply** — *amplify* + *apply*. We take small, everyday jobs and make them work better.
Always written as one word. Lowercase `ampliply` in the logo and in UI, capitalised
**Ampliply** in running text and legal documents. Never "AmpliPly", "Ampli-Ply" or "AMPLIPLY".

Domain and primary identity: **ampliply.com**

## 2. Positioning

> Small apps that do one thing properly.

We build focused Android apps — utility tools today, entertainment next — that open fast, do the
job and ask for nothing. No accounts, no servers of ours, no permission creep.

**Audience.** People who searched an app store for a simple tool and were put off by sign-up
walls, subscriptions and permission requests that made no sense.

**One-liners, by length**

| Use | Text |
|---|---|
| 3 words | Small apps, amplified |
| Tagline | Small apps that do one thing properly |
| Short description | Ampliply builds focused Android utility tools and entertainment apps. No accounts, no servers of ours, no data collected by us. |
| Boilerplate | Ampliply is an independent Android developer making small, focused apps — utility tools and entertainment — that work without an account and keep your data on your own device. Our apps are free and ad-supported. |

## 3. Voice

**We sound like:** a careful engineer explaining their own work to a friend. Plain, specific,
unhurried. Concrete numbers over adjectives. Honest about limits before anyone has to ask.

**We do not sound like:** a growth team. No "revolutionary", "seamless", "game-changing",
"empower", "unlock", "supercharge". No exclamation marks. No fake urgency, no countdowns, no
"Join 10,000 users".

**Rules of thumb**

1. Say the absence. "No account" lands harder than "privacy-first".
2. Lead with the user's problem, not the feature. *Lost the remote again?* before *Wi-Fi control*.
3. Name the limitation in the same breath as the claim. It is the whole reason people trust the claim.
4. Short sentences. One idea each. Cut the second adjective.
5. British-leaning plain English, Oxford-light. "Switch off", not "disable", where it reads better.

## 4. Logo

| Asset | File | Use |
|---|---|---|
| Logomark | `assets/img/brand/logomark.svg` | Gradient amplitude bars. Nav, footer, avatars, anywhere above 20 px. |
| Lockup | `assets/img/brand/logo.svg` | Mark + wordmark, horizontal. Headers, docs, partner listings. |
| Favicon | `assets/img/brand/favicon.svg` | Three bars in Volt on an Ink tile. Simplified for 16–32 px. |
| Social cover | `assets/img/brand/og-cover.png` | 1200×630 Open Graph / Twitter card. |

**The mark** is five rounded bars rising to a peak and settling — an amplitude trace. It reads as
signal, sound and growth, and it survives being shrunk to a tab icon.

**Clear space:** at least the width of one bar on every side. **Minimum size:** 20 px tall for the
mark, 96 px wide for the lockup.

**Never:** recolour the mark to a flat brand-foreign colour, add a drop shadow or outline, stretch
it non-uniformly, rotate it, enclose it in a shape that is not the favicon tile, or set the
wordmark in a font other than Space Grotesk.

## 5. Colour

### Core palette

| Token | Hex | Role |
|---|---|---|
| **Volt** | `#C8F25C` | Primary accent. Buttons, active states, utility-category coding. |
| **Violet** | `#8B74FF` | Secondary accent. Entertainment-category coding, gradient start. |
| **Cyan** | `#58D8F0` | Tertiary. Gradient midpoint, occasional highlight. |
| **Ink 950** | `#07080C` | Dark-theme page background. |
| **Ink 900** | `#0B0D13` | Dark-theme raised surface / alternating sections. |
| **Ink 850** | `#101319` | Solid card fill, device frames. |
| **Ink 800** | `#161A22` | Borders at high contrast, phone bezels. |
| **Paper** | `#FAF9F6` | Light-theme page background (warm, never pure white). |

### Signature gradient

`linear-gradient(100deg, #8B74FF 0%, #58D8F0 46%, #C8F25C 92%)`

Violet → Cyan → Volt, lower-left to upper-right. Used on the logomark, on one or two words of a
headline, and on a thin rule. Never as a full background behind body text.

### Text colours

| | Dark theme | Light theme |
|---|---|---|
| Body | `#F3F5F9` | `#0C0F16` |
| Muted | `#A7AFC0` | `#555E6E` |
| Dim / captions | `#6F7889` | `#7C8494` |
| Accent text | `#C8F25C` | `#5E7D12` |

**Contrast rule.** Volt is a *background* colour in light theme, never a text colour — `#C8F25C`
on `#FAF9F6` fails WCAG AA badly. Accent text in light theme uses the darkened `#5E7D12`. On
Volt buttons, text is always Ink `#0A0C10`.

### Category coding

- **Utility tools** → Volt
- **Entertainment** → Violet

Keep this consistent across the site, store graphics and screenshots so the two shelves stay
legible at a glance.

## 6. Typography

| Role | Family | Weights | Notes |
|---|---|---|---|
| Display | **Space Grotesk** | 500 / 600 / 700 | Headings, buttons, eyebrows, numerals. Letter-spacing `-0.022em` on headings. |
| Body | **Inter** | 400 / 500 / 600 | Paragraphs, lists, tables. Line height 1.65. |
| Mono | system `ui-monospace` | — | Package names, permissions, code. |

Both are free, open-licence and served from Google Fonts.

**Scale** (fluid, `clamp()`): hero `2.5–4.6rem` · h1 `2–3.1rem` · h2 `1.55–2.15rem` ·
h3 `1.15–1.3rem` · body `1.0625rem` · small `0.9rem` · eyebrow `0.78rem` uppercase, tracking `0.14em`.

## 7. Layout and shape

- Container `1140px`, gutter `24px` (`16px` under 560px).
- Section rhythm `clamp(3.5rem, 8vw, 6.5rem)` vertical.
- Radii: `10px` small · `16px` medium · `24px` cards · `32px` panels · `999px` buttons and pills.
- Borders are 1px at ~9% foreground opacity — visible structure, never a hard box.
- One idea per section. Alternating `--bg` / `--bg-soft` bands carry the eye down the page.

**Motion.** Transitions `0.18–0.25s` on interaction, `0.6s` on scroll reveals, easing
`cubic-bezier(.2,.7,.3,1)`. Everything respects `prefers-reduced-motion`. Nothing loops in the
user's peripheral vision except the 4-bar equaliser, and that is decorative and small.

## 8. Imagery

- **Screenshots** are real, never mocked-up marketing fiction, and are shown inside the thin
  rounded device frame (`.phone`) rather than floating.
- **Export** at 540px wide WebP, quality 82, for the web; keep the 1080×2280 PNG originals for Play.
- **Illustration** is limited to stroked line icons at 1.8–1.9px on a 24px grid, inherited from
  `currentColor`. No 3D renders, no stock photography, no smiling people holding phones.
- **Backgrounds** use soft blurred colour auras (Violet, Volt, Cyan at 16–28% opacity) over Ink,
  plus an optional faint vertical grid masked to fade out. Never a hard gradient wash.

## 9. Writing about the apps

- Always `TV Remote for Samsung Smart TV` — function first, then "for", then the brand. Never
  "Samsung TV Remote", which reads as an official app and is an impersonation risk on Google Play.
- Always `Unplug: Auto Offline` on first mention, `Unplug` afterwards.
- Every surface naming a third-party brand carries the trademark disclaimer.
- Never write "secure", "private" or "anonymous" as a bare adjective. Write what actually happens:
  *stored only on your phone*, *never leaves the device*, *we run no servers*.

## 10. Files in this kit

```
assets/img/brand/logomark.svg     mark, gradient
assets/img/brand/logo.svg         horizontal lockup
assets/img/brand/favicon.svg      simplified tile mark
assets/img/brand/og-cover.png     1200×630 social cover
assets/img/brand/og-cover.svg     editable source for the above
assets/css/site.css               every token above, as CSS custom properties
brand/BRANDKIT.md                 this document
```

The CSS file is the source of truth for colour and type. If a value here and a value there ever
disagree, the CSS wins and this document is out of date.
