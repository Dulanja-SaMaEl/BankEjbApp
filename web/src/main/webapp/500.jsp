<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error - Something Went Wrong</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #f093fb 50%, #f5576c 75%, #4facfe 100%);
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

        .glitch-orb {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: glitchFloat 4s ease-in-out infinite;
        }

        .glitch-orb:nth-child(1) {
            width: 120px;
            height: 120px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .glitch-orb:nth-child(2) {
            width: 80px;
            height: 80px;
            top: 70%;
            right: 20%;
            animation-delay: 1s;
        }

        .glitch-orb:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 30%;
            animation-delay: 2s;
        }

        .glitch-orb:nth-child(4) {
            width: 100px;
            height: 100px;
            top: 30%;
            right: 10%;
            animation-delay: 0.5s;
        }

        @keyframes glitchFloat {
            0%, 100% {
                transform: translateY(0px) scale(1);
                opacity: 0.7;
            }
            25% {
                transform: translateY(-20px) scale(1.1);
                opacity: 0.9;
            }
            50% {
                transform: translateY(-40px) scale(0.9);
                opacity: 0.5;
            }
            75% {
                transform: translateY(-10px) scale(1.05);
                opacity: 0.8;
            }
        }

        /* Main error container */
        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 60px 50px;
            text-align: center;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.3);
            max-width: 700px;
            width: 90%;
            position: relative;
            z-index: 2;
            animation: emergencySlide 1s ease-out;
        }

        @keyframes emergencySlide {
            0% {
                opacity: 0;
                transform: translateY(100px) scale(0.8);
            }
            50% {
                opacity: 0.7;
                transform: translateY(-20px) scale(1.1);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Error code display */
        .error-code {
            font-size: 8rem;
            font-weight: 900;
            color: #e74c3c;
            margin-bottom: 20px;
            text-shadow: 0 0 30px rgba(231, 76, 60, 0.3);
            animation: glitch 2s infinite;
            position: relative;
            display: inline-block;
        }

        @keyframes glitch {
            0%, 100% {
                transform: translate(0);
                filter: hue-rotate(0deg);
            }
            2% {
                transform: translate(2px, 0);
                filter: hue-rotate(90deg);
            }
            4% {
                transform: translate(-2px, 0);
                filter: hue-rotate(180deg);
            }
            6% {
                transform: translate(0);
                filter: hue-rotate(270deg);
            }
            8% {
                transform: translate(2px, 0);
                filter: hue-rotate(360deg);
            }
            10% {
                transform: translate(0);
                filter: hue-rotate(0deg);
            }
        }

        /* Status code display */
        .status-info {
            background: rgba(231, 76, 60, 0.1);
            border-radius: 15px;
            padding: 20px;
            margin: 30px 0;
            border-left: 5px solid #e74c3c;
            animation: pulse 2s infinite;
        }

        .status-code {
            font-size: 1.5rem;
            font-weight: 700;
            color: #e74c3c;
            margin-bottom: 10px;
        }

        .status-message {
            font-size: 1.2rem;
            color: #2c3e50;
            font-weight: 500;
            line-height: 1.6;
        }

        /* Server icon */
        .server-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 30px;
            background: linear-gradient(45deg, #e74c3c, #f39c12);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: serverError 1.5s ease-in-out infinite;
            position: relative;
            overflow: hidden;
        }

        .server-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: errorShimmer 3s infinite;
        }

        @keyframes serverError {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 0 20px rgba(231, 76, 60, 0.3);
            }
            50% {
                transform: scale(1.1);
                box-shadow: 0 0 40px rgba(231, 76, 60, 0.6);
            }
        }

        @keyframes errorShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .server-icon svg {
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

        .error-description {
            font-size: 1.2rem;
            color: #7f8c8d;
            margin-bottom: 40px;
            line-height: 1.7;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Action buttons */
        .action-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 40px;
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

        .btn-danger {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
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

        /* Technical details */
        .technical-details {
            background: rgba(44, 62, 80, 0.05);
            border-radius: 15px;
            padding: 25px;
            margin-top: 40px;
            text-align: left;
            border: 1px solid rgba(44, 62, 80, 0.1);
        }

        .technical-details h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .technical-details ul {
            list-style: none;
            color: #7f8c8d;
            line-height: 1.8;
        }

        .technical-details li {
            position: relative;
            padding-left: 25px;
            margin-bottom: 8px;
        }

        .technical-details li::before {
            content: '⚠️';
            position: absolute;
            left: 0;
            top: 0;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .error-container {
                margin: 20px;
                padding: 40px 30px;
            }

            .error-code {
                font-size: 6rem;
            }

            .error-title {
                font-size: 2rem;
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

        /* Loading animation for refresh */
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

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
<!-- Animated background -->
<div class="bg-animation">
    <div class="glitch-orb"></div>
    <div class="glitch-orb"></div>
    <div class="glitch-orb"></div>
    <div class="glitch-orb"></div>
</div>

<!-- Main error container -->
<div class="error-container">
    <div class="server-icon">
        <svg viewBox="0 0 24 24">
            <path d="M4,1H20A1,1 0 0,1 21,2V6A1,1 0 0,1 20,7H4A1,1 0 0,1 3,6V2A1,1 0 0,1 4,1M4,9H20A1,1 0 0,1 21,10V14A1,1 0 0,1 20,15H4A1,1 0 0,1 3,14V10A1,1 0 0,1 4,9M4,17H20A1,1 0 0,1 21,18V22A1,1 0 0,1 20,23H4A1,1 0 0,1 3,22V18A1,1 0 0,1 4,17M5,2V6H19V2H5M5,10V14H19V10H5M5,18V22H19V18H5M7,4V4.5H9V4H7M7,12V12.5H9V12H7M7,20V20.5H9V20H7"/>
        </svg>
    </div>

    <div class="error-code">500</div>

    <h1 class="error-title">Internal Server Error</h1>

    <p class="error-description">
        Oops! Something went wrong on our end. Our servers are experiencing technical difficulties.
        Please try again in a few moments.
    </p>

    <div class="status-info">
        <div class="status-code">
            Status Code:
            <%
                Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
                if (statusCode != null) {
                    out.println(statusCode);
                } else {
                    out.println("500");
                }
            %>
        </div>
        <div class="status-message">
            <%
                String errorMessage = (String) request.getAttribute("jakarta.servlet.error.message");
                if (errorMessage != null && !errorMessage.trim().isEmpty()) {
                    out.println("Error: " + errorMessage);
                } else {
                    out.println("The server encountered an unexpected condition that prevented it from fulfilling your request.");
                }
            %>
        </div>
    </div>

    <div class="action-buttons">
        <a href="javascript:location.reload()" class="btn btn-primary" onclick="showLoading(this)">
            Refresh Page
        </a>
        <a href="javascript:history.back()" class="btn btn-secondary">
            Go Back
        </a>
        <a href="/" class="btn btn-danger">
            Home Page
        </a>
    </div>

    <div class="technical-details">
        <h3>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M11,9H13V7H11M12,20C7.59,20 4,16.41 4,12C4,7.59 7.59,4 12,4C16.41,4 20,7.59 20,12C20,16.41 16.41,20 12,20M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M11,17H13V11H11V17Z"/>
            </svg>
            What happened?
        </h3>
        <ul>
            <li>The server encountered an internal error or misconfiguration</li>
            <li>This is a temporary issue and should be resolved shortly</li>
            <li>Our technical team has been automatically notified</li>
            <li>If the problem persists, please contact our support team</li>
        </ul>
    </div>
</div>

<script>
    // Add loading animation to refresh button
    function showLoading(button) {
        button.classList.add('btn-loading');
        button.style.pointerEvents = 'none';

        setTimeout(() => {
            location.reload();
        }, 1000);
    }

    // Add glitch effect to background orbs
    document.addEventListener('mousemove', function(e) {
        const orbs = document.querySelectorAll('.glitch-orb');
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;

        orbs.forEach((orb, index) => {
            const speed = (index + 1) * 0.3;
            const randomOffset = Math.sin(Date.now() * 0.001 + index) * 5;
            orb.style.transform = `translate(${x * speed + randomOffset}px, ${y * speed + randomOffset}px)`;
        });
    });

    // Auto-refresh every 30 seconds
    let autoRefreshTimer = setTimeout(function() {
        if (confirm('Would you like to refresh the page to try again?')) {
            location.reload();
        }
    }, 30000);

    // Clear auto-refresh if user interacts
    document.addEventListener('click', function() {
        clearTimeout(autoRefreshTimer);
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.key === 'r' || e.key === 'R') {
            location.reload();
        } else if (e.key === 'Escape') {
            history.back();
        } else if (e.key === 'h' || e.key === 'H') {
            window.location.href = '/';
        }
    });

    // Add random glitch effect to error code
    setInterval(function() {
        const errorCode = document.querySelector('.error-code');
        if (Math.random() < 0.1) { // 10% chance every second
            errorCode.style.animation = 'none';
            setTimeout(() => {
                errorCode.style.animation = 'glitch 2s infinite';
            }, 100);
        }
    }, 1000);
</script>
</body>
</html>