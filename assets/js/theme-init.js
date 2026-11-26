/* Applied before paint so the chosen theme never flashes. */
(function () {
  try {
    if (localStorage.getItem('ampliply-theme') === 'light') {
      document.documentElement.setAttribute('data-theme', 'light');
    }
  } catch (e) { /* ignore */ }
})();
