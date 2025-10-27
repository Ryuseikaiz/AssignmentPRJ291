package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/auth-register")
public class AuthRegisterServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("auth-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Please enter your full name");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
            return;
        }

        if (email == null || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            request.setAttribute("error", "Please enter a valid email address");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
            return;
        }

        if (phone == null || !phone.matches("^[0-9]{10,11}$")) {
            request.setAttribute("error", "Please enter a valid phone number (10-11 digits)");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
            return;
        }

        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (customerDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email already registered. Please use another email or login.");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
            return;
        }

        // Create new customer
        Customer newCustomer = new Customer();
        newCustomer.setName(fullName);
        newCustomer.setEmail(email);
        newCustomer.setPhone(phone);
        newCustomer.setPassword(password);

        boolean success = customerDAO.insert(newCustomer);

        if (success) {
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("auth-login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("auth-register.jsp").forward(request, response);
        }
    }
}
