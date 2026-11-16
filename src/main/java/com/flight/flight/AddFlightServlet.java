package com.flight.flight;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/AddFlightServlet")
public class AddFlightServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String origin = request.getParameter("origin");
        String dest = request.getParameter("destination");
        double price = Double.parseDouble(request.getParameter("price"));
        String flightNo = request.getParameter("flightNo");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO flights (origin, destination, base_price, flight_number) VALUES (?, ?, ?, ?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, origin);
            st.setString(2, dest);
            st.setDouble(3, price);
            st.setString(4, flightNo);

            int result = st.executeUpdate();
            if (result > 0) {
                // Redirect back to the search page or show success
                response.sendRedirect("index.jsp?msg=FlightAdded");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}