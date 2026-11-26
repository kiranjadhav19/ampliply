/* Ampliply — small progressive-enhancement layer. No dependencies. */
(function () {
  'use strict';

  /* ---- Theme (dark default, remembered per browser) ---- */
  var root = document.documentElement;

  function readTheme() {
    try { return localStorage.getItem('ampliply-theme'); } catch (e) { return null; }
  }
  function writeTheme(v) {
    try { localStorage.setItem('ampliply-theme', v); } catch (e) { /* private mode */ }
  }
  function applyTheme(v) {
    if (v === 'light') { root.setAttribute('data-theme', 'light'); }
    else { root.removeAttribute('data-theme'); }
    var btn = document.querySelector('[data-theme-toggle]');
    if (btn) {
      btn.setAttribute('aria-label', v === 'light' ? 'Switch to dark theme' : 'Switch to light theme');
      btn.setAttribute('aria-pressed', v === 'light' ? 'true' : 'false');
    }
  }

  applyTheme(readTheme() || 'dark');

  document.addEventListener('click', function (e) {
    var t = e.target.closest ? e.target.closest('[data-theme-toggle]') : null;
    if (!t) return;
    var next = root.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
    applyTheme(next);
    writeTheme(next);
  });

  /* ---- Mobile nav ---- */
  var navToggle = document.querySelector('[data-nav-toggle]');
  var navLinks = document.getElementById('nav-links');
  if (navToggle && navLinks) {
    navToggle.addEventListener('click', function () {
      var open = navLinks.classList.toggle('is-open');
      navToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    navLinks.addEventListener('click', function (e) {
      if (e.target.tagName === 'A') {
        navLinks.classList.remove('is-open');
        navToggle.setAttribute('aria-expanded', 'false');
      }
    });
  }

  /* ---- Nav hairline once scrolled ---- */
  var nav = document.querySelector('.nav');
  if (nav) {
    var onScroll = function () { nav.classList.toggle('is-stuck', window.scrollY > 8); };
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
  }

  /* ---- Reveal on scroll ---- */
  var revealables = document.querySelectorAll('.reveal');
  var reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (!revealables.length) { /* nothing */ }
  else if (reduced || !('IntersectionObserver' in window)) {
    for (var i = 0; i < revealables.length; i++) revealables[i].classList.add('is-in');
  } else {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-in');
          io.unobserve(entry.target);
        }
      });
    }, { rootMargin: '0px 0px -40px 0px', threshold: 0.01 });
    revealables.forEach(function (el, idx) {
      el.style.transitionDelay = Math.min(idx % 4, 3) * 55 + 'ms';
      io.observe(el);
    });
  }

  /* ---- Table of contents: highlight the section in view ---- */
  var tocLinks = document.querySelectorAll('.toc a[href^="#"]');
  if (tocLinks.length && 'IntersectionObserver' in window) {
    var byId = {};
    var targets = [];
    tocLinks.forEach(function (a) {
      var el = document.getElementById(a.getAttribute('href').slice(1));
      if (el) { byId[el.id] = a; targets.push(el); }
    });
    var spy = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (!entry.isIntersecting) return;
        tocLinks.forEach(function (a) { a.classList.remove('is-active'); });
        if (byId[entry.target.id]) byId[entry.target.id].classList.add('is-active');
      });
    }, { rootMargin: '-90px 0px -65% 0px' });
    targets.forEach(function (el) { spy.observe(el); });
  }

  /* ---- Stamp "last updated" years / current year in the footer ---- */
  var years = document.querySelectorAll('[data-year]');
  var y = String(new Date().getFullYear());
  for (var k = 0; k < years.length; k++) years[k].textContent = y;
})();
