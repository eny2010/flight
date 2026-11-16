package com.flight.flight;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/FlightSearchServlet")
public class FlightSearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Capture Form Inputs
        String from = request.getParameter("departureCity");
        String to = request.getParameter("arrivalCity");
        String departDate = request.getParameter("departureDate");
        String returnDate = request.getParameter("returnDate");
        String tripType = request.getParameter("tripType");

        // Use helper to avoid crashes if numbers are empty
        int adults = Integer.parseInt(request.getParameter("adults") != null ? request.getParameter("adults") : "1");
        int infants = Integer.parseInt(request.getParameter("infants") != null ? request.getParameter("infants") : "0");

        boolean routeFound = false;
        double basePrice = 0.0;
        String flightNo = "";

        // 2. Database Lookup via XAMPP
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT base_price, flight_number FROM flights WHERE origin = ? AND destination = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, from);
            st.setString(2, to);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                basePrice = rs.getDouble("base_price");
                flightNo = rs.getString("flight_number");
                routeFound = true; // Match found!
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. Calculation Logic (Only relevant if routeFound is true)
        double totalSum = (adults * basePrice) + (infants * (basePrice * 0.10));
        if ("roundtrip".equalsIgnoreCase(tripType)) {
            totalSum *= 2;
        }

        // 4. Send ALL Data to result.jsp
        request.setAttribute("routeFound", routeFound);
        request.setAttribute("from", from);
        request.setAttribute("to", to);
        request.setAttribute("date", departDate);
        request.setAttribute("returnDate", returnDate);
        request.setAttribute("tripType", tripType);
        request.setAttribute("adults", adults);
        request.setAttribute("infants", infants);
        request.setAttribute("totalPrice", totalSum);
        request.setAttribute("flightNumber", flightNo);

        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}