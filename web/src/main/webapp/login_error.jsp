<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 7/2/2025
  Time: 12:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Error - Authentication Failed</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 25%, #ff8e53 50%, #ff6b9d 75%, #c44569 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        /* Animated background elements */
        .bg-animation {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }

        .floating-shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .floating-shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-shape:nth-child(2) {
            width: 60px;
            height: 60px;
            top: 60%;
            right: 20%;
            animation-delay: 2s;
        }

        .floating-shape:nth-child(3) {
            width: 100px;
            height: 100px;
            bottom: 30%;
            left: 15%;
            animation-delay: 4s;
        }

        .floating-shape:nth-child(4) {
            width: 40px;
            height: 40px;
            top: 40%;
            right: 10%;
            animation-delay: 1s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(180deg); }
        }

        /* Main container */
        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 50px 40px;
            text-align: center;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.3);
            max-width: 600px;
            width: 90%;
            position: relative;
            z-index: 2;
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(100px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Error icon */
        .error-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 30px;
            background: linear-gradient(45deg, #ff6b6b, #ff8e53);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: shake 0.5s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .error-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: shimmer 2s infinite;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .error-icon svg {
            width: 60px;
            height: 60px;
            fill: white;
        }

        /* Typography */
        .error-title {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .error-message {
            font-size: 1.3rem;
            color: #e74c3c;
            margin-bottom: 30px;
            line-height: 1.6;
            font-weight: 500;
            background: rgba(231, 76, 60, 0.1);
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #e74c3c;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        .error-description {
            font-size: 1.1rem;
            color: #7f8c8d;
            margin-bottom: 40px;
            line-height: 1.7;
        }

        /* Action buttons */
        .action-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            color: white;
            box-shadow: 0 5px 15px rgba(149, 165, 166, 0.3);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #2980b9, #3498db);
        }

        .btn-secondary:hover {
            background: linear-gradient(45deg, #7f8c8d, #95a5a6);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        /* Security tips */
        .security-tips {
            background: rgba(52, 152, 219, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            border-left: 4px solid #3498db;
        }

        .security-tips h3 {
            color: #3498db;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }

        .security-tips ul {
            list-style: none;
            text-align: left;
        }

        .security-tips li {
            color: #7f8c8d;
            margin-bottom: 8px;
            position: relative;
            padding-left: 25px;
        }

        .security-tips li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: #3498db;
            font-weight: bold;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .error-container {
                margin: 20px;
                padding: 30px 25px;
            }

            .error-title {
                font-size: 2rem;
            }

            .error-message {
                font-size: 1.1rem;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
            }
        }

        /* Loading animation for retry button */
        .btn-loading {
            position: relative;
            color: transparent;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }
    </style>
</head>
<body>
<!-- Animated background -->
<div class="bg-animation">
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
</div>

<!-- Main error container -->
<div class="error-container">
    <div class="error-icon">
        <svg viewBox="0 0 24 24">
            <path d="M12,2C17.53,2 22,6.47 22,12C22,17.53 17.53,22 12,22C6.47,22 2,17.53 2,12C2,6.47 6.47,2 12,2M15.59,7L12,10.59L8.41,7L7,8.41L10.59,12L7,15.59L8.41,17L12,13.41L15.59,17L17,15.59L13.41,12L17,8.41L15.59,7Z"/>
        </svg>
    </div>

    <h1 class="error-title">Login Failed</h1>

    <div class="error-message">
        <%
            String errorMessage = (String) request.getAttribute("jakarta.servlet.error.message");
            if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                out.println(errorMessage);
            } else {
                out.println("Authentication failed. Please check your credentials and try again.");
            }
        %>
    </div>

    <p class="error-description">
        Your login attempt was unsuccessful. This could be due to incorrect credentials,
        account restrictions, or security policies. Please verify your information and try again.
    </p>

    <div class="action-buttons">
        <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        <a href="/login" class="btn btn-primary" onclick="showLoading(this)">Try Again</a>
    </div>

    <div class="security-tips">
        <h3>Security Tips</h3>
        <ul>
            <li>Ensure your username and password are correct</li>
            <li>Check if Caps Lock is enabled</li>
            <li>Wait a few minutes if you've had multiple failed attempts</li>
            <li>Contact support if the issue persists</li>
        </ul>
    </div>
</div>

<script>
    // Add loading animation to retry button
    function showLoading(button) {
        button.classList.add('btn-loading');
        button.style.pointerEvents = 'none';

        setTimeout(() => {
            button.classList.remove('btn-loading');
            button.style.pointerEvents = 'auto';
        }, 2000);
    }

    // Add subtle parallax effect
    document.addEventListener('mousemove', function(e) {
        const shapes = document.querySelectorAll('.floating-shape');
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;

        shapes.forEach((shape, index) => {
            const speed = (index + 1) * 0.5;
            shape.style.transform = `translate(${x * speed}px, ${y * speed}px)`;
        });
    });

    // Auto-focus on retry button for keyboard navigation
    document.addEventListener('DOMContentLoaded', function() {
        const retryBtn = document.querySelector('.btn-primary');
        if (retryBtn) {
            retryBtn.focus();
        }
    });

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            const retryBtn = document.querySelector('.btn-primary');
            if (retryBtn) {
                retryBtn.click();
            }
        } else if (e.key === 'Escape') {
            history.back();
        }
    });
</script>
</body>
</html>