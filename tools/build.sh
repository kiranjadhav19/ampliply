#!/usr/bin/env bash
# ------------------------------------------------------------------
# Ampliply static site builder.
#
# The site in the repo root is plain, ready-to-host HTML — you can edit
# those files directly if you prefer. This script exists so the shared
# <head>, navigation and footer only live in one place: it wraps each
# body file in tools/src/ with the shell below and writes the result.
#
#   ./tools/build.sh
#
# Tokens replaced in every body file:
#   {{BASE}}     relative path back to the site root ("" or "../")
#   {{UPDATED}}  the "last updated" date for legal pages
# ------------------------------------------------------------------
set -euo pipefail
cd "$(dirname "$0")/.."

SITE_URL="https://ampliply.com"
UPDATED="27 November 2026"

esc() { printf '%s' "$1" | sed -e 's/[&/\]/\\&/g'; }

# --- shared chrome -------------------------------------------------
emit_head() { # $1 base  $2 title  $3 description  $4 canonical path
  local base="$1" title="$2" desc="$3" path="$4"
  cat <<HTML
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<meta name="description" content="${desc}">
<link rel="canonical" href="${SITE_URL}${path}">
<meta name="theme-color" content="#07080C" media="(prefers-color-scheme: dark)">
<meta name="theme-color" content="#FAF9F6" media="(prefers-color-scheme: light)">
<meta property="og:site_name" content="Ampliply">
<meta property="og:type" content="website">
<meta property="og:title" content="${title}">
<meta property="og:description" content="${desc}">
<meta property="og:url" content="${SITE_URL}${path}">
<meta property="og:image" content="${SITE_URL}/assets/img/brand/og-cover.png">
<meta name="twitter:card" content="summary_large_image">
<link rel="icon" href="${base}assets/img/brand/favicon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="${base}assets/img/brand/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600&display=swap">
<link rel="stylesheet" href="${base}assets/css/site.css">
<script src="${base}assets/js/theme-init.js"></script>
</head>
<body>
<a class="skip" href="#main">Skip to content</a>
HTML
}

emit_nav() { # $1 base  $2 active key
  local base="$1" active="$2"
  local a_apps="" a_approach="" a_privacy="" a_support=""
  case "$active" in
    apps)     a_apps=' aria-current="page"' ;;
    approach) a_approach=' aria-current="page"' ;;
    privacy)  a_privacy=' aria-current="page"' ;;
    support)  a_support=' aria-current="page"' ;;
  esac
  cat <<HTML
<header class="nav">
  <div class="container nav__inner">
    <a class="brand" href="${base}index.html" aria-label="Ampliply home">
      <img src="${base}assets/img/brand/logomark.svg" alt="" width="26" height="26">
      <span>ampliply</span>
    </a>
    <nav class="nav__links" id="nav-links" aria-label="Main">
      <a href="${base}index.html#apps"${a_apps}>Apps</a>
      <a href="${base}index.html#approach"${a_approach}>Approach</a>
      <a href="${base}privacy.html"${a_privacy}>Privacy</a>
      <a href="${base}support.html"${a_support}>Support</a>
    </nav>
    <div class="nav__actions">
      <button class="icon-btn" type="button" data-theme-toggle aria-label="Switch to light theme" aria-pressed="false">
        <svg class="icon-theme__moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z"/></svg>
        <svg class="icon-theme__sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="4.2"/><path d="M12 2v2.4M12 19.6V22M2 12h2.4M19.6 12H22M4.9 4.9l1.7 1.7M17.4 17.4l1.7 1.7M19.1 4.9l-1.7 1.7M6.6 17.4l-1.7 1.7"/></svg>
      </button>
      <button class="icon-btn nav__toggle" type="button" data-nav-toggle aria-expanded="false" aria-controls="nav-links" aria-label="Menu">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" aria-hidden="true"><path d="M4 7h16M4 12h16M4 17h16"/></svg>
      </button>
    </div>
  </div>
</header>
HTML
}

emit_footer() { # $1 base
  local base="$1"
  cat <<HTML
<footer class="footer">
  <div class="container">
    <div class="footer__grid">
      <div class="footer__brand">
        <a class="brand" href="${base}index.html" aria-label="Ampliply home">
          <img src="${base}assets/img/brand/logomark.svg" alt="" width="26" height="26">
          <span>ampliply</span>
        </a>
        <p>Small Android apps that do one thing properly — utility tools today, entertainment next.</p>
      </div>
      <div>
        <h4>Apps</h4>
        <ul>
          <li><a href="${base}apps/tv-remote.html">TV Remote for Samsung</a></li>
          <li><a href="${base}apps/unplug.html">Unplug: Auto Offline</a></li>
          <li><a href="${base}index.html#roadmap">What&rsquo;s next</a></li>
        </ul>
      </div>
      <div>
        <h4>Legal</h4>
        <ul>
          <li><a href="${base}privacy.html">Privacy policy</a></li>
          <li><a href="${base}privacy/tv-remote.html">TV Remote privacy</a></li>
          <li><a href="${base}privacy/unplug.html">Unplug privacy</a></li>
          <li><a href="${base}terms.html">Terms of use</a></li>
        </ul>
      </div>
      <div>
        <h4>Company</h4>
        <ul>
          <li><a href="${base}support.html">Support</a></li>
          <li><a href="${base}brand.html">Brand kit</a></li>
          <li><a href="mailto:support@ampliply.com">support@ampliply.com</a></li>
          <li><a href="mailto:hello@ampliply.com">hello@ampliply.com</a></li>
        </ul>
      </div>
    </div>
    <div class="footer__bottom">
      <span>&copy; <span data-year>2026</span> Ampliply. All rights reserved.</span>
      <span>Built for Android &middot; Made with care, not telemetry.</span>
    </div>
  </div>
</footer>
<script src="${base}assets/js/site.js" defer></script>
</body>
</html>
HTML
}

build_page() { # $1 out  $2 src  $3 base  $4 active  $5 title  $6 desc  $7 canonical
  local out="$1" src="tools/src/$2" base="$3" active="$4" title="$5" desc="$6" path="$7"
  mkdir -p "$(dirname "$out")"
  {
    emit_head "$base" "$title" "$desc" "$path"
    emit_nav  "$base" "$active"
    printf '<main id="main">\n'
    sed -e "s/{{BASE}}/$(esc "$base")/g" -e "s/{{UPDATED}}/$(esc "$UPDATED")/g" "$src"
    printf '</main>\n'
    emit_footer "$base"
  } > "$out"
  printf '  %-28s <- %s\n' "$out" "$src"
}

echo "Building Ampliply ..."
build_page index.html              index.html            ""    apps \
  "Ampliply — small Android apps that do one thing properly" \
  "Ampliply builds focused Android utility tools and entertainment apps. No accounts, no servers of ours, no data collected by us." \
  "/"

build_page apps/tv-remote.html     app-tv-remote.html    "../" apps \
  "TV Remote for Samsung Smart TV — Ampliply" \
  "Control your Samsung Tizen Smart TV from your Android phone over Wi-Fi. No IR blaster, no account, no sign-in." \
  "/apps/tv-remote.html"

build_page apps/unplug.html        app-unplug.html       "../" apps \
  "Unplug: Auto Offline — Ampliply" \
  "Unplug pauses your phone's internet a few minutes after you lock it, so notifications stop pulling you back. Calls and SMS keep working." \
  "/apps/unplug.html"

build_page privacy.html            privacy.html          ""    privacy \
  "Privacy policy — Ampliply" \
  "The Ampliply privacy policy: what our apps store on your device, the advertising data Google AdMob processes, and your rights." \
  "/privacy.html"

build_page privacy/tv-remote.html  privacy-tv-remote.html "../" privacy \
  "Privacy policy: TV Remote for Samsung Smart TV — Ampliply" \
  "App-specific privacy disclosures for TV Remote for Samsung Smart TV, alongside the Ampliply master privacy policy." \
  "/privacy/tv-remote.html"

build_page privacy/unplug.html     privacy-unplug.html   "../" privacy \
  "Privacy policy: Unplug: Auto Offline — Ampliply" \
  "App-specific privacy disclosures for Unplug: Auto Offline, including how its local VPN works and what it never does with your traffic." \
  "/privacy/unplug.html"

build_page terms.html              terms.html            ""    "" \
  "Terms of use — Ampliply" \
  "The terms that apply when you use an Ampliply app or this website." \
  "/terms.html"

build_page support.html            support.html          ""    support \
  "Support — Ampliply" \
  "Get help with an Ampliply app, report a bug or request a feature. We answer every email." \
  "/support.html"

build_page brand.html              brand.html            ""    "" \
  "Brand kit — Ampliply" \
  "The Ampliply brand kit: logo, colour palette, typography and voice." \
  "/brand.html"

build_page 404.html                404.html              ""    "" \
  "Page not found — Ampliply" \
  "That page does not exist. Here is the way back." \
  "/404.html"

echo "Done."
