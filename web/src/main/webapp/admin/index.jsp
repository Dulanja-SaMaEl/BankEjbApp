<%@ page import="java.util.List" %>
<%@ page import="com.graynode.ee.core.entity.Account" %>
<%@ page import="com.graynode.ee.core.entity.User" %>
<%@ page import="com.graynode.ee.core.entity.Status" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | GrayNode</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
            line-height: 1.6;
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: slideDown 0.8s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .welcome-section {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .welcome-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .welcome-text h1 {
            font-size: 1.8rem;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.2rem;
        }

        .welcome-text p {
            color: #666;
            font-size: 0.9rem;
        }

        .logout-btn {
            background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .card-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #333;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #555;
        }

        .form-input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-primary {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(45deg, #4facfe, #00f2fe);
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.3);
        }

        .accounts-section {
            grid-column: 1 / -1;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 16px;
            background: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .modern-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .modern-table th {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            border: none;
        }

        .modern-table th:first-child {
            border-radius: 16px 0 0 0;
        }

        .modern-table th:last-child {
            border-radius: 0 16px 0 0;
        }

        .modern-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
            transition: background-color 0.3s ease;
        }

        .modern-table tr:hover td {
            background-color: #f8f9ff;
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: linear-gradient(45deg, #4caf50, #81c784);
            color: white;
        }

        .status-inactive {
            background: linear-gradient(45deg, #f44336, #ef5350);
            color: white;
        }

        .action-btn {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-activate {
            background: linear-gradient(45deg, #4caf50, #81c784);
            color: white;
        }

        .btn-deactivate {
            background: linear-gradient(45deg, #f44336, #ef5350);
            color: white;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .balance-amount {
            font-weight: 700;
            color: #2e7d32;
        }

        .loading {
            opacity: 0.7;
            pointer-events: none;
        }

        @media (max-width: 768px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .dashboard-container {
                padding: 1rem;
            }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .floating {
            animation: floating 3s ease-in-out infinite;
        }

        @keyframes floating {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Header -->
    <div class="header">
        <div class="welcome-section">
            <div class="welcome-icon floating">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="welcome-text">
                <h1>Welcome back, ${pageContext.request.userPrincipal.name}!</h1>
                <p>Manage your system with ease</p>
            </div>
        </div>
        <form method="POST" action="${pageContext.request.contextPath}/logout">
            <button type="submit" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i>
                Logout
            </button>
        </form>
    </div>

    <!-- Main Grid -->
    <div class="grid">
        <!-- Register User Card -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h2 class="card-title">Register New User</h2>
            </div>
            <form method="POST" action="${pageContext.request.contextPath}/register">
                <div class="form-group">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="name" class="form-input" placeholder="Enter full name" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Email Address</label>
                    <input type="email" name="email" class="form-input" placeholder="Enter email address" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-input" placeholder="Enter password" required>
                </div>
                <button type="submit" class="btn-primary">
                    <i class="fas fa-user-plus"></i>
                    Register User
                </button>
            </form>
        </div>

        <!-- Quick Stats Card -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h2 class="card-title">System Overview</h2>
            </div>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 1rem;">
                <div style="text-align: center; padding: 1rem; background: linear-gradient(45deg, #4facfe, #00f2fe); border-radius: 12px; color: white;">
                    <i class="fas fa-users" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                    <div style="font-size: 1.5rem; font-weight: 700;">
                        <%
                            List<Account> accounts = (List<Account>) request.getAttribute("accounts");
                            int totalAccounts = accounts != null ? accounts.size() : 0;
                        %>
                        <%= totalAccounts %>
                    </div>
                    <div style="font-size: 0.9rem;">Total Accounts</div>
                </div>
                <div style="text-align: center; padding: 1rem; background: linear-gradient(45deg, #4caf50, #81c784); border-radius: 12px; color: white;">
                    <i class="fas fa-check-circle" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                    <div style="font-size: 1.5rem; font-weight: 700;">
                        <%
                            int activeAccounts = 0;
                            if (accounts != null) {
                                for (Account acc : accounts) {
                                    if ("Active".equalsIgnoreCase(acc.getStatus().getName())) {
                                        activeAccounts++;
                                    }
                                }
                            }
                        %>
                        <%= activeAccounts %>
                    </div>
                    <div style="font-size: 0.9rem;">Active Users</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Accounts Section -->
    <div class="card accounts-section">
        <div class="card-header">
            <div class="card-icon">
                <i class="fas fa-users-cog"></i>
            </div>
            <h2 class="card-title">User Account Management</h2>
        </div>

        <form method="GET" action="${pageContext.request.contextPath}/admin/accounts">
            <button type="submit" class="btn-secondary">
                <i class="fas fa-sync-alt"></i>
                Refresh Accounts
            </button>
        </form>

        <div class="table-container">
            <table class="modern-table">
                <thead>
                <tr>
                    <th><i class="fas fa-hashtag"></i> Account ID</th>
                    <th><i class="fas fa-user"></i> User</th>
                    <th><i class="fas fa-envelope"></i> Email</th>
                    <th><i class="fas fa-wallet"></i> Balance</th>
                    <th><i class="fas fa-toggle-on"></i> Status</th>
                    <th><i class="fas fa-cogs"></i> Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (accounts != null && !accounts.isEmpty()) {
                        for (Account acc : accounts) {
                            User user = acc.getUser();
                            Status status = acc.getStatus();
                            boolean isActive = "Active".equalsIgnoreCase(status.getName());
                            int toggleStatusId = isActive ? 2 : 1;
                %>
                <tr>
                    <td><%= acc.getId() %></td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <div style="width: 32px; height: 32px; background: linear-gradient(45deg, #667eea, #764ba2); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: 600;">
                                <%= user.getName().substring(0, 1).toUpperCase() %>
                            </div>
                            <%= user.getName() %>
                        </div>
                    </td>
                    <td><%= user.getEmail() %></td>
                    <td><span class="balance-amount">$<%= acc.getBalance() %></span></td>
                    <td>
                                <span class="status-badge <%= isActive ? "status-active" : "status-inactive" %>">
                                    <%= status.getName() %>
                                </span>
                    </td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin/accounts" style="display: inline;">
                            <input type="hidden" name="accountId" value="<%= acc.getId() %>" />
                            <input type="hidden" name="newStatusId" value="<%= toggleStatusId %>" />
                            <button type="submit" class="action-btn <%= isActive ? "btn-deactivate" : "btn-activate" %>">
                                <i class="fas fa-<%= isActive ? "times" : "check" %>"></i>
                                <%= isActive ? "Deactivate" : "Activate" %>
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 2rem; color: #666;">
                        <i class="fas fa-info-circle" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                        No accounts found. Click "Refresh Accounts" to load data.
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // Add smooth loading animation
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card');
        cards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
        });
    });

    // Add form validation
    document.querySelector('form[action*="/register"]').addEventListener('submit', function(e) {
        const name = this.querySelector('input[name="name"]').value;
        const email = this.querySelector('input[name="email"]').value;
        const password = this.querySelector('input[name="password"]').value;

        if (!name || !email || !password) {
            e.preventDefault();
            alert('Please fill in all fields');
            return;
        }

        if (password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long');
            return;
        }
    });

    // Add loading state for buttons
    document.querySelectorAll('button[type="submit"]').forEach(button => {
        button.addEventListener('click', function() {
            this.classList.add('loading');
            setTimeout(() => {
                this.classList.remove('loading');
            }, 3000);
        });
    });
</script>
</body>
</html>