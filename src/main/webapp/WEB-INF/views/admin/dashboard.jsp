<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Trung Tâm Quản Trị" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>
<style>
.admin-nav{display:flex;gap:8px;flex-wrap:wrap;margin:22px 0 28px;padding:12px;background:#fff;border:1px solid var(--border);border-radius:14px;position:sticky;top:8px;z-index:5;box-shadow:0 5px 18px #172b4d0a}
.admin-nav a{padding:9px 13px;border-radius:8px;text-decoration:none;color:var(--text);font-size:13px;font-weight:600}
.admin-nav a:hover{background:#eef4ff;color:var(--primary)}
.admin-section{scroll-margin-top:90px;margin:28px 0 38px}
.admin-section-head{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;margin-bottom:16px}
.admin-section-head h2{margin:4px 0;font-size:23px}
.admin-section-head p{margin:0;color:var(--muted);font-size:13px}
.admin-two-col{display:grid;grid-template-columns:minmax(0,1.1fr) minmax(280px,.9fr);gap:18px;align-items:start}
.admin-form-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.admin-form-grid .wide{grid-column:1/-1}
.admin-table-wrap{overflow-x:auto}
.admin-table-wrap table{min-width:760px;width:100%}
.admin-actions{display:flex;gap:6px;flex-wrap:wrap;justify-content:flex-end}
.admin-actions form{margin:0}
.admin-actions button{cursor:pointer}
.admin-mini{font-size:12px;color:var(--muted)}
.admin-book-title{font-weight:700}
.admin-inline-cover{width:42px;height:54px;object-fit:cover;border-radius:5px}
.admin-kpis{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:14px}
.admin-kpi{background:#fff;border:1px solid var(--border);border-radius:13px;padding:18px}
.admin-kpi small{display:block;color:var(--muted);font-size:12px}
.admin-kpi strong{display:block;font-size:27px;margin:5px 0}
.admin-panel{background:#fff;border:1px solid var(--border);border-radius:14px;padding:20px}
.admin-panel h3{margin:0 0 16px}
.admin-empty{padding:25px;text-align:center;color:var(--muted)}
@media(max-width:850px){.admin-two-col{grid-template-columns:1fr}.admin-kpis{grid-template-columns:repeat(2,minmax(0,1fr))}.admin-nav{position:static}}
@media(max-width:520px){.admin-kpis{grid-template-columns:1fr 1fr}.admin-form-grid{grid-template-columns:1fr}.admin-form-grid .wide{grid-column:auto}.admin-section-head{align-items:flex-start;flex-direction:column}}
</style>
<main class="main-container">
 <div class="breadcrumb"><i class="bi bi-house-door"></i><span>/</span><span>Trung tâm quản trị</span></div>
 <div class="page-heading">
  <div><div class="eyebrow">LIBRARY CONTROL CENTER</div><h1>Trung tâm quản trị</h1><p>Quản lý sách, người dùng, mượn trả, tài liệu và báo cáo tại một nơi.</p></div>
  <span class="pill blue"><i class="bi bi-shield-check"></i> ${account.role}</span>
 </div>
 <nav class="admin-nav" aria-label="Điều hướng quản trị">
  <a href="#overview"><i class="bi bi-speedometer2"></i> Tổng quan</a>
  <a href="#books"><i class="bi bi-book"></i> Kho sách</a>
  <a href="#borrowing"><i class="bi bi-arrow-left-right"></i> Mượn trả</a>
  <a href="#users"><i class="bi bi-people"></i> Người dùng</a>
  <a href="#documents"><i class="bi bi-file-earmark-text"></i> Tài liệu số</a>
  <a href="#reports"><i class="bi bi-graph-up"></i> Báo cáo</a>
 </nav>

 <section id="overview" class="admin-section">
  <div class="admin-section-head"><div><div class="eyebrow">TỔNG QUAN</div><h2>Hoạt động thư viện</h2><p>Tháng ${monthly['month']}</p></div></div>
  <div class="admin-kpis">
   <div class="admin-kpi"><small><i class="bi bi-journals"></i> Đầu sách</small><strong>${inventory['totalTitles']}</strong><small>${inventory['totalCopies']} bản trong kho</small></div>
   <div class="admin-kpi"><small><i class="bi bi-book-half"></i> Đang được mượn</small><strong>${inventory['borrowedCopies']}</strong><small>${inventory['availableCopies']} bản còn sẵn</small></div>
   <div class="admin-kpi"><small><i class="bi bi-exclamation-triangle"></i> Quá hạn</small><strong>${overdueCount}</strong><small>Cần xử lý trả sách</small></div>
   <div class="admin-kpi"><small><i class="bi bi-people"></i> Tài khoản</small><strong>${fn:length(users)}</strong><small>Thành viên và nhân viên</small></div>
  </div>
  <div class="admin-two-col" style="margin-top:18px">
   <div class="admin-panel"><h3>Việc cần xử lý</h3>
    <p><a href="#borrowing">${fn:length(activeRecords)} phiếu đang mượn</a></p>
    <p><a href="#borrowing">${overdueCount} phiếu quá hạn</a></p>
    <p><a href="#users">${fn:length(users)} tài khoản trong hệ thống</a></p>
    <p><a href="#documents">${fn:length(documents)} tài liệu số</a></p>
   </div>
   <div class="admin-panel"><h3>Truy cập nhanh</h3>
    <div class="admin-actions" style="justify-content:flex-start">
     <a class="button primary" href="#books"><i class="bi bi-plus-lg"></i> Thêm sách</a>
     <a class="button secondary" href="#documents"><i class="bi bi-cloud-upload"></i> Upload tài liệu</a>
     <a class="button secondary" href="#users"><i class="bi bi-person-gear"></i> Quản lý tài khoản</a>
    </div>
   </div>
  </div>
 </section>

 <section id="books" class="admin-section">
  <div class="admin-section-head"><div><div class="eyebrow">DANH MỤC SÁCH</div><h2>Quản lý kho sách</h2><p>Thêm, chỉnh sửa, thay ảnh bìa hoặc xóa đầu sách.</p></div><span class="pill blue">${fn:length(books)} đầu sách</span></div>
  <div class="admin-two-col">
   <div class="admin-panel">
    <h3>${empty editBook ? 'Thêm sách mới' : 'Chỉnh sửa sách'}</h3>
    <form action="${pageContext.request.contextPath}${empty editBook ? '/books/add' : '/books/edit/'.concat(editBook.id)}" method="post" class="edit-form">
     <div class="admin-form-grid">
      <label class="wide">Tên sách *<input name="title" required value="<c:out value='${editBook.title}'/>" placeholder="Tên sách"/></label>
      <label>Tác giả *<input name="author" required value="<c:out value='${editBook.author}'/>" placeholder="Tác giả"/></label>
      <label>Thể loại<input name="category" value="<c:out value='${editBook.category}'/>" placeholder="Thể loại"/></label>
      <label>Nhà xuất bản<input name="publisher" value="<c:out value='${editBook.publisher}'/>"/></label>
      <label>Năm xuất bản<input type="number" name="publishYear" value="${editBook.publishYear}"/></label>
      <label>Số lượng bản *<input type="number" name="totalCopies" min="1" required value="${empty editBook.totalCopies ? 1 : editBook.totalCopies}"/></label>
      <label class="wide">Mô tả<textarea name="description" rows="3"><c:out value="${editBook.description}"/></textarea></label>
     </div>
     <div class="form-actions">
      <c:if test="${not empty editBook}"><a class="button secondary" href="${pageContext.request.contextPath}/admin#books">Hủy sửa</a></c:if>
      <button class="button primary" type="submit"><i class="bi bi-check-lg"></i> ${empty editBook ? 'Thêm sách' : 'Lưu thay đổi'}</button>
     </div>
    </form>
    <c:if test="${not empty editBook}">
     <hr style="border:0;border-top:1px solid var(--border);margin:20px 0"/>
     <h3>Ảnh bìa: <c:out value="${editBook.title}"/></h3>
     <form action="${pageContext.request.contextPath}/books/${editBook.id}/cover" method="post" enctype="multipart/form-data" class="edit-form">
      <label>Chọn ảnh bìa<input type="file" name="file" accept="image/*" required/></label>
      <button class="button secondary" type="submit"><i class="bi bi-image"></i> Tải ảnh bìa lên</button>
     </form>
    </c:if>
   </div>
   <div class="admin-panel">
    <h3>Danh mục hiện có</h3>
    <div class="admin-table-wrap"><table><thead><tr><th>Sách</th><th>Tồn</th><th></th></tr></thead><tbody>
     <c:forEach var="b" items="${books}">
      <tr><td><div class="admin-book-title"><c:out value="${b.title}"/></div><div class="admin-mini"><c:out value="${b.author}"/></div></td><td>${b.availableCopies}/${b.totalCopies}</td>
       <td class="align-right"><div class="admin-actions"><a class="text-button" href="${pageContext.request.contextPath}/admin?editBook=${b.id}#books">Sửa</a>
        <form action="${pageContext.request.contextPath}/books/delete/${b.id}" method="post" onsubmit="return confirm('Xóa sách này?')"><button class="icon-button danger" type="submit" title="Xóa"><i class="bi bi-trash"></i></button></form></div></td></tr>
     </c:forEach>
     <c:if test="${empty books}"><tr><td colspan="3" class="admin-empty">Chưa có sách.</td></tr></c:if>
    </tbody></table></div>
   </div>
  </div>
 </section>

 <section id="borrowing" class="admin-section">
  <div class="admin-section-head"><div><div class="eyebrow">LƯU HÀNH SÁCH</div><h2>Quản lý mượn và trả</h2><p>Danh sách phiếu đang mở, quá hạn và toàn bộ lịch sử mượn trả.</p></div><span class="pill ${overdueCount gt 0 ? 'red' : 'green'}">${overdueCount} quá hạn</span></div>
  <div class="admin-panel admin-table-wrap">
   <h3>Phiếu đang mượn / quá hạn</h3>
   <table><thead><tr><th>Người mượn</th><th>Sách</th><th>Ngày mượn</th><th>Hạn trả</th><th>Trạng thái</th><th class="align-right">Xử lý</th></tr></thead><tbody>
    <c:forEach var="r" items="${activeRecords}">
     <tr><td><strong><c:out value="${r.accountName}"/></strong><div class="admin-mini"><c:out value="${r.account.username}"/></div></td><td><c:out value="${r.bookTitle}"/></td><td>${r.borrowDate}</td><td>${r.dueDate}</td>
      <td><c:choose><c:when test="${r.overdue}"><span class="pill red">Quá hạn ${r.overdueDays} ngày</span></c:when><c:otherwise><span class="pill blue">Đang mượn</span></c:otherwise></c:choose></td>
      <td class="align-right"><form action="${pageContext.request.contextPath}/borrow/return/${r.id}" method="post" onsubmit="return confirm('Xác nhận đã nhận lại sách?')"><button class="button primary" type="submit">Xác nhận trả</button></form></td></tr>
    </c:forEach>
    <c:if test="${empty activeRecords}"><tr><td colspan="6" class="admin-empty">Không có phiếu mượn đang mở.</td></tr></c:if>
   </tbody></table>
  </div>
  <div class="admin-panel admin-table-wrap" style="margin-top:16px">
   <h3>Lịch sử mượn trả và tiền phạt</h3>
   <table><thead><tr><th>Người mượn</th><th>Sách</th><th>Mượn</th><th>Trả</th><th>Trạng thái</th><th>Tiền phạt</th><th>Chi tiết</th></tr></thead><tbody>
    <c:forEach var="r" items="${allRecords}">
     <tr><td><c:out value="${r.accountName}"/></td><td><c:out value="${r.bookTitle}"/></td><td>${r.borrowDate}</td><td>${empty r.returnDate ? '—' : r.returnDate}</td>
      <td><c:choose><c:when test="${r.overdue}"><span class="pill red">Quá hạn</span></c:when><c:when test="${r.status eq 'ACTIVE'}"><span class="pill blue">Đang mượn</span></c:when><c:when test="${r.status eq 'RETURNED_LATE'}"><span class="pill amber">Trả trễ</span></c:when><c:otherwise><span class="pill green">Đã trả</span></c:otherwise></c:choose></td>
      <td><c:if test="${r.fineAmount gt 0}"><fmt:formatNumber value="${r.fineAmount}" maxFractionDigits="0"/> ₫ <c:choose><c:when test="${r.finePaid}"><span class="pill green">Đã thu</span></c:when><c:otherwise><span class="pill red">Chưa thu</span></c:otherwise></c:choose></c:if><c:if test="${r.fineAmount le 0}">—</c:if></td>
      <td><a class="text-button" href="${pageContext.request.contextPath}/borrow/detail/${r.id}">Xem</a><c:if test="${r.fineAmount gt 0 and not r.finePaid}"><form style="display:inline" method="post" action="${pageContext.request.contextPath}/borrow/pay-fine/${r.id}"><button class="text-button" type="submit">Thu phạt</button></form></c:if></td></tr>
    </c:forEach>
    <c:if test="${empty allRecords}"><tr><td colspan="7" class="admin-empty">Chưa có lịch sử mượn.</td></tr></c:if>
   </tbody></table>
  </div>
 </section>

 <section id="users" class="admin-section">
  <div class="admin-section-head"><div><div class="eyebrow">TÀI KHOẢN & PHÂN QUYỀN</div><h2>Quản lý người dùng</h2><p>Tra cứu lịch sử, thăng cấp thủ thư, hạ cấp hoặc khóa tài khoản.</p></div><span class="pill blue">${fn:length(users)} tài khoản</span></div>
  <div class="admin-panel admin-table-wrap"><table><thead><tr><th>Người dùng</th><th>Email</th><th>Vai trò</th><th>Trạng thái</th><th class="align-right">Hành động</th></tr></thead><tbody>
   <c:forEach var="u" items="${users}">
    <tr><td><strong><c:out value="${u.fullName}"/></strong><div class="admin-mini">@<c:out value="${u.username}"/></div></td><td><c:out value="${empty u.email ? '—' : u.email}"/></td>
     <td><span class="pill ${u.admin ? 'blue' : (u.librarian ? 'amber' : 'green')}">${u.role}</span></td><td><span class="pill ${u.active ? 'green' : 'gray'}">${u.active ? 'Hoạt động' : 'Đã khóa'}</span></td>
     <td class="align-right"><div class="admin-actions"><a class="text-button" href="${pageContext.request.contextPath}/admin/users/${u.id}/history">Lịch sử</a>
      <c:if test="${account.admin and u.role eq 'STUDENT'}"><form method="post" action="${pageContext.request.contextPath}/admin/users/${u.id}/promote"><button class="icon-button" title="Thăng cấp thủ thư"><i class="bi bi-arrow-up-circle"></i></button></form></c:if>
      <c:if test="${account.admin and u.role eq 'LIBRARIAN'}"><form method="post" action="${pageContext.request.contextPath}/admin/users/${u.id}/demote"><button class="icon-button" title="Hạ cấp thành viên"><i class="bi bi-arrow-down-circle"></i></button></form></c:if>
      <c:if test="${account.admin and u.role ne 'ADMIN' and u.active}"><form method="post" action="${pageContext.request.contextPath}/admin/users/${u.id}/delete" onsubmit="return confirm('Vô hiệu hóa tài khoản này?')"><button class="icon-button danger" title="Khóa tài khoản"><i class="bi bi-person-x"></i></button></form></c:if>
     </div></td></tr>
   </c:forEach>
  </tbody></table></div>
  <c:if test="${not account.admin}"><p class="admin-mini" style="margin-top:10px">Chỉ ADMIN mới có quyền thay đổi vai trò hoặc vô hiệu hóa tài khoản.</p></c:if>
 </section>

 <section id="documents" class="admin-section">
  <div class="admin-section-head"><div><div class="eyebrow">TÀI NGUYÊN SỐ</div><h2>Quản lý tài liệu số</h2><p>Đăng tải và quản lý tài liệu PDF, DOC, DOCX (tối đa 50 MB).</p></div><span class="pill blue">${fn:length(documents)} tài liệu</span></div>
  <div class="admin-two-col">
   <div class="admin-panel"><h3>Upload tài liệu mới</h3>
    <form action="${pageContext.request.contextPath}/documents/upload" method="post" enctype="multipart/form-data" class="edit-form">
     <label>File tài liệu *<input type="file" name="file" accept=".pdf,.doc,.docx" required/><small>PDF, DOC, DOCX — tối đa 50 MB</small></label>
     <label>Tiêu đề *<input name="title" required placeholder="Tên tài liệu"/></label>
     <div class="form-row"><label>Tác giả<input name="author"/></label><label>Loại tài liệu<select name="documentType"><option value="TEXTBOOK">Giáo trình</option><option value="THESIS">Luận văn / Báo cáo</option><option value="OTHER">Khác</option></select></label></div>
     <label>Mô tả<textarea name="description" rows="3"></textarea></label>
     <button class="button primary" type="submit"><i class="bi bi-cloud-upload"></i> Upload tài liệu</button>
    </form>
   </div>
   <div class="admin-panel admin-table-wrap"><h3>Tài liệu đã đăng</h3><table><thead><tr><th>Tài liệu</th><th>Lượt tải</th><th></th></tr></thead><tbody>
    <c:forEach var="d" items="${documents}"><tr><td><strong><c:out value="${d.title}"/></strong><div class="admin-mini"><c:out value="${d.fileName}"/> · <c:out value="${d.documentType}"/></div></td><td>${d.downloadCount}</td><td><div class="admin-actions"><a class="text-button" href="${pageContext.request.contextPath}/documents/download/${d.id}" target="_blank">Mở</a><form method="post" action="${pageContext.request.contextPath}/documents/delete/${d.id}" onsubmit="return confirm('Xóa tài liệu này?')"><button class="icon-button danger" type="submit"><i class="bi bi-trash"></i></button></form></div></td></tr></c:forEach>
    <c:if test="${empty documents}"><tr><td colspan="3" class="admin-empty">Chưa có tài liệu.</td></tr></c:if>
   </tbody></table></div>
  </div>
 </section>

 <section id="reports" class="admin-section">
  <div class="admin-section-head"><div><div class="eyebrow">BÁO CÁO</div><h2>Thống kê và hiệu suất</h2><p>Số liệu tính trực tiếp từ dữ liệu hiện tại.</p></div></div>
  <div class="admin-kpis">
   <div class="admin-kpi"><small>Lượt mượn tháng này</small><strong>${monthly['totalBorrows']}</strong></div>
   <div class="admin-kpi"><small>Lượt trả tháng này</small><strong>${monthly['totalReturns']}</strong></div>
   <div class="admin-kpi"><small>Phiếu quá hạn</small><strong>${monthly['currentOverdue']}</strong></div>
   <div class="admin-kpi"><small>Tiền phạt đã thu</small><strong style="font-size:21px"><fmt:formatNumber value="${revenue['totalFinesCollected']}" maxFractionDigits="0"/> ₫</strong></div>
  </div>
  <div class="admin-panel admin-table-wrap" style="margin-top:16px"><h3>Top sách được mượn nhiều</h3><table><thead><tr><th>#</th><th>Tên sách</th><th>Tác giả</th><th>Lượt mượn</th></tr></thead><tbody>
   <c:forEach var="stat" items="${mostBorrowed}" varStatus="i"><tr><td>${i.count}</td><td><strong><c:out value="${stat['title']}"/></strong></td><td><c:out value="${stat['author']}"/></td><td>${stat['borrowCount']}</td></tr></c:forEach>
   <c:if test="${empty mostBorrowed}"><tr><td colspan="4" class="admin-empty">Chưa có dữ liệu.</td></tr></c:if>
  </tbody></table></div>
 </section>
</main>
<ui:footer/>
