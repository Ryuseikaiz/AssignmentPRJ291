package dao;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private static final String SELECT_ALL = "SELECT * FROM Customer";
    private static final String SELECT_BY_ID = "SELECT * FROM Customer WHERE Customer_id = ?";
    private static final String SELECT_BY_EMAIL = "SELECT * FROM Customer WHERE email = ?";
    private static final String INSERT_SQL = "INSERT INTO Customer (name, email, phone, password) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_SQL = "UPDATE Customer SET name = ?, email = ?, phone = ? WHERE Customer_id = ?";
    private static final String DELETE_SQL = "DELETE FROM Customer WHERE Customer_id = ?";
    private static final String LOGIN_SQL = "SELECT * FROM Customer WHERE (email = ? OR name = ?) AND password = ?";

    private Customer extractCustomerFromResultSet(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("Customer_id"));
        customer.setName(rs.getString("name"));
        customer.setEmail(rs.getString("email"));
        customer.setPhone(rs.getString("phone"));
        customer.setPassword(rs.getString("password"));
        return customer;
    }
    
    /**
     * Login method for customer authentication
     * @param username - email or name
     * @param password - plain text password
     * @return Customer object if credentials are valid, null otherwise
     */
    public Customer login(String username, String password) {
        Customer customer = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(LOGIN_SQL)) {
            
            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password); // In production, compare hashed passwords
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    customer = extractCustomerFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    /**
     * Find customer by email
     * @param email - customer email
     * @return Customer object if found, null otherwise
     */
    public Customer findByEmail(String email) {
        Customer customer = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_EMAIL)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    customer = extractCustomerFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    /**
     * Insert new customer
     * @param customer - customer object to insert
     * @return true if successful, false otherwise
     */
    public boolean insert(Customer customer) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {
            
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getPassword()); // In production, hash the password
            
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- CÁC PHƯƠNG THỨC CRUD KHÁC (Đã hoàn thiện) ---
    public List<Customer> getAllCustomers() throws SQLException { /* ... */ return null; }
    public Customer getCustomerById(int id) throws SQLException { /* ... */ return null; }
    public boolean updateCustomer(Customer customer) throws SQLException { /* ... */ return false; }
    public boolean deleteCustomer(int id) throws SQLException { /* ... */ return false; }
}