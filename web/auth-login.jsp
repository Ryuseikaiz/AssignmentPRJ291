<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Pharmacy Management</title>
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
            display: flex;
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .left-panel {
            flex: 1;
            background-image: url('https://prod-cdn.pharmacity.io/blog/nha-thuoc-phamaricty-24-7-.jpg?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAUYXZVMJMURHIYJSN%2F20250106%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250106T081941Z&X-Amz-SignedHeaders=host&X-Amz-Expires=600&X-Amz-Signature=2982a74d3ad6130c6011cd33d0c525622c80685d1031813990b1ffb42c3a770a');
            background-size: cover;
            background-position: center;
            padding: 60px 40px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.3) 0%, rgba(118, 75, 162, 0.4) 100%);
        }

        .left-panel > * {
            position: relative;
            z-index: 1;
        }

        .left-panel h1 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .left-panel .features {
            margin-top: 40px;
            text-align: left;
        }

        .left-panel .feature {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 1.1rem;
        }

        .left-panel .feature i {
            margin-right: 15px;
            font-size: 1.5rem;
        }

        .left-panel .badge {
            margin-top: 30px;
            background: rgba(255, 255, 255, 0.2);
            padding: 10px 25px;
            border-radius: 50px;
            backdrop-filter: blur(10px);
            font-size: 0.9rem;
        }

        .right-panel {
            flex: 1;
            padding: 60px 50px;
        }

        .logo {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .logo-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .logo-icon i {
            color: white;
            font-size: 1.5rem;
        }

        .logo-text {
            font-size: 1.3rem;
            font-weight: 700;
            color: #333;
        }

        .welcome-text {
            margin-bottom: 40px;
        }

        .welcome-text h2 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 10px;
        }

        .welcome-text p {
            color: #666;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 25px;
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

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            user-select: none;
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            font-size: 0.9rem;
            color: #666;
        }

        .remember-me input {
            margin-right: 8px;
            cursor: pointer;
        }

        .forgot-password {
            color: #667eea;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .forgot-password:hover {
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

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:active {
            transform: translateY(0);
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

        .signup-link {
            text-align: center;
            margin-top: 25px;
            color: #666;
            font-size: 0.9rem;
        }

        .signup-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
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

        .alert-success {
            background: #efe;
            color: #3c3;
            border-left: 4px solid #3c3;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .left-panel {
                padding: 40px 30px;
            }

            .left-panel h1 {
                font-size: 1.8rem;
            }

            .left-panel .features {
                display: none;
            }

            .right-panel {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="features">
                <div class="feature">
                </div>
                <div class="feature">
                </div>
                <div class="feature">
                </div>
            </div>
            <div class="badge">

            </div>
        </div>

        <div class="right-panel">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-prescription-bottle-alt"></i>
                </div>
                <div class="logo-text">Nhà Thuốc MS</div>
            </div>

            <div class="welcome-text">
                <h2>Chào mừng trở lại</h2>
                <p>Vui lòng nhập thông tin đăng nhập của bạn</p>
            </div>

            <% String error = (String) request.getAttribute("error"); %>
            <% String success = (String) request.getAttribute("success"); %>
            
            <% if (error != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> <%= error %>
                </div>
            <% } %>
            
            <% if (success != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= success %>
                </div>
            <% } %>

            <form action="auth-login" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" class="form-control" 
                               placeholder="Email hoặc số điện thoại" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control" 
                               placeholder="Nhập mật khẩu" required>
                        <span class="password-toggle" onclick="togglePassword()">
                            <i class="fas fa-eye" id="toggleIcon"></i>
                        </span>
                    </div>
                </div>

                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember">
                        Ghi nhớ đăng nhập
                    </label>
                    <a href="#" class="forgot-password">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-primary">Đăng nhập</button>
            </form>

            <div class="divider">
                <span>Hoặc đăng nhập với Google</span>
            </div>

            <button class="btn-google" onclick="alert('Tính năng đăng nhập Google chưa được triển khai')">
                <i class="fab fa-google"></i>
                Đăng nhập với Google
            </button>

            <div class="signup-link">
                Chưa có tài khoản? <a href="auth-register.jsp">Đăng ký ngay</a>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>
