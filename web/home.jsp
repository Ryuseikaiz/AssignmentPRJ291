<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Medicine" %>
<%@ page import="dao.MedicineDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhà Thuốc MS - Trang Chủ</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .logo i {
            font-size: 2rem;
        }

        .search-bar {
            flex: 1;
            max-width: 600px;
            margin: 0 40px;
            position: relative;
        }

        .search-bar input {
            width: 100%;
            padding: 12px 50px 12px 20px;
            border: none;
            border-radius: 25px;
            font-size: 0.95rem;
            outline: none;
        }

        .search-bar button {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .header-actions {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .header-actions a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .header-actions a:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Navigation */
        .nav {
            background: white;
            border-bottom: 1px solid #e0e0e0;
            padding: 0;
        }

        .nav-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            gap: 30px;
        }

        .nav-content a {
            color: #333;
            text-decoration: none;
            padding: 15px 0;
            border-bottom: 3px solid transparent;
            transition: all 0.3s;
        }

        .nav-content a:hover,
        .nav-content a.active {
            color: #667eea;
            border-bottom-color: #667eea;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            padding: 40px 20px;
            margin-bottom: 30px;
        }

        .hero-content {
            max-width: 1400px;
            margin: 0 auto;
        }

        .hero h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .hero h1 span {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            color: #666;
            font-size: 1.1rem;
        }

        .features {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #667eea;
        }

        .feature-item i {
            font-size: 1.2rem;
        }

        /* Main Content */
        .main-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px 40px;
        }

        /* Category Tabs */
        .category-tabs {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .category-tabs button {
            padding: 10px 25px;
            border: 2px solid #667eea;
            background: white;
            color: #667eea;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 500;
            transition: all 0.3s;
        }

        .category-tabs button:hover,
        .category-tabs button.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        /* Section Header */
        .section-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .section-header h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }

        .section-header p {
            color: #666;
            font-size: 1.05rem;
        }

        /* Products Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .product-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
        }

        .product-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-image i {
            font-size: 4rem;
            color: #667eea;
            opacity: 0.3;
        }

        .discount-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: #e74c3c;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .wishlist-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 35px;
            height: 35px;
            background: white;
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
        }

        .wishlist-btn:hover {
            background: #667eea;
            color: white;
        }

        .product-info {
            padding: 20px;
        }

        .product-category {
            color: #667eea;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .product-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            min-height: 50px;
        }

        .product-description {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 12px;
            min-height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 15px;
        }

        .stars {
            color: #ffc107;
        }

        .rating-count {
            color: #999;
            font-size: 0.85rem;
        }

        .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }

        .product-price {
            display: flex;
            flex-direction: column;
        }

        .current-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
        }

        .original-price {
            font-size: 0.9rem;
            color: #999;
            text-decoration: line-through;
        }

        .stock-badge {
            background: #27ae60;
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .add-to-cart-btn {
            width: 100%;
            margin-top: 15px;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        /* No products message */
        .no-products {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .no-products i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        /* Rating Badge */
        .rating-badge {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: #27ae60;
            color: white;
            padding: 8px 15px;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .rating-badge .rating {
            font-weight: 700;
            font-size: 1rem;
        }

        .rating-badge .count {
            font-size: 0.75rem;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <%
        // Lấy danh sách thuốc từ database
        MedicineDAO medicineDAO = new MedicineDAO();
        List<Medicine> medicines = medicineDAO.getAllMedicines();
        
        // Format tiền tệ VNĐ
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    %>

    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-capsules"></i>
                <span>Nhà Thuốc MS</span>
            </div>
            
            <div class="search-bar">
                <input type="text" placeholder="Tìm kiếm thuốc, sản phẩm sức khỏe...">
                <button><i class="fas fa-search"></i></button>
            </div>
            
            <div class="header-actions">
                <a href="auth-login.jsp">
                    <i class="fas fa-user"></i>
                    <span>Tài khoản</span>
                </a>
                <a href="cart-view.jsp">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Giỏ hàng</span>
                </a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="nav">
        <div class="nav-content">
            <a href="home.jsp" class="active">Trang Chủ</a>
            <a href="#">Giảm Đau - Hạ Sốt</a>
            <a href="#">Vitamin</a>
            <a href="#">Thiết Bị Y Tế</a>
            <a href="#">Chăm Sóc Cá Nhân</a>
            <a href="#">Thực Phẩm Chức Năng</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Sức Khỏe Của Bạn, <span>Ưu Tiên Của Chúng Tôi</span></h1>
            <p>Cung cấp thuốc chính hãng, sản phẩm sức khỏe và tư vấn chuyên nghiệp đến tận nhà</p>
            
            <div class="features">
                <div class="feature-item">
                    <i class="fas fa-truck"></i>
                    <span>Giao hàng miễn phí đơn trên 500.000đ</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-clock"></i>
                    <span>Giao hàng trong 2-4 giờ</span>
                </div>
                <div class="feature-item">
                    <i class="fas fa-certificate"></i>
                    <span>Dược sĩ có chứng chỉ hành nghề</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Section Header -->
        <div class="section-header">
            <h2>Sản Phẩm Nổi Bật</h2>
            <p>Khám phá những sản phẩm sức khỏe và y tế phổ biến nhất của chúng tôi</p>
        </div>

        <!-- Category Tabs -->
        <div class="category-tabs">
            <button class="active">Tất Cả</button>
            <button>Giảm Đau</button>
            <button>Vitamin</button>
            <button>Thiết Bị Y Tế</button>
            <button>Chăm Sóc Cá Nhân</button>
            <button>Thực Phẩm Chức Năng</button>
        </div>

        <!-- Products Grid -->
        <div class="products-grid">
            <% 
            if (medicines != null && !medicines.isEmpty()) {
                int productCount = 0;
                for (Medicine medicine : medicines) {
                    productCount++;
                    // Tính discount ngẫu nhiên cho demo (25% hoặc 31%)
                    int discount = (productCount % 3 == 0) ? 25 : (productCount % 5 == 0) ? 31 : 0;
                    BigDecimal originalPriceBD = medicine.getPrice();
                    double originalPrice = originalPriceBD != null ? originalPriceBD.doubleValue() : 0.0;
                    double discountedPrice = discount > 0 ? originalPrice * (100 - discount) / 100 : originalPrice;
                    
                    // Rating ngẫu nhiên cho demo
                    double rating = 4.0 + (Math.random() * 1.0);
                    int reviewCount = 50 + (int)(Math.random() * 500);
            %>
            <div class="product-card">
                <div class="product-image">
                    <% if (medicine.getImagePath() != null && !medicine.getImagePath().isEmpty()) { %>
                        <img src="images/<%= medicine.getImagePath() %>" alt="<%= medicine.getName() %>">
                    <% } else { %>
                        <i class="fas fa-pills"></i>
                    <% } %>
                    
                    <% if (discount > 0) { %>
                        <div class="discount-badge">-<%= discount %>%</div>
                    <% } %>
                    
                    <button class="wishlist-btn">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
                
                <div class="product-info">
                    <div class="product-category"><%= medicine.getCategory() != null ? medicine.getCategory() : "Thuốc" %></div>
                    <div class="product-name"><%= medicine.getName() %></div>
                    <div class="product-description"><%= medicine.getDescription() != null ? medicine.getDescription() : "Sản phẩm chất lượng cao" %></div>
                    
                    <div class="product-rating">
                        <div class="stars">
                            <% 
                            int fullStars = (int) rating;
                            for (int i = 0; i < fullStars; i++) { %>
                                <i class="fas fa-star"></i>
                            <% } 
                            if (rating % 1 >= 0.5) { %>
                                <i class="fas fa-star-half-alt"></i>
                            <% }
                            for (int i = (int)Math.ceil(rating); i < 5; i++) { %>
                                <i class="far fa-star"></i>
                            <% } %>
                        </div>
                        <span class="rating-count"><%= String.format("%.1f", rating) %> (<%= reviewCount %>)</span>
                    </div>
                    
                    <div class="product-footer">
                        <div class="product-price">
                            <span class="current-price"><%= String.format("%,d", (long)discountedPrice) %>đ</span>
                            <% if (discount > 0) { %>
                                <span class="original-price"><%= String.format("%,d", (long)originalPrice) %>đ</span>
                            <% } %>
                        </div>
                        <span class="stock-badge">Còn hàng</span>
                    </div>
                    
                    <button class="add-to-cart-btn">
                        <i class="fas fa-shopping-cart"></i>
                        Thêm vào giỏ
                    </button>
                </div>
            </div>
            <% 
                }
            } else { 
            %>
            <div class="no-products">
                <i class="fas fa-box-open"></i>
                <h3>Không có sản phẩm nào</h3>
                <p>Vui lòng quay lại sau</p>
            </div>
            <% } %>
        </div>
    </main>

    <script>
        // Add to cart functionality
        document.querySelectorAll('.add-to-cart-btn').forEach(button => {
            button.addEventListener('click', function() {
                const productName = this.closest('.product-card').querySelector('.product-name').textContent;
                alert('Đã thêm "' + productName + '" vào giỏ hàng!');
            });
        });

        // Wishlist toggle
        document.querySelectorAll('.wishlist-btn').forEach(button => {
            button.addEventListener('click', function() {
                const icon = this.querySelector('i');
                if (icon.classList.contains('far')) {
                    icon.classList.remove('far');
                    icon.classList.add('fas');
                    this.style.color = '#e74c3c';
                } else {
                    icon.classList.remove('fas');
                    icon.classList.add('far');
                    this.style.color = '';
                }
            });
        });

        // Category filter
        document.querySelectorAll('.category-tabs button').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.category-tabs button').forEach(btn => {
                    btn.classList.remove('active');
                });
                this.classList.add('active');
            });
        });

        // Search functionality
        document.querySelector('.search-bar button').addEventListener('click', function() {
            const searchValue = document.querySelector('.search-bar input').value;
            if (searchValue.trim()) {
                alert('Đang tìm kiếm: ' + searchValue);
            }
        });
    </script>
</body>
</html>
