# ampliply.com

The Ampliply website: a static, dependency-free site for the app portfolio, the brand and the
privacy policies that Google Play requires.

No build step is needed to host it. No framework, no npm, no JavaScript required for the content
to render — the scripts only add a theme toggle, the mobile menu and scroll reveals.

---

## What is here

```
index.html              Home — hero, portfolio, approach, roadmap
apps/tv-remote.html     TV Remote for Samsung Smart TV
apps/unplug.html        Unplug: Auto Offline
privacy.html            Master privacy policy  (all apps + this site)
privacy/tv-remote.html  App supplement — give THIS url to Play Console
privacy/unplug.html     App supplement — give THIS url to Play Console
terms.html              Terms of use
support.html            Support, contact and FAQ
brand.html              Visual brand sheet
404.html                Not-found page
brand/BRANDKIT.md       The written brand kit
assets/                 css, js, images (brand marks + app screenshots)
tools/                  Optional builder — see "Editing" below
CNAME .nojekyll         GitHub Pages
firebase.json           Firebase Hosting headers, caching and redirects
netlify.toml            Netlify / Cloudflare Pages headers and redirects
robots.txt sitemap.xml  Search engines
app-ads.txt             AdMob — needs your publisher ID, see below
```

Total weight: well under 1 MB including every screenshot.

## Privacy policy structure

One **master policy** at `/privacy.html` holds everything that is the same for every app —
advertising, legal bases, rights, retention, children, transfers, contact. Each app then has a
short **supplement** at `/privacy/<app>.html` listing only what that app stores on the device and
which permissions it uses, and linking back to the master.

Give Google Play Console the **supplement URL** for each app, not the master:

| App | Privacy policy URL for Play Console |
|---|---|
| TV Remote for Samsung Smart TV | `https://ampliply.com/privacy/tv-remote.html` |
| Unplug: Auto Offline | `https://ampliply.com/privacy/unplug.html` |

That is what Google expects (a policy that comprehensively covers *that* app), while the shared
legal text stays in one file instead of drifting out of sync across copies. Set the same
supplement URL in each AdMob app's settings, and in the app's own `PRIVACY_POLICY_URL` build
config.

A new app needs: a copy of a supplement, a line in the master policy's section 3, a card on the
home page, and an entry in `sitemap.xml`.

## Hosting

Two hosts, one source of truth. The repository is
<https://github.com/kiranjadhav19/ampliply>.

| | Serves | Status |
|---|---|---|
| **Firebase Hosting** | `ampliply.com` | To set up — see below |
| **GitHub Pages** | `kiranjadhav19.github.io/ampliply/` | Live, acts as the backup copy |

GitHub Pages redeploys on every push to `main` and needs no attention. Firebase is a deliberate
deploy, which is what gets you the CSP and cache headers in `firebase.json` — headers GitHub Pages
cannot serve at all.

### Setting up Firebase Hosting

`firebase.json` is already written: it publishes the repository root, excludes `tools/`, the git
directory and the host-specific files, sets the same security headers and asset caching as
`netlify.toml`, and keeps the two `/privacy/` and `/apps/` redirects. `cleanUrls` is deliberately
**off** so that `/privacy/unplug.html` stays exactly that on every host — those URLs are going into
Play Console and should not start redirecting.

Sign in to the Google account you want to own this, then:

```bash
npm install -g firebase-tools
```

```bash
firebase login
```

```bash
firebase projects:create ampliply-site --display-name "Ampliply"
```

```bash
cd "/Users/admin/Documents/Development/Android Apps/ampliply.com" && firebase use --add
```

That last one writes `.firebaserc` — pick the project and give it the alias `default`. Then deploy:

```bash
firebase deploy --only hosting
```

The site goes live at `ampliply-site.web.app` straight away. Everything stays on the free **Spark**
plan; no billing account is needed. The free quota is 10 GB of storage and **360 MB of transfer per
day**, roughly 1,200 full page views — worth keeping an eye on, because Firebase serves an error
page rather than throttling once a day's quota is gone.

### Pointing ampliply.com at Firebase

In the Firebase console → **Hosting → Add custom domain**, enter `ampliply.com` and let it also set
up the `www` redirect. Firebase then shows you two things to add at GoDaddy
(**Domains → ampliply.com → DNS**):

1. A `TXT` record to prove you own the domain. Add it, then click Verify.
2. The `A` record(s) for the apex — usually a single `199.36.158.100`, but **use whatever the
   console shows you**, not this number.

Before adding those, **delete** the existing `@` `A` records (they point at GoDaddy's parked-page
addresses `13.248.243.5` and `76.223.105.230`) and any domain-forwarding entry for `@`.
**Leave the `MX` records alone** — those are email, and removing them breaks
`support@ampliply.com` later.

Check propagation with:

```bash
dig +short ampliply.com A
```

Firebase provisions the certificate itself once the records resolve; it can take up to 24 hours,
and the console shows the state. Do not paste any URL into Play Console until
`https://ampliply.com` loads.

Last step, once Firebase is serving the domain: remove the custom domain from the GitHub repository
so it stops claiming `ampliply.com` and reverts to the `github.io` URL as a clean backup.

```bash
cd "/Users/admin/Documents/Development/Android Apps/ampliply.com" && git rm CNAME && git commit -m "Move the custom domain to Firebase Hosting" && git push
```

### Alternatives

**Cloudflare Pages** — connect the repository, leave the build command empty, set the output
directory to `/`. Add `ampliply.com` as a custom domain; Cloudflare handles the DNS and the
certificate, with no transfer cap. Worth it if you also want Cloudflare Email Routing for
`support@ampliply.com`.

**Netlify** — drag this folder onto the Netlify dashboard, or connect the repository.
`netlify.toml` already sets security headers, asset caching and the two redirects.

Note that each host reads only its own config: `firebase.json` on Firebase, `netlify.toml` on
Netlify and Cloudflare Pages, and GitHub Pages reads neither — it serves the repository as-is.


## Before you go live

1. **Email.** Set up `support@ampliply.com` and `hello@ampliply.com` (forwarding to your inbox is
   fine — Cloudflare Email Routing and ImprovMX both do this free). They appear throughout the
   privacy policy, the terms and the support page.
2. **`app-ads.txt`.** Open it and follow the TODO at the top — it needs your real AdMob publisher
   ID, and each app's Play listing must point at `https://ampliply.com` as the developer website.
3. **Play Store URLs.** The site links to
   `play.google.com/store/apps/details?id=com.kiranjadhav.tvremote` and `...?id=app.unplug.autooffline`.
   Check both resolve once the apps are published; if a package name changed, search the HTML for
   the old id.
4. **Legal identity.** GDPR Art. 13 asks a controller to identify itself. If you trade as a
   registered company, add the legal name and registered address to section 2 of
   `tools/src/privacy.html` ("Who we are") and rebuild. There is a TODO comment at the top of
   that file.
5. **App status.** Every app card says "On Google Play". If one is still in closed testing, change
   that badge before launch.
6. **`PRIVACY_POLICY_URL`.** Done — the Unplug project's `app/build.gradle.kts` now points at
   `https://ampliply.com/privacy/unplug.html`. It needs a rebuild to take effect, and the link
   will 404 until the domain is live. TV Remote renders its policy in-app from
   `ui/screens/PrivacyPolicy.kt`, so it has no URL to set; its `store/` docs still say "your
   hosted URL" in a couple of places.

## Editing

Edit the HTML files directly if you like — they are plain, self-contained pages.

If you change the navigation, the footer or anything in `<head>`, use the builder instead so all
ten pages stay in step:

```bash
./tools/build.sh
```

It wraps each body file in `tools/src/` with the shared chrome defined at the top of the script
and overwrites the pages in the root. `{{BASE}}` in a body file becomes the relative path back to
the site root, and `{{UPDATED}}` becomes the legal "last updated" date — both set in
`tools/build.sh`.

Colour, type and spacing all live as CSS custom properties at the top of `assets/css/site.css`.
Change a token there and the whole site follows. The brand kit documents what each one is for.

## Notes

- The site is dark by default with a light theme toggle; the choice is remembered in
  `localStorage` and falls back silently where storage is blocked.
- No cookies, no analytics, no tracking pixels. The only third-party request is Google Fonts,
  which is disclosed in the privacy policy.
- Screenshots were exported from the app projects at 540 px wide WebP, quality 82. The 1080×2280
  PNG originals stay in each app's own repository for the Play listing.
