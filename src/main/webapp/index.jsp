<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.flight.flight.DBConnection, java.util.ArrayList, java.util.List" %>
<%
    // Fetch unique cities from the database for the dropdowns
    List<String> cities = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT origin FROM flights UNION SELECT destination FROM flights";
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            cities.add(rs.getString(1));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IreneAirways | Cheap Flights Search</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #f39c12;
            --text-color: #333;
            --light-bg: #f5f5f5;
            --white: #ffffff;
            --shadow: 0 10px 30px rgba(0,0,0,0.08);
            --transition: 0.3s ease;
            --blue-btn: #1a5fb4;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: var(--light-bg);
            color: var(--text-color);
        }

        /* --- HEADER --- */
        header {
            background-color: var(--primary-color);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--white);
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: var(--white);
        }

        .logo i { color: var(--accent-color); margin-right: 10px; }

        .header-right { display: flex; align-items: center; gap: 25px; }

        .admin-link {
            color: var(--white);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: var(--transition);
        }

        .admin-link:hover { color: var(--accent-color); }

        .lang-selector { display: flex; align-items: center; font-size: 14px; cursor: pointer; }
        .lang-selector img { width: 20px; height: auto; margin-right: 5px; }

        /* --- HERO & SEARCH --- */
        .hero {
            background-color: var(--primary-color);
            padding: 100px 40px 180px;
            text-align: center;
        }

        .hero-title { color: var(--white); font-size: 42px; font-weight: 700; margin: 0; }

        .search-container {
            max-width: 1000px;
            margin: -130px auto 0;
            background-color: var(--white);
            padding: 40px;
            border-radius: 10px;
            box-shadow: var(--shadow);
            position: relative;
            z-index: 10;
        }

        .controls {
            display: flex;
            justify-content: start;
            gap: 20px;
            margin-bottom: 25px;
            font-weight: 500;
            color: #555;
        }

        .controls label { cursor: pointer; display: flex; align-items: center; }
        .controls input[type="radio"] { accent-color: var(--primary-color); margin-right: 8px; }

        .class-selector {
            background: none; border: none; color: var(--primary-color);
            font-weight: bold; cursor: pointer; font-size: 16px;
        }

        .search-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr) repeat(3, 140px) auto;
            gap: 15px;
            align-items: end;
        }

        .input-group { position: relative; }
        .input-group i {
            position: absolute; left: 15px; top: 50%;
            transform: translateY(-50%); color: #888; z-index: 5;
        }

        .input-group input, .input-group select {
            width: 100%; padding: 15px 15px 15px 45px;
            border: 1px solid #ddd; border-radius: 5px;
            font-size: 16px; transition: var(--transition);
            box-sizing: border-box; background-color: var(--white);
            appearance: none;
        }

        .input-group input:focus, .input-group select:focus {
            border-color: var(--primary-color); outline: none;
            box-shadow: 0 0 5px rgba(44, 62, 80, 0.1);
        }

        /* --- TRAVELER DROPDOWN --- */
        .traveler-wrapper { position: relative; }
        .dropdown-card {
            position: absolute; top: 110%; right: 0; width: 280px;
            background: white; border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            padding: 20px; display: none; z-index: 1000;
        }
        .dropdown-card.active { display: block; }

        .row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .row-label { font-weight: bold; color: black; font-size: 15px; }

        .counter { display: flex; align-items: center; gap: 12px; }
        .count-btn {
            width: 30px; height: 30px; border-radius: 4px; border: none;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px; cursor: pointer;
        }
        .minus { background: #eef1f4; color: #7f8c8d; }
        .plus { background: var(--blue-btn); color: white; }

        .done-btn {
            width: 100%; padding: 10px; background: white;
            border: 1px solid var(--blue-btn); color: var(--blue-btn);
            border-radius: 4px; font-weight: bold; cursor: pointer;
        }

        .search-btn {
            background-color: var(--accent-color); color: #000;
            border: none; padding: 15px 30px; border-radius: 5px;
            font-size: 18px; font-weight: bold; cursor: pointer;
            transition: var(--transition); width: 100%;
        }

        .search-btn:hover { background-color: #e67e22; }

        /* --- POPULAR SECTION --- */
        .popular { max-width: 1000px; margin: 60px auto; padding: 0 20px; }
        .popular-title { font-size: 28px; color: #2c3e50; margin-bottom: 30px; }
        .destination-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 30px; }
        .destination-card {
            background: var(--white); border-radius: 10px; overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05); transition: var(--transition); cursor: pointer;
        }
        .destination-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .destination-card img { width: 100%; height: 200px; object-fit: cover; }
        .destination-content { padding: 20px; }
        .destination-name { font-size: 18px; font-weight: bold; color: var(--text-color); margin: 0; }

        @media (max-width: 900px) {
            .search-grid { grid-template-columns: 1fr; }
            .search-container { margin: -100px 10px 0; padding: 20px; }
        }
    </style>
</head>
<body>

<header>
    <a href="index.jsp" class="logo"><i class="fas fa-plane"></i> IreneAirways</a>
    <div class="header-right">
        <a href="addFlight.jsp" class="admin-link"><i class="fas fa-user-shield"></i> Admin Panel</a>
        <div class="lang-selector">
            <img src="america.jpg" alt="US Flag">
            EN <i class="fas fa-caret-down" style="margin-left: 5px;"></i>
        </div>
    </div>
</header>

<section class="hero">
    <h1 class="hero-title">Millions of cheap flights with just one search!</h1>
</section>

<section class="search-container">
    <form id="searchForm" action="FlightSearchServlet" method="POST">
        <div class="controls">
            <label><input type="radio" name="tripType" value="roundtrip" checked id="rtRadio"> Round Trip</label>
            <label><input type="radio" name="tripType" value="oneway" id="owRadio"> One Way</label>
            <select name="flightClass" class="class-selector">
                <option value="economy">Economy</option>
                <option value="business">Business</option>
                <option value="first">First</option>
            </select>
        </div>

        <div class="search-grid">
            <div class="input-group">
                <i class="fas fa-map-marker-alt"></i>
                <select name="departureCity" required>
                    <option value="" disabled selected>From</option>
                    <% for(String city : cities) { %>
                    <option value="<%= city %>"><%= city %></option>
                    <% } %>
                </select>
            </div>

            <div class="input-group">
                <i class="fas fa-search"></i>
                <select name="arrivalCity" required>
                    <option value="" disabled selected>Destination</option>
                    <% for(String city : cities) { %>
                    <option value="<%= city %>"><%= city %></option>
                    <% } %>
                </select>
            </div>

            <div class="input-group">
                <i class="far fa-calendar-alt"></i>
                <input type="date" id="departureDate" name="departureDate" required>
            </div>

            <div class="input-group" id="returnGroup">
                <i class="far fa-calendar-alt"></i>
                <input type="date" id="returnDate" name="returnDate">
            </div>

            <div class="traveler-wrapper" id="travelerWrapper">
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" id="travelerDisplay" value="1 Traveler" readonly style="cursor: pointer;">
                    <input type="hidden" name="adults" id="h-adults" value="1">
                    <input type="hidden" name="infants" id="h-infants" value="0">
                </div>
                <div class="dropdown-card" id="dropCard">
                    <div class="row">
                        <div class="row-label">Adult</div>
                        <div class="counter">
                            <button type="button" class="count-btn minus" onclick="changeCount('adults', -1)">-</button>
                            <span id="v-adults">1</span>
                            <button type="button" class="count-btn plus" onclick="changeCount('adults', 1)">+</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-label">Infant</div>
                        <div class="counter">
                            <button type="button" class="count-btn minus" onclick="changeCount('infants', -1)">-</button>
                            <span id="v-infants">0</span>
                            <button type="button" class="count-btn plus" onclick="changeCount('infants', 1)">+</button>
                        </div>
                    </div>
                    <button type="button" class="done-btn" onclick="toggleDropdown()">Done</button>
                </div>
            </div>

            <button type="submit" class="search-btn">Search Flights</button>
        </div>
    </form>
</section>

<section class="popular">
    <h2 class="popular-title">Popular right now</h2>
    <div class="destination-grid">
        <div class="destination-card">
            <img src="images/cairo.jpg" alt="Cairo" onerror="this.src='https://placehold.co/600x400?text=Cairo'">
            <div class="destination-content"><p class="destination-name">Cairo</p></div>
        </div>
        <div class="destination-card">
            <img src="images/zanzibar.jpg" alt="zanziba" onerror="this.src='https://placehold.co/600x400?text=Zanzibar'">
            <div class="destination-content"><p class="destination-name">Zanzibar</p></div>
        </div>
        <div class="destination-card">
            <img src="images/kampala.jpg" alt="kampala" onerror="this.src='https://placehold.co/600x400?text=Kampala'">
            <div class="destination-content"><p class="destination-name">kampala</p></div>
        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const departureDateInput = document.getElementById('departureDate');
        const returnDateInput = document.getElementById('returnDate');
        const returnGroup = document.getElementById('returnGroup');

        const today = new Date().toISOString().split('T')[0];
        departureDateInput.min = today;
        departureDateInput.value = today;

        function toggleTripType(type) {
            if (type === 'oneway') {
                returnGroup.style.display = 'none';
                returnDateInput.removeAttribute('required');
            } else {
                returnGroup.style.display = 'block';
                returnDateInput.setAttribute('required', '');
            }
        }

        document.getElementById('rtRadio').addEventListener('change', () => toggleTripType('roundtrip'));
        document.getElementById('owRadio').addEventListener('change', () => toggleTripType('oneway'));

        let counts = { adults: 1, infants: 0 };
        const dropCard = document.getElementById('dropCard');
        const travelerDisplay = document.getElementById('travelerDisplay');

        window.toggleDropdown = () => dropCard.classList.toggle('active');
        travelerDisplay.onclick = toggleDropdown;

        window.changeCount = function(type, amt) {
            let next = counts[type] + amt;
            if (type === 'adults' && next < 1) return;
            if (type === 'infants' && next < 0) return;
            counts[type] = next;
            document.getElementById('v-' + type).innerText = next;
            document.getElementById('h-' + type).value = next;
            let total = counts.adults + counts.infants;
            travelerDisplay.value = total + (total === 1 ? " Traveler" : " Travelers");
        }
    });
</script>
</body>
</html>