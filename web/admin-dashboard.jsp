<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Employee" %>
<%
    Employee admin = (Employee) session.getAttribute("employee");
    if (admin == null) {
        response.sendRedirect("auth-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pharmacy Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }

        .dashboard {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: all 0.3s;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 25px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo-icon {
            width: 45px;
            height: 45px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
        }

        .logo-icon i {
            font-size: 1.4rem;
        }

        .logo-text {
            font-size: 1.2rem;
            font-weight: 700;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
        }

        .menu-item:hover,
        .menu-item.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid white;
            padding-left: 16px;
        }

        .menu-item i {
            width: 25px;
            margin-right: 15px;
            font-size: 1.1rem;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            padding: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            font-size: 1.2rem;
        }

        .user-details {
            flex: 1;
        }

        .user-name {
            font-weight: 600;
            font-size: 0.9rem;
        }

        .user-role {
            font-size: 0.75rem;
            color: rgba(255, 255, 255, 0.7);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            transition: all 0.3s;
        }

        .top-bar {
            background: white;
            padding: 20px 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .search-bar {
            flex: 1;
            max-width: 400px;
            position: relative;
        }

        .search-bar i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .search-bar input {
            width: 100%;
            padding: 10px 15px 10px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.9rem;
            transition: all 0.3s;
        }

        .search-bar input:focus {
            outline: none;
            border-color: #667eea;
        }

        .top-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-btn {
            position: relative;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #f5f7fa;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }

        .notification-btn:hover {
            background: #e8ebf0;
        }

        .notification-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 8px;
            height: 8px;
            background: #ff4444;
            border-radius: 50%;
        }

        .content-area {
            padding: 30px;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 5px;
        }

        .page-subtitle {
            color: #666;
            font-size: 0.9rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .stat-icon.blue {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }

        .stat-icon.green {
            background: rgba(0, 200, 81, 0.1);
            color: #00c851;
        }

        .stat-icon.orange {
            background: rgba(255, 170, 0, 0.1);
            color: #ffaa00;
        }

        .stat-icon.red {
            background: rgba(255, 68, 68, 0.1);
            color: #ff4444;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }

        .stat-trend {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-top: 10px;
        }

        .stat-trend.up {
            background: rgba(0, 200, 81, 0.1);
            color: #00c851;
        }

        .stat-trend.down {
            background: rgba(255, 68, 68, 0.1);
            color: #ff4444;
        }

        .stat-trend i {
            margin-right: 5px;
        }

        /* Charts */
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .chart-header {
            margin-bottom: 20px;
        }

        .chart-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
        }

        .chart-subtitle {
            font-size: 0.85rem;
            color: #666;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .action-btn {
            padding: 15px 20px;
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            display: flex;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: #333;
        }

        .action-btn:hover {
            border-color: #667eea;
            background: #f8f9ff;
            transform: translateY(-2px);
        }

        .action-btn i {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .action-btn-text {
            font-weight: 600;
            font-size: 0.95rem;
        }

        @media (max-width: 768px) {
            .sidebar {
                margin-left: -260px;
            }

            .sidebar.mobile-open {
                margin-left: 0;
            }

            .main-content {
                margin-left: 0;
            }

            .stats-grid,
            .charts-grid,
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon">
                        <i class="fas fa-prescription-bottle-alt"></i>
                    </div>
                    <div class="logo-text">Nhà Thuốc MS</div>
                </div>
            </div>

            <nav class="sidebar-menu">
                <a href="#" class="menu-item active">
                    <i class="fas fa-home"></i>
                    <span>Tổng quan</span>
                </a>
                <a href="products.jsp" class="menu-item">
                    <i class="fas fa-pills"></i>
                    <span>Quản lý thuốc</span>
                </a>
                <a href="suppliers.jsp" class="menu-item">
                    <i class="fas fa-truck"></i>
                    <span>Nhà cung cấp</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Đơn hàng</span>
                </a>
                <a href="customer-view-products.jsp" class="menu-item">
                    <i class="fas fa-users"></i>
                    <span>Khách hàng</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-chart-bar"></i>
                    <span>Báo cáo</span>
                </a>
                <a href="#" class="menu-item">
                    <i class="fas fa-cog"></i>
                    <span>Cài đặt</span>
                </a>
            </nav>

            <div class="sidebar-footer">
                <div class="user-info">
                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="user-details">
                        <div class="user-name"><%= admin.getFullName() %></div>
                        <div class="user-role"><%= admin.getRole() %></div>
                    </div>
                    <a href="logout" style="color: white; margin-left: 10px;">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Tìm kiếm thuốc, đơn hàng, khách hàng...">
                </div>
                <div class="top-actions">
                    <button class="notification-btn">
                        <i class="fas fa-bell"></i>
                        <span class="notification-badge"></span>
                    </button>
                    <button class="notification-btn">
                        <i class="fas fa-envelope"></i>
                    </button>
                </div>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <div class="page-header">
                    <h1 class="page-title">Bảng Điều Khiển</h1>
                    <p class="page-subtitle">Chào mừng trở lại, <%= admin.getFullName() %>! Đây là tình hình hôm nay.</p>
                </div>

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon blue">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                        </div>
                        <div class="stat-value">1,234</div>
                        <div class="stat-label">Tổng đơn hàng</div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i>
                            12.5% so với tháng trước
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon green">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                        </div>
                        <div class="stat-value">45,678,000₫</div>
                        <div class="stat-label">Doanh thu</div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i>
                            8.2% so với tháng trước
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon orange">
                                <i class="fas fa-pills"></i>
                            </div>
                        </div>
                        <div class="stat-value">567</div>
                        <div class="stat-label">Loại thuốc</div>
                        <div class="stat-trend down">
                            <i class="fas fa-arrow-down"></i>
                            3 sắp hết hàng
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon red">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                        <div class="stat-value">2,891</div>
                        <div class="stat-label">Khách hàng</div>
                        <div class="stat-trend up">
                            <i class="fas fa-arrow-up"></i>
                            156 khách mới tháng này
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions">
                    <a href="product-form.jsp" class="action-btn">
                        <i class="fas fa-plus"></i>
                        <span class="action-btn-text">Thêm thuốc mới</span>
                    </a>
                    <a href="#" class="action-btn">
                        <i class="fas fa-file-invoice"></i>
                        <span class="action-btn-text">Tạo đơn hàng</span>
                    </a>
                    <a href="supplier-form.jsp" class="action-btn">
                        <i class="fas fa-truck-loading"></i>
                        <span class="action-btn-text">Thêm nhà cung cấp</span>
                    </a>
                    <a href="#" class="action-btn">
                        <i class="fas fa-chart-line"></i>
                        <span class="action-btn-text">Xem báo cáo</span>
                    </a>
                </div>

                <!-- Charts -->
                <div class="charts-grid">
                    <div class="chart-card">
                        <div class="chart-header">
                            <div class="chart-title">Tổng quan doanh số</div>
                            <div class="chart-subtitle">Hiệu suất bán hàng theo tháng</div>
                        </div>
                        <canvas id="salesChart"></canvas>
                    </div>

                    <div class="chart-card">
                        <div class="chart-header">
                            <div class="chart-title">Danh mục bán chạy nhất</div>
                            <div class="chart-subtitle">Các loại thuốc có hiệu suất tốt nhất</div>
                        </div>
                        <canvas id="categoriesChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Sales Chart
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6'],
                datasets: [{
                    label: 'Doanh số',
                    data: [12000000, 19000000, 15000000, 25000000, 22000000, 30000000],
                    borderColor: '#667eea',
                    backgroundColor: 'rgba(102, 126, 234, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Categories Chart
        const categoriesCtx = document.getElementById('categoriesChart').getContext('2d');
        new Chart(categoriesCtx, {
            type: 'doughnut',
            data: {
                labels: ['Giảm đau', 'Kháng sinh', 'Vitamin', 'Cảm cúm', 'Khác'],
                datasets: [{
                    data: [30, 25, 20, 15, 10],
                    backgroundColor: [
                        '#667eea',
                        '#764ba2',
                        '#f093fb',
                        '#4facfe',
                        '#00f2fe'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    </script>
</body>
</html>
