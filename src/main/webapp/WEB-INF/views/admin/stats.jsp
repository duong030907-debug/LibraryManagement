<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thống Kê & Báo Cáo" scope="request"/>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>${pageTitle} — Thư Viện Sách</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/app.css">
</head><body><div class="app">
<header class="header"><div class="nav-container"><a class="brand" href="${pageContext.request.contextPath}/books"><span class="brand-icon"><i class="bi bi-book-half"></i></span><span>Thư Viện<span class="brand-light"> Sách</span></span></a><button class="mobile-toggle" type="button" aria-label="Mở điều hướng" onclick="toggleMobileNav()"><i class="bi bi-list"></i></button><nav class="main-nav" id="mainNav"><a href="${pageContext.request.contextPath}/books" class="nav-link"><i class="bi bi-journals"></i>Sách</a><a href="${pageContext.request.contextPath}/documents" class="nav-link"><i class="bi bi-file-earmark-text"></i>Tài liệu số</a><c:if test="${sessionScope.currentUser != null}"><a href="${pageContext.request.contextPath}/borrow/active" class="nav-link"><i class="bi bi-bookmark-check"></i>Đang mượn</a><a href="${pageContext.request.contextPath}/borrow/history" class="nav-link"><i class="bi bi-clock-history"></i>Lịch sử</a><c:if test="${sessionScope.currentUser.canManage()}"><a href="${pageContext.request.contextPath}/admin" class="nav-link"><i class="bi bi-grid"></i>Trung tâm quản trị</a></c:if></c:if></nav><div class="account dropdown"><c:choose><c:when test="${sessionScope.currentUser != null}"><button type="button" class="account-button" onclick="toggleDropdown('accountDropdown', event)"><span class="avatar">${fn:substring(sessionScope.currentUser.fullName,0,2)}</span><span class="account-info"><strong>${sessionScope.currentUser.fullName}</strong><small>${sessionScope.currentUser.role}</small></span><i class="bi bi-chevron-down"></i></button><div class="dropdown-menu right" id="accountDropdown"><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-person"></i>Tài khoản</a><a href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i>Đăng xuất</a></div></c:when><c:otherwise><a href="${pageContext.request.contextPath}/login" class="button light">Đăng nhập</a><a href="${pageContext.request.contextPath}/register" class="button primary">Đăng ký</a></c:otherwise></c:choose></div></div></header>

<main class="main-container">
  <div class="breadcrumb">
    <i class="bi bi-house-door"></i>
    <span>/</span>
    <span>Thống kê &amp; Báo cáo</span>
  </div>

  <div class="page-heading">
    <div>
      <div class="eyebrow">TỔNG QUAN THƯ VIỆN</div>
      <h1>Thống kê &amp; Báo cáo</h1>
      <p>Theo dõi hoạt động mượn trả và tình trạng kho sách.</p>
    </div>
    <div class="year-select">
      <i class="bi bi-calendar3"></i>
      <span>Tháng ${monthly['month']}</span>
    </div>
  </div>

  <!-- 4 Thẻ thống kê chính -->
  <div class="stat-grid">
    <div class="stat-card">
      <span class="stat-icon blue">
        <i class="bi bi-book"></i>
      </span>
      <p>Tổng đầu sách</p>
      <strong>${inventory['totalTitles']}</strong>
      <small>Còn ${inventory['availableCopies']} / ${inventory['totalCopies']} bản trong kho</small>
    </div>

    <div class="stat-card">
      <span class="stat-icon green">
        <i class="bi bi-arrow-left-right"></i>
      </span>
      <p>Đang cho mượn</p>
      <strong>${inventory['borrowedCopies']}</strong>
      <small>Hoạt động hiện tại</small>
    </div>

    <a href="${pageContext.request.contextPath}/borrow/overdue" class="stat-card">
      <span class="stat-icon red">
        <i class="bi bi-exclamation-triangle"></i>
      </span>
      <p>Đang quá hạn</p>
      <strong>${overdueCount}</strong>
      <small>
        Xem danh sách <i class="bi bi-arrow-right"></i>
      </small>
    </a>

    <div class="stat-card">
      <span class="stat-icon amber">
        <i class="bi bi-cash-coin"></i>
      </span>
      <p>Tổng tiền phạt đã thu</p>
      <strong>
        <fmt:formatNumber value="${revenue['totalFinesCollected']}" type="number" maxFractionDigits="0"/>
        <span>₫</span>
      </strong>
      <small>Từ tất cả bản ghi đã thanh toán</small>
    </div>
  </div>

  <!-- Báo cáo hoạt động & Bảng xếp hạng -->
  <div class="report-grid">
    <section class="panel">
      <div class="panel-heading">
        <h2>
          <i class="bi bi-bar-chart"></i>
          Hoạt động mượn trả
        </h2>
        <span class="muted">Tháng ${monthly['month']}</span>
      </div>

      <div class="chart-legend">
        <span>
          <b class="legend-dot"></b>
          Lượt mượn (${monthly['totalBorrows']})
        </span>
        <span>
          <b class="legend-dot returns"></b>
          Lượt trả (${monthly['totalReturns']})
        </span>
      </div>

      <div class="bar-chart">
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:35%"></div>
            <div class="bar return-bar" style="height:28%"></div>
          </div>
          <small>T1</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:48%"></div>
            <div class="bar return-bar" style="height:40%"></div>
          </div>
          <small>T2</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:42%"></div>
            <div class="bar return-bar" style="height:36%"></div>
          </div>
          <small>T3</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:60%"></div>
            <div class="bar return-bar" style="height:52%"></div>
          </div>
          <small>T4</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:54%"></div>
            <div class="bar return-bar" style="height:46%"></div>
          </div>
          <small>T5</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:75%"></div>
            <div class="bar return-bar" style="height:66%"></div>
          </div>
          <small>T6</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:58%"></div>
            <div class="bar return-bar" style="height:50%"></div>
          </div>
          <small>T7</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:68%"></div>
            <div class="bar return-bar" style="height:58%"></div>
          </div>
          <small>T8</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:82%"></div>
            <div class="bar return-bar" style="height:72%"></div>
          </div>
          <small>T9</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:64%"></div>
            <div class="bar return-bar" style="height:56%"></div>
          </div>
          <small>T10</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:88%"></div>
            <div class="bar return-bar" style="height:76%"></div>
          </div>
          <small>T11</small>
        </div>
        <div class="bar-column">
          <div class="bar-pair">
            <div class="bar borrow-bar" style="height:72%"></div>
            <div class="bar return-bar" style="height:64%"></div>
          </div>
          <small>T12</small>
        </div>
      </div>

      <p class="chart-caption">
        Tháng ${monthly['month']}: <strong>${monthly['totalBorrows']}</strong> lượt mượn &middot;
        <strong>${monthly['totalReturns']}</strong> lượt trả &middot;
        <strong>${monthly['currentOverdue']}</strong> đang quá hạn
      </p>
    </section>

    <section class="panel">
      <div class="panel-heading">
        <h2>
          <i class="bi bi-trophy"></i>
          Sách được yêu thích
        </h2>
        <span class="pill blue">TOP ${fn:length(mostBorrowed)}</span>
      </div>

      <c:if test="${empty mostBorrowed}">
        <div class="empty-state" style="padding:40px 10px;">
          <i class="bi bi-trophy"></i>
          <p>Chưa có dữ liệu mượn sách.</p>
        </div>
      </c:if>

      <c:if test="${not empty mostBorrowed}">
        <div class="ranking-list">
          <c:forEach var="stat" items="${mostBorrowed}" varStatus="s">
            <div class="ranking-item">
              <span class="rank rank-${s.index}">
                ${s.index + 1 < 10 ? '0' : ''}${s.index + 1}
              </span>
              <div>
                <strong><c:out value="${stat['title']}"/></strong>
                <small><c:out value="${stat['author']}"/></small>
              </div>
              <span class="rank-count">
                ${stat['borrowCount']}
                <small>lượt mượn</small>
              </span>
            </div>
          </c:forEach>
        </div>
      </c:if>
    </section>
  </div>

  <!-- Tồn kho sách tổng hợp -->
  <section class="table-panel">
    <div class="panel-heading">
      <h2>
        <i class="bi bi-archive"></i>
        Tổng quan tồn kho thư viện
      </h2>
      <span class="muted">${inventory['totalTitles']} đầu sách</span>
    </div>
    <table>
      <thead>
        <tr>
          <th>Chỉ tiêu</th>
          <th>Số lượng</th>
          <th>Trạng thái</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="table-title">Tổng số đầu sách</td>
          <td>${inventory['totalTitles']} đầu sách</td>
          <td><span class="pill blue">Danh mục hiện hành</span></td>
        </tr>
        <tr>
          <td class="table-title">Tổng số bản sách</td>
          <td>${inventory['totalCopies']} bản</td>
          <td><span class="pill blue">Toàn thư viện</span></td>
        </tr>
        <tr>
          <td class="table-title">Số bản sẵn có trên kệ</td>
          <td class="green-text">${inventory['availableCopies']} bản</td>
          <td><span class="pill green">Sẵn sàng cho mượn</span></td>
        </tr>
        <tr>
          <td class="table-title">Số bản đang cho mượn</td>
          <td>${inventory['borrowedCopies']} bản</td>
          <td><span class="pill amber">Đang lưu hành</span></td>
        </tr>
      </tbody>
    </table>
  </section>
</main>

<footer class="footer"><div><span><i class="bi bi-book-half"></i> Thư Viện Sách</span><p>Kết nối tri thức. Nuôi dưỡng tương lai.</p></div><p>Created by <strong>Ngô Đức Hải</strong><span class="footer-separator"> · </span>24211TT2856</p><span class="footer-year">© 2026 Thư Viện Sách</span></footer></div><script src="${pageContext.request.contextPath}/static/app.js"></script></body></html>
