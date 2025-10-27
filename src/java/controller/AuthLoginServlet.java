package controller;

import dao.EmployeeDAO;
import dao.CustomerDAO;
import model.Employee;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth-login")
public class AuthLoginServlet extends HttpServlet {

    private EmployeeDAO employeeDAO = new EmployeeDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("auth-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        // Try employee login first
        Employee employee = employeeDAO.login(username, password);
        if (employee != null) {
            HttpSession session = request.getSession();
            session.setAttribute("employee", employee);
            session.setAttribute("userType", "employee");
            session.setAttribute("userId", employee.getEmployeeId());
            
            // Set session timeout (30 minutes default, or longer if remember me is checked)
            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(30 * 24 * 60 * 60); // 30 days
            } else {
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
            }
            
            response.sendRedirect("admin-dashboard.jsp");
            return;
        }

        // Try customer login
        Customer customer = customerDAO.login(username, password);
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            session.setAttribute("userType", "customer");
            session.setAttribute("userId", customer.getCustomerId());
            
            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(30 * 24 * 60 * 60); // 30 days
            } else {
                session.setMaxInactiveInterval(30 * 60); // 30 minutes
            }
            
            response.sendRedirect("customer-view-products.jsp");
            return;
        }

        // Login failed
        request.setAttribute("error", "Invalid username or password. Please try again.");
        request.getRequestDispatcher("auth-login.jsp").forward(request, response);
    }
}
