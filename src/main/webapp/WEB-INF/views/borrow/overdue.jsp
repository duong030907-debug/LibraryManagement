<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Danh Sách Mượn Quá Hạn" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Mượn quá hạn</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">QUẢN LÝ MƯỢN TRẢ</div>
      <h1>Danh sách mượn quá hạn</h1>
      <p>Theo dõi những cuốn sách đã quá hạn cần được hoàn trả.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/stats" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại thống kê
    </a>
  </div>

  <c:if test="${empty records}">
    <div class="empty-state panel">
      <i class="bi bi-check-circle"></i>
      <h3>Không có sách nào đang quá hạn!</h3>
      <p>Tất cả các lượt mượn đều đang trong thời hạn tiêu chuẩn.</p>
    </div>
  </c:if>

  <c:if test="${not empty records}">
    <div class="table-panel">
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Tên sách</th>
            <th>Người mượn</th>
            <th>Ngày mượn</th>
            <th>Hạn trả</th>
            <th>Trạng thái</th>
            <th>Tiền phạt dự kiến</th>
            <th class="align-right">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="r" items="${records}" varStatus="s">
            <tr>
              <td>${s.index + 1}</td>
              <td class="table-title">
                <c:out value="${r.book.title}"/>
                <div class="muted" style="margin-top:3px;"><c:out value="${r.book.author}"/></div>
              </td>
              <td>
                <strong><c:out value="${r.account.fullName}"/></strong>
                <div class="muted" style="margin-top:3px;"><c:out value="${r.account.username}"/></div>
              </td>
              <td>${r.borrowDate}</td>
              <td style="color:#dc7777;font-weight:600;">${r.dueDate}</td>
              <td><span class="pill red">Quá hạn</span></td>
              <td class="muted">2.000 ₫ / ngày trễ</td>
              <td class="align-right">
                <div style="display:inline-flex;gap:8px;align-items:center;">
                  <a href="${pageContext.request.contextPath}/borrow/detail/${r.id}" class="text-button">
                    <i class="bi bi-eye"></i> Chi tiết
                  </a>
                  <form action="${pageContext.request.contextPath}/borrow/return/${r.id}" method="post"
                        style="margin:0;display:inline;" onsubmit="return confirm('Xác nhận trả sách và tính phí phạt quá hạn?')">
                    <button type="submit" class="button primary" style="min-height:32px;padding:6px 12px;">
                      <i class="bi bi-arrow-return-left"></i> Trả + tính phạt
                    </button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>
</main>

<ui:footer/>
