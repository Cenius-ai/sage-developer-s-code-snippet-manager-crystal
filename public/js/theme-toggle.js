/* ═══════════════════════════════════════════════════════════════════
   Sage — Theme Toggle
   Persists light/dark preference in localStorage.
   ═══════════════════════════════════════════════════════════════════ */

(function () {
  "use strict";

  var STORAGE_KEY = "sage-theme";
  var html = document.documentElement;

  /* ── Restore saved theme ─────────────────────────────────────── */
  function applyTheme(theme) {
    html.setAttribute("data-theme", theme);
  }

  var saved = localStorage.getItem(STORAGE_KEY);
  if (saved === "light" || saved === "dark") {
    applyTheme(saved);
  }

  /* ── Toggle button ───────────────────────────────────────────── */
  var toggle = document.getElementById("theme-toggle");
  if (!toggle) return;

  toggle.addEventListener("click", function () {
    var current = html.getAttribute("data-theme");
    var next = current === "dark" ? "light" : "dark";
    applyTheme(next);
    localStorage.setItem(STORAGE_KEY, next);
  });

  /* ── Copy-to-clipboard ───────────────────────────────────────── */
  document.addEventListener("click", function (e) {
    var btn = e.target.closest("[data-copy-target]");
    if (!btn) return;

    var targetId = btn.getAttribute("data-copy-target");
    var target = document.getElementById(targetId);
    if (!target) return;

    var text = target.textContent || "";
    navigator.clipboard.writeText(text).then(
      function () {
        btn.classList.add("copied");
        var span = btn.querySelector("span");
        if (span) span.textContent = "Copied!";
        setTimeout(function () {
          btn.classList.remove("copied");
          if (span) span.textContent = "Copy";
        }, 2000);
      },
      function () {
        /* Fallback: select the text so the user can copy manually */
        var range = document.createRange();
        range.selectNodeContents(target);
        var sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
        var span = btn.querySelector("span");
        if (span) span.textContent = "Selected — use Ctrl+C";
        setTimeout(function () {
          if (span) span.textContent = "Copy";
        }, 2000);
      }
    );
  });
})();
