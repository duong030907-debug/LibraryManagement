/* Shared interactions used by all JSP views. */
function toggleDropdown(id, event) {
  if (event) event.stopPropagation();
  var target = document.getElementById(id);
  document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
    if (menu.id !== id) menu.classList.remove('open');
  });
  if (target) target.classList.toggle('open');
}
function toggleMobileNav() {
  var nav = document.getElementById('mainNav');
  if (nav) nav.classList.toggle('open');
}
document.addEventListener('click', function() {
  document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
    menu.classList.remove('open');
  });
});
document.addEventListener('DOMContentLoaded', function() {
  window.setTimeout(function() {
    var toast = document.getElementById('flashToast');
    if (toast) toast.remove();
  }, 4500);
});
