<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Pharmacy Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 500px;
            width: 100%;
            background: white;
            border-radius: 20px;
            padding: 50px 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
        }

        .logo-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .logo-icon i {
            color: white;
            font-size: 2rem;
        }

        .logo-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
        }

        .welcome-text {
            text-align: center;
            margin-bottom: 40px;
        }

        .welcome-text h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }

        .welcome-text p {
            color: #666;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .input-wrapper {
            position: relative;
        }

        .input-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .form-control {
            width: 100%;
            padding: 14px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .form-control.error {
            border-color: #ff4444;
        }

        .error-message {
            color: #ff4444;
            font-size: 0.8rem;
            margin-top: 5px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            user-select: none;
        }

        .password-strength {
            margin-top: 10px;
            height: 4px;
            background: #e0e0e0;
            border-radius: 2px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: all 0.3s;
        }

        .strength-weak { 
            width: 33%; 
            background: #ff4444; 
        }

        .strength-medium { 
            width: 66%; 
            background: #ffaa00; 
        }

        .strength-strong { 
            width: 100%; 
            background: #00c851; 
        }

        .terms {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
            font-size: 0.85rem;
            color: #666;
        }

        .terms input {
            margin-right: 10px;
            margin-top: 3px;
            cursor: pointer;
        }

        .terms a {
            color: #667eea;
            text-decoration: none;
        }

        .terms a:hover {
            text-decoration: underline;
        }

        .btn-primary {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-primary:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .signin-link {
            text-align: center;
            margin-top: 25px;
            color: #666;
            font-size: 0.9rem;
        }

        .signin-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .signin-link a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .alert-error {
            background: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }

        .divider {
            text-align: center;
            margin: 30px 0;
            position: relative;
        }

        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #e0e0e0;
        }

        .divider span {
            background: white;
            padding: 0 15px;
            color: #999;
            position: relative;
            font-size: 0.85rem;
        }

        .btn-google {
            width: 100%;
            padding: 14px;
            background: #333;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 0.95rem;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.3s;
        }

        .btn-google:hover {
            background: #222;
        }

        .btn-google i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        @media (max-width: 576px) {
            .container {
                padding: 40px 25px;
            }

            .welcome-text h2 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-prescription-bottle-alt"></i>
            </div>
            <div class="logo-text">Nhà Thuốc MS</div>
        </div>

        <div class="welcome-text">
            <h2>Tạo Tài Khoản</h2>
            <p>Đăng ký để bắt đầu sử dụng</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <% } %>

        <form action="auth-register" method="post" id="registerForm">
            <div class="form-group">
                <label for="fullName">Họ và tên</label>
                <div class="input-wrapper">
                    <i class="fas fa-user"></i>
                    <input type="text" id="fullName" name="fullName" class="form-control" 
                           placeholder="Nhập họ và tên đầy đủ" required>
                </div>
                <div class="error-message" id="nameError">Vui lòng nhập họ và tên</div>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="Nhập địa chỉ email" required>
                </div>
                <div class="error-message" id="emailError">Vui lòng nhập email hợp lệ</div>
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <div class="input-wrapper">
                    <i class="fas fa-phone"></i>
                    <input type="tel" id="phone" name="phone" class="form-control" 
                           placeholder="Nhập số điện thoại" required>
                </div>
                <div class="error-message" id="phoneError">Vui lòng nhập số điện thoại hợp lệ</div>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Tạo mật khẩu" required>
                    <span class="password-toggle" onclick="togglePassword('password', 'toggleIcon1')">
                        <i class="fas fa-eye" id="toggleIcon1"></i>
                    </span>
                </div>
                <div class="password-strength">
                    <div class="password-strength-bar" id="strengthBar"></div>
                </div>
                <div class="error-message" id="passwordError">Mật khẩu phải có ít nhất 6 ký tự</div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                           placeholder="Nhập lại mật khẩu" required>
                    <span class="password-toggle" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                        <i class="fas fa-eye" id="toggleIcon2"></i>
                    </span>
                </div>
                <div class="error-message" id="confirmError">Mật khẩu không khớp</div>
            </div>

            <label class="terms">
                <input type="checkbox" name="terms" id="terms" required>
                <span>Tôi đồng ý với <a href="#">Điều khoản & Điều kiện</a> và <a href="#">Chính sách bảo mật</a></span>
            </label>

            <button type="submit" class="btn-primary" id="submitBtn">Tạo tài khoản</button>
        </form>

        <div class="divider">
            <span>Hoặc đăng ký với</span>
        </div>

        <button class="btn-google" onclick="alert('Tính năng đăng ký Google chưa được triển khai')">
            <i class="fab fa-google"></i>
            Đăng ký với Google
        </button>

        <div class="signin-link">
            Đã có tài khoản? <a href="auth-login.jsp">Đăng nhập</a>
        </div>
    </div>

    <script>
        const form = document.getElementById('registerForm');
        const passwordInput = document.getElementById('password');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const strengthBar = document.getElementById('strengthBar');

        // Password strength checker
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = calculatePasswordStrength(password);
            
            strengthBar.className = 'password-strength-bar';
            if (password.length === 0) {
                strengthBar.style.width = '0';
            } else if (strength < 40) {
                strengthBar.classList.add('strength-weak');
            } else if (strength < 80) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        });

        function calculatePasswordStrength(password) {
            let strength = 0;
            if (password.length >= 6) strength += 25;
            if (password.length >= 10) strength += 25;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength += 25;
            if (/\d/.test(password)) strength += 15;
            if (/[^a-zA-Z\d]/.test(password)) strength += 10;
            return strength;
        }

        // Form validation
        form.addEventListener('submit', function(e) {
            let isValid = true;

            // Validate full name
            const fullName = document.getElementById('fullName');
            if (fullName.value.trim().length < 2) {
                showError(fullName, 'nameError');
                isValid = false;
            } else {
                hideError(fullName, 'nameError');
            }

            // Validate email
            const email = document.getElementById('email');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value)) {
                showError(email, 'emailError');
                isValid = false;
            } else {
                hideError(email, 'emailError');
            }

            // Validate phone
            const phone = document.getElementById('phone');
            const phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(phone.value.replace(/\s/g, ''))) {
                showError(phone, 'phoneError');
                isValid = false;
            } else {
                hideError(phone, 'phoneError');
            }

            // Validate password
            if (passwordInput.value.length < 6) {
                showError(passwordInput, 'passwordError');
                isValid = false;
            } else {
                hideError(passwordInput, 'passwordError');
            }

            // Validate confirm password
            if (confirmPasswordInput.value !== passwordInput.value) {
                showError(confirmPasswordInput, 'confirmError');
                isValid = false;
            } else {
                hideError(confirmPasswordInput, 'confirmError');
            }

            // Validate terms
            const terms = document.getElementById('terms');
            if (!terms.checked) {
                alert('Vui lòng đồng ý với Điều khoản & Điều kiện');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            }
        });

        function showError(input, errorId) {
            input.classList.add('error');
            document.getElementById(errorId).classList.add('show');
        }

        function hideError(input, errorId) {
            input.classList.remove('error');
            document.getElementById(errorId).classList.remove('show');
        }

        function togglePassword(inputId, iconId) {
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>
