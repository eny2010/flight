<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Summary | Irene Airways</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* FIX: Defining CSS variables to stop "Cannot resolve" errors */
        :root {
            --primary: #2c3e50;
            --gold: #f1c40f;
            --accent: #27ae60;
            --success: #27ae60;
            --light-bg: #f8f9fa;
            --danger: #e74c3c;
        }

        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f4f7f6; margin: 0; padding: 40px; }
        .receipt-card { max-width: 600px; margin: auto; background: white; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; }
        .banner { background: var(--primary); color: white; padding: 30px; text-align: center; }
        .banner h1 { margin: 0; font-size: 24px; text-transform: uppercase; letter-spacing: 2px; }
        .content { padding: 30px; }
        .route-header { display: flex; justify-content: space-around; align-items: center; margin-bottom: 30px; font-size: 22px; font-weight: bold; color: var(--primary); }
        .details-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .info-box { border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .label { font-size: 11px; color: #95a5a6; text-transform: uppercase; display: block; }
        .value { font-size: 15px; color: #2c3e50; font-weight: 600; text-transform: capitalize; }
        .total-section { background: #fdfaf0; padding: 20px; border-radius: 10px; border: 1px dashed var(--gold); text-align: center; }
        .grand-total { font-size: 36px; color: var(--primary); font-weight: 800; display: block; }
        .btn-home { display: block; text-align: center; background: var(--primary); color: white; text-decoration: none; padding: 15px; margin-top: 20px; border-radius: 10px; font-weight: bold; border: none; width: 100%; transition: 0.3s; }
        .btn-home:hover { opacity: 0.9; }

        @media print {
            .btn-home, .fas.fa-exclamation-triangle { display: none; }
            body { padding: 0; }
            .receipt-card { box-shadow: none; border: 1px solid #eee; }
        }
    </style>
</head>
<body>

<div class="receipt-card">
    <div class="banner">
        <h1>Irene Airways</h1>
        <small><i class="fas fa-check-circle"></i> Flight Search Result</small>
    </div>

    <div class="content">
        <c:choose>
            <%-- CASE 1: Flight Route found in Database --%>
            <c:when test="${routeFound}">
                <div class="route-header">
                    <span>${from}</span>
                    <i class="fas fa-plane" style="color: var(--gold);"></i>
                    <span>${to}</span>
                </div>

                <div class="details-grid">
                    <div class="info-box">
                        <span class="label">Flight Number</span>
                        <span class="value" style="color: var(--accent);">${flightNumber}</span>
                    </div>
                    <div class="info-box">
                        <span class="label">Trip Type</span>
                        <span class="value">${tripType}</span>
                    </div>
                    <div class="info-box">
                        <span class="label">Travelers</span>
                        <span class="value">${adults} Adult(s), ${infants} Infant(s)</span>
                    </div>
                    <div class="info-box">
                        <span class="label">Departure Date</span>
                        <span class="value">${date}</span>
                    </div>

                    <c:if test="${tripType == 'roundtrip'}">
                        <div class="info-box">
                            <span class="label">Return Date</span>
                            <span class="value">${returnDate}</span>
                        </div>
                    </c:if>
                </div>

                <div class="total-section">
                    <span class="label">Total Amount</span>
                    <span class="grand-total">
                        <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="$" />
                    </span>
                </div>

                <button onclick="window.print()" class="btn-home" style="background: var(--success); cursor: pointer; margin-bottom: 10px;">
                    <i class="fas fa-print"></i> PRINT RECEIPT
                </button>
            </c:when>

            <%-- CASE 2: No matching flight in XAMPP --%>
            <c:otherwise>
                <div style="text-align: center; padding: 20px;">
                    <i class="fas fa-exclamation-triangle" style="font-size: 48px; color: var(--danger); margin-bottom: 15px;"></i>
                    <h2 style="color: var(--primary);">Route Not Found</h2>
                    <p style="color: #666;">We currently don't have flights from <strong>${from}</strong> to <strong>${to}</strong>.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <a href="index.jsp" class="btn-home">BACK TO SEARCH</a>
    </div>
</div>

</body>
</html>