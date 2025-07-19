<%@ page import="com.graynode.ee.core.entity.Transaction" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banking Dashboard | ${pageContext.request.userPrincipal.name}</title>
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
            overflow-x: hidden;
        }

        .background-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .background-animation::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
            radial-gradient(circle at 40% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: floating 6s ease-in-out infinite;
        }

        @keyframes floating {
            0%, 100% { transform: translate(0, 0px); }
            50% { transform: translate(0, -10px); }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            position: relative;
            z-index: 1;
        }

        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .welcome-text {
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            text-align: center;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        .subtitle {
            text-align: center;
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            font-weight: 400;
        }

        .balance-section {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(25px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .balance-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #48bb78, #38a169);
        }

        .balance-label {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .balance-amount {
            font-size: 3.5rem;
            font-weight: 800;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            margin-bottom: 10px;
            background: linear-gradient(135deg, #48bb78, #38a169);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .balance-refresh {
            margin-top: 20px;
        }

        .btn-refresh {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 12px 24px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .btn-refresh:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 30px;
            margin-bottom: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .card-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #4a5568;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
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

        .btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 10px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #4299e1, #3182ce);
        }

        .btn-logout {
            background: linear-gradient(135deg, #f56565, #e53e3e);
        }

        .message {
            background: linear-gradient(135deg, #48bb78, #38a169);
            color: white;
            padding: 16px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-weight: 500;
            box-shadow: 0 5px 15px rgba(72, 187, 120, 0.3);
        }

        .transactions-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .transactions-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 16px;
            text-align: left;
            font-weight: 600;
        }

        .transactions-table td {
            padding: 16px;
            border-bottom: 1px solid #e2e8f0;
        }

        .transactions-table tr:hover {
            background: #f7fafc;
        }

        .amount {
            font-weight: 600;
            color: #48bb78;
        }

        .logout-section {
            text-align: center;
            margin-top: 30px;
        }

        .no-transactions {
            text-align: center;
            color: #718096;
            font-style: italic;
            padding: 40px;
        }

        @media (max-width: 768px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 10px;
            }

            .welcome-text {
                font-size: 2rem;
            }

            .balance-amount {
                font-size: 2.5rem;
            }

            .card {
                padding: 20px;
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

        .gradient-text {
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .balance-loading {
            color: rgba(255, 255, 255, 0.7);
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="background-animation"></div>

<div class="container">
    <div class="header">
        <h1 class="welcome-text">Welcome back, <span class="gradient-text">${pageContext.request.userPrincipal.name}</span></h1>
        <p class="subtitle">Manage your finances with ease and security</p>
    </div>

    <!-- Account Balance Section -->
    <div class="balance-section">
        <div class="balance-label">Current Balance</div>
        <div class="balance-amount">
            <%
                com.graynode.ee.core.entity.Account account = (com.graynode.ee.core.entity.Account) request.getSession().getAttribute("account");
                if (account != null && account.getBalance() != null) {
            %>
            $<%= String.format("%.2f", account.getBalance()) %>
            <%
            } else {
            %>
            <span class="balance-loading">Balance unavailable</span>
            <%
                }
            %>
        </div>
        <div class="balance-refresh">
            <form method="get" action="${pageContext.request.contextPath}/user/refresh-balance" style="display: inline;">
                <button type="submit" class="btn-refresh">🔄 Refresh Balance</button>
            </form>
        </div>
    </div>

    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
    <div class="message">
        <%= message %>
    </div>
    <%
        }
    %>

    <div class="grid">
        <div class="card">
            <h2 class="card-title">
                <span class="card-icon">💸</span>
                Transfer Money
            </h2>
            <form method="POST" action="${pageContext.request.contextPath}/transfer">
                <div class="form-group">
                    <label class="form-label">Source Account ID</label>
                    <input type="text" name="sourceAccountId" class="form-input" required placeholder="Enter source account ID">
                </div>
                <div class="form-group">
                    <label class="form-label">Destination Account ID</label>
                    <input type="text" name="destinationAccountId" class="form-input" required placeholder="Enter destination account ID">
                </div>
                <div class="form-group">
                    <label class="form-label">Amount</label>
                    <input type="number" step="0.01" name="amount" class="form-input" required placeholder="0.00">
                </div>
                <button type="submit" class="btn">Transfer Now</button>
            </form>
        </div>

        <div class="card">
            <h2 class="card-title">
                <span class="card-icon">⏰</span>
                Schedule Transfer
            </h2>
            <form method="POST" action="${pageContext.request.contextPath}/schedule-transfer">
                <div class="form-group">
                    <label class="form-label">Source Account ID</label>
                    <input type="number" name="scheduleSourceAccountId" class="form-input" required placeholder="Enter source account ID">
                </div>
                <div class="form-group">
                    <label class="form-label">Destination Account ID</label>
                    <input type="number" name="scheduleDestinationAccountId" class="form-input" required placeholder="Enter destination account ID">
                </div>
                <div class="form-group">
                    <label class="form-label">Amount</label>
                    <input type="number" name="scheduleAmount" step="0.01" min="0.01" class="form-input" required placeholder="0.00">
                </div>
                <div class="form-group">
                    <label class="form-label">Scheduled Time</label>
                    <input type="datetime-local" name="scheduledTime" class="form-input" required>
                </div>
                <button type="submit" class="btn">Schedule Transfer</button>
            </form>
        </div>
    </div>

    <div class="card">
        <h2 class="card-title">
            <span class="card-icon">📊</span>
            Transaction History
        </h2>
        <form method="get" action="${pageContext.request.contextPath}/user/transactions">
            <button type="submit" class="btn btn-secondary">Load My Transactions</button>
        </form>

        <%
            List<com.graynode.ee.core.entity.Transaction> transactions = (List<com.graynode.ee.core.entity.Transaction>) request.getAttribute("transactions");
        %>

        <% if (transactions != null && !transactions.isEmpty()) { %>
        <div style="margin-top: 20px;">
            <table class="transactions-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>From Account</th>
                    <th>To Account</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <% for (com.graynode.ee.core.entity.Transaction txn : transactions) { %>
                <tr>
                    <td><%= txn.getId() %></td>
                    <td><%= txn.getSourceAccount() != null ? txn.getSourceAccount().getId() : "-" %></td>
                    <td><%= txn.getDestinationAccount() != null ? txn.getDestinationAccount().getId() : "-" %></td>
                    <td><%= txn.getType() %></td>
                    <td class="amount">$<%= txn.getAmount() %></td>
                    <td><%= txn.getTimestamp() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } else if (transactions != null) { %>
        <div class="no-transactions">
            <p>No transactions found. Start by making your first transfer!</p>
        </div>
        <% } %>
    </div>

    <div class="logout-section">
        <form method="POST" action="${pageContext.request.contextPath}/logout">
            <button type="submit" class="btn btn-logout">Logout</button>
        </form>
    </div>
</div>

<script>
    // Add subtle animations on load
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card, .balance-section');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';

            setTimeout(() => {
                card.style.transition = 'all 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 200);
        });
    });

    // Add form validation feedback
    const inputs = document.querySelectorAll('.form-input');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.value && this.checkValidity()) {
                this.style.borderColor = '#48bb78';
            } else if (!this.checkValidity()) {
                this.style.borderColor = '#f56565';
            }
        });
    });
</script>
</body>
</html>