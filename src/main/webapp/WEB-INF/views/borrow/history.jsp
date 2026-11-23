<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Lịch Sử Mượn Sách" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Lịch sử</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">HÀNH TRÌNH TRI THỨC</div>
      <h1>Lịch sử mượn sách</h1>
      <p>Nhìn lại những cuốn sách đã đồng hành cùng bạn.</p>
    </div>
    <a href="${pageContext.request.contextPath}/borrow/active" class="button secondary">
      <i class="bi bi-bookmark-check"></i>
      Sách đang mượn
    </a>
  </div>

  <c:if test="${not empty records}">
    <div class="table-panel">
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Tên sách</th>
            <th>Ngày mượn</th>
            <th>Hạn trả</th>
            <th>Ngày trả</th>
            <th>Trạng thái</th>
            <th>Tiền phạt</th>
            <th class="align-right">Hành động</th>
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
              <td>${r.borrowDate}</td>
              <td>${r.dueDate}</td>
              <td>${empty r.returnDate ? '—' : r.returnDate}</td>
              <td>
                <c:choose>
                  <c:when test="${r.status eq 'ACTIVE' and r.overdue}">
                    <span class="pill red">Quá hạn</span>
                  </c:when>
                  <c:when test="${r.status eq 'ACTIVE'}">
                    <span class="pill blue">Đang mượn</span>
                  </c:when>
                  <c:when test="${r.status eq 'RETURNED'}">
                    <span class="pill green">Đã trả</span>
                  </c:when>
                  <c:when test="${r.status eq 'RETURNED_LATE'}">
                    <span class="pill amber">Trả trễ</span>
                  </c:when>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${r.fineAmount > 0}">
                    <span class="pill ${r.finePaid ? 'green' : 'red'}">
                      <fmt:formatNumber value="${r.fineAmount}" type="number" maxFractionDigits="0"/> ₫
                      (${r.finePaid ? 'Đã nộp' : 'Chưa nộp'})
                    </span>
                  </c:when>
                  <c:otherwise>—</c:otherwise>
                </c:choose>
              </td>
              <td class="align-right">
                <div style="display:inline-flex;gap:8px;align-items:center;">
                  <a href="${pageContext.request.contextPath}/borrow/detail/${r.id}" class="text-button">
                    <i class="bi bi-eye"></i> Chi tiết
                  </a>
                  <c:if test="${r.fineAmount > 0 and not r.finePaid}">
                    <form action="${pageContext.request.contextPath}/borrow/pay-fine/${r.id}" method="post"
                          style="margin:0;display:inline;" onsubmit="return confirm('Xác nhận thanh toán tiền phạt?')">
                      <button type="submit" class="button soft" style="min-height:30px;padding:5px 10px;">
                        <i class="bi bi-cash-coin"></i> Nộp phạt
                      </button>
                    </form>
                  </c:if>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </c:if>

  <c:if test="${empty records}">
    <div class="empty-state panel">
      <i class="bi bi-clock-history"></i>
      <h3>Chưa có lịch sử mượn nào</h3>
      <p>Những cuốn sách bạn mượn sẽ được lưu lại tại đây.</p>
      <a href="${pageContext.request.contextPath}/books" class="button primary">
        Khám phá kho sách
      </a>
    </div>
  </c:if>
</main>

<ui:footer/>
