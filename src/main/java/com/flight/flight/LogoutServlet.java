package com.flight.flight;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * This Servlet handles the logout process for IreneAirways.
 * It clears the session and redirects to the login page.
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Find the current session, but don't create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        if (session != null) {
            // 2. Clear all data (removes the 'adminUser' marker)
            session.invalidate();
            System.out.println("Admin session invalidated successfully.");
        }

        // 3. Redirect the user back to the login page
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST requests to the GET logic above
        doGet(request, response);
    }
}