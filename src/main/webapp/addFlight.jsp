<%
    // 1. SESSION GUARD: This must be the very first thing in the file.
    // It checks if 'adminUser' exists in the session to prevent unauthorized access.
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return; // Stops the rest of the page from loading
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin | Add New Flight</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px;
            margin: 0;
        }
        .admin-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 400px;
        }
        h2 { color: #2c3e50; margin-top: 0; text-align: center; }
        .welcome-msg { font-size: 14px; color: #7f8c8d; margin-bottom: 20px; text-align: center; }

        input, select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #2c3e50;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
            transition: 0.3s;
        }
        button:hover { background: #34495e; }

        .nav-links {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            width: 100%;
        }
        .nav-links a {
            text-decoration: none;
            font-size: 14px;
            color: #3498db;
        }
        .logout-btn { color: #e74c3c !important; font-weight: bold; }
    </style>
</head>
<body>

<div class="admin-card">
    <h2>Add New Flight Route</h2>
    <p class="welcome-msg">Logged in as: <strong><%= session.getAttribute("adminUser") %></strong></p>

    <form action="AddFlightServlet" method="post">
        <input type="text" name="origin" placeholder="Departure City (e.g. Dar es Salaam)" required>
        <input type="text" name="destination" placeholder="Arrival City (e.g. Dodoma)" required>

        <input type="number" name="price" placeholder="Base Price (USD)" required step="0.01">

        <input type="text" name="flightNo" placeholder="Flight Number (e.g. IA404)" required>

        <button type="submit">SAVE ROUTE TO DATABASE</button>
    </form>

    <div class="nav-links">
        <a href="index.jsp"><i class="fas fa-arrow-left"></i> Passenger Search</a>
        <a href="LogoutServlet" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</div>

</body>
</html>