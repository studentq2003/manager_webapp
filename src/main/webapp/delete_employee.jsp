<%@page import="java.sql.*" %>
<%
String employeeId = request.getParameter("employee_id");

boolean success = false;

if (employeeId != null) {
    try {
        Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection("jdbc:postgresql://db:5432/employees", "root", "1234");

        PreparedStatement stmt = con.prepareStatement(
            "DELETE FROM employee WHERE id = ?"
            );
        stmt.setInt(1, Integer.parseInt(employeeId));

        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            success = true;
        }
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write("{\"success\": " + success + "}");
%>
