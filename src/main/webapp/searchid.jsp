<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles/searchid.css">
    <script src="javascripts/searchid.js"></script>
    <style>
        .notification {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #ff0000;
            color: #ffffff;
            padding: 10px;
            text-align: center;
            z-index: 1000;
            animation: slide-down 0.5s ease;
        }

        @keyframes slide-down {
            from {
                transform: translateY(-100%);
            }
            to {
                transform: translateY(0);
            }
        }

        .notification.show {
            display: block;
        }

        .notification-success {
            background-color: #00ff00;
        }
    </style>

    <title>Поиск по ID</title>
</head>
<body>
    <h1>Поиск по ID</h1>
    
    <div id="search-container">
        <form action="searchid.jsp" method="post">
            <label>Введите ID: <input type="text" name="searchID" id="searchID"></label>
            <input class="btn" type="submit" value="Поиск">
        </form>
    </div>

    <div id="results-container">
        <table id="results-table">
            <tr>
                <th>ID</th>
                <th>Имя</th>
                <th>Менеджер</th>
                <th>Департамент</th>
                <th>Город</th>
                <th>Должность</th>
                <th>Зарплата</th>
            </tr>
            <%
                String searchID = request.getParameter("searchID");
                if (searchID != null && searchID.matches("\\d+")) {
                    try {
                        Class.forName("org.postgresql.Driver");
                        Connection con = DriverManager.getConnection("jdbc:postgresql://db:5432/employees", "root", "1234");
                        PreparedStatement stmt = con.prepareStatement("SELECT a.id, a.name AS employee_name, b.id AS manager_id, b.name AS manager_name, c.name AS department_name, c.city, d.title AS category_name, d.salary FROM employee a LEFT OUTER JOIN employee b ON (a.manager_id=b.id) INNER JOIN department c ON (a.department_id=c.department_id) INNER JOIN category d ON (a.category_id=d.category_id) WHERE a.id = ?");
                        stmt.setInt(1, Integer.parseInt(searchID));
                        ResultSet rs = stmt.executeQuery();

                        if (rs.next()) {
            %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("employee_name") %></td>
                                <td>
                                    <!-- <a href="javascript:void(0);" onclick="getManagerInfo(<%= rs.getInt("manager_id") %>);"> -->
                                        <%= rs.getString("manager_name") %>
                                    <!-- </a> -->
                                </td>
                                <td><%= rs.getString("department_name") %></td>
                                <td><%= rs.getString("city") %></td>
                                <td><%= rs.getString("category_name") %></td>
                                <td><%= rs.getString("salary") %></td>
                            </tr>

                            <!-- Вторая строка с информацией о менеджере -->
                            <%
                                int managerId = rs.getInt("manager_id");
                                PreparedStatement managerStmt = con.prepareStatement("SELECT a.id, a.name, b.name as department_name, b.city, c.title as category_name, c.salary FROM employee a INNER JOIN department b ON (a.department_id=b.department_id) INNER JOIN category c ON (a.category_id=c.category_id) WHERE id = ?");
                                managerStmt.setInt(1, managerId);
                                ResultSet managerRs = managerStmt.executeQuery();

                                if (managerRs.next()) {
                            %>
                                <tr>
                                    <td><%= managerRs.getInt("id") %></td>
                                    <td><%= managerRs.getString("name") %></td>
                                    <td>
                                        <!-- <%= managerRs.getString("name") %> -->
                                    </td>
                                    <td><%= managerRs.getString("department_name") %></td>
                                    <td><%= managerRs.getString("city") %></td>
                                    <td><%= managerRs.getString("category_name") %></td>
                                    <td><%= managerRs.getString("salary") %></td>
                                </tr>
                            <%
                                }
                            %>
                            <!-- Конец второй строки -->
            <%
                        } else {
            %>
                            <tr>
                                <td colspan="7">Такого сотрудника нет.</td>
                            </tr>
            <%
                        }
                        con.close();
                    } catch (Exception e) {
            %>
                        <tr>
                            <td colspan="7">Ошибка: <%= e.getMessage() %></td>
                        </tr>
            <%
                        %>
                        <script>
                            showNotification("Ошибка: <%= e.getMessage() %>", true);
                        </script>
                        <%
                    }
                } else if (searchID != null) {
            %>
                    <!-- <tr>
                        <td colspan="7">Пожалуйста, введите правильный ID.</td>
                    </tr> -->
            <%
                    %>
                    <script>
                        showNotification("Пожалуйста, введите правильный ID.", true);
                    </script>
            <%
                }
            %>
        </table>
    </div>
    <div class="button-container">
        <form action="index.jsp">
            <input class="btn-back" type="submit" value="Вернуться назад">
        </form>
    </div>
</body>
</html>
