<%@ tag pageEncoding="UTF-8" description="Shared page footer" %>
<footer class="footer">
  <div>
    <span>
      <i class="bi bi-book-half"></i>
      Thư Viện Sách
    </span>
    <p>Kết nối tri thức. Nuôi dưỡng tương lai.</p>
  </div>
  <p>
    Created by <strong>Ngô Đức Hải</strong>
    <span class="footer-separator">&middot;</span>24211TT2856
  </p>
  <span class="footer-year">&copy; 2026 Thư Viện Sách</span>
</footer>
</div>
<script>
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
  setTimeout(function() {
    var toast = document.getElementById('flashToast');
    if (toast) toast.remove();
  }, 4500);
</script>
</body>
</html>
