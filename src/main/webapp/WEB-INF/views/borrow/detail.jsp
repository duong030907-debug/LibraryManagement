<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chi Tiết Phiếu Mượn" scope="request"/>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<ui:header title="${pageTitle}"/>
<ui:navbar/>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <a href="${pageContext.request.contextPath}/borrow/history">Lịch sử</a>
    <span>/</span>
    <span>Phiếu mượn #${record.id}</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">THÔNG TIN MƯỢN TRẢ</div>
      <h1>Chi tiết phiếu mượn #${record.id}</h1>
      <p>Thông tin chi tiết về lượt mượn sách và trạng thái hoàn trả.</p>
    </div>
    <a href="${pageContext.request.contextPath}/borrow/history" class="button secondary">
      <i class="bi bi-arrow-left"></i>
      Quay lại lịch sử
    </a>
  </div>

  <section class="profile-panel panel">
    <h2><c:out value="${record.book.title}"/></h2>
    <p class="muted" style="margin-bottom:14px;"><c:out value="${record.book.author}"/></p>

    <c:choose>
      <c:when test="${record.status eq 'ACTIVE' and record.overdue}">
        <span class="pill red">QUÁ HẠN</span>
      </c:when>
      <c:when test="${record.status eq 'ACTIVE'}">
        <span class="pill blue">ĐANG MƯỢN</span>
      </c:when>
      <c:when test="${record.status eq 'RETURNED'}">
        <span class="pill green">ĐÃ TRẢ</span>
      </c:when>
      <c:when test="${record.status eq 'RETURNED_LATE'}">
        <span class="pill amber">TRẢ TRỄ</span>
      </c:when>
    </c:choose>

    <dl>
      <div>
        <dt>Mã phiếu mượn</dt>
        <dd>#${record.id}</dd>
      </div>
      <div>
        <dt>Người mượn</dt>
        <dd><c:out value="${record.account.fullName}"/> (<c:out value="${record.account.username}"/>)</dd>
      </div>
      <div>
        <dt>Ngày mượn</dt>
        <dd>${record.borrowDate}</dd>
      </div>
      <div>
        <dt>Hạn trả</dt>
        <dd style="${record.overdue ? 'color:#dc7777;font-weight:600;' : ''}">${record.dueDate}</dd>
      </div>
      <div>
        <dt>Ngày trả thực tế</dt>
        <dd>${empty record.returnDate ? '—' : record.returnDate}</dd>
      </div>
      <div>
        <dt>Tiền phạt</dt>
        <dd>
          <c:choose>
            <c:when test="${record.fineAmount > 0}">
              <span class="pill ${record.finePaid ? 'green' : 'red'}">
                <fmt:formatNumber value="${record.fineAmount}" type="number" maxFractionDigits="0"/> ₫
                &middot; ${record.finePaid ? 'Đã thanh toán' : 'Chưa thanh toán'}
              </span>
            </c:when>
            <c:otherwise>
              <span class="green-text">Không có phạt</span>
            </c:otherwise>
          </c:choose>
        </dd>
      </div>
      <c:if test="${not empty record.notes}">
        <div>
          <dt>Ghi chú</dt>
          <dd><c:out value="${record.notes}"/></dd>
        </div>
      </c:if>
    </dl>

    <div style="display:flex;justify-content:center;gap:12px;flex-wrap:wrap;">
      <a href="${pageContext.request.contextPath}/borrow/history" class="button secondary">
        <i class="bi bi-arrow-left"></i>
        Quay lại
      </a>
      <c:if test="${record.fineAmount > 0 and not record.finePaid}">
        <form action="${pageContext.request.contextPath}/borrow/pay-fine/${record.id}" method="post"
              style="margin:0;" onsubmit="return confirm('Xác nhận thanh toán tiền phạt?')">
          <button type="submit" class="button soft">
            <i class="bi bi-cash-coin"></i>
            Thanh toán phạt
          </button>
        </form>
      </c:if>
      <c:if test="${sessionScope.currentUser.canManage() and record.status eq 'ACTIVE'}">
        <form action="${pageContext.request.contextPath}/borrow/return/${record.id}" method="post"
              style="margin:0;" onsubmit="return confirm('Xác nhận trả sách?')">
          <button type="submit" class="button primary">
            <i class="bi bi-check-lg"></i>
            Xác nhận trả sách
          </button>
        </form>
      </c:if>
    </div>
  </section>
</main>

<ui:footer/>
