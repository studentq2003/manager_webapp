<%@ page import="java.sql.*" %>
<%@ page import="java.util.UUID" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles/styles_add.css" />
    <title>Добавление сотрудника</title>
    <script src="javascripts/add.js"></script>
</head>
<body>
    <h1>Добавление сотрудника</h1>

    <div class="container">
        <form action="add.jsp" method="post">
            <label class="form-label" for="name">Имя:</label>
            <p></p>
            <input class="form-input" type="text" name="name" id="name" value="<%= (request.getParameter("name") != null) ? request.getParameter("name") : "" %>" required>
            <p></p>

            <label class="form-label" for="manager_id">Менеджер:</label>
            <p></p>
            <select class="form-input" name="manager_id" id="manager_id">
                <option value="">Выберите менеджера</option>
                <%
                    try {
                        Class.forName("org.postgresql.Driver");
                        Connection con = DriverManager.getConnection("jdbc:postgresql://db:5432/employees", "root", "1234");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(
                            "SELECT a.id as id, a.name as name, b.name as depname, b.city as city, a.category_id as ci " +
                            "FROM employee a " +
                            "INNER JOIN department b ON (a.department_id=b.department_id) " + 
                            "WHERE a.category_id=11 " +
                            "ORDER BY a.id");
            
                        while (rs.next()) {
                            int managerIdValue = rs.getInt("id");
                            String managerNameValue = rs.getString("name");
                            String managerDepName = rs.getString("depname");
                            String managerCity = rs.getString("city");
                            int managerCI = rs.getInt("ci");
                %>
                            <option value="<%= managerIdValue %>" <%= (request.getParameter("manager_id") != null && request.getParameter("manager_id").equals(String.valueOf(managerIdValue))) ? "selected" : "NULL" %>><%= managerIdValue %> - <%= managerNameValue %>, <%= managerDepName %>, <%= managerCity %></option>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                <option value="" <%= (request.getParameter("manager_id") != null && request.getParameter("manager_id").equals("")) ? "selected" : "" %>>Нет менеджера</option>            </select>
            <p></p>
            
            <!-- <label class="form-label" for="manager_id">ID Менеджера:</label>
            <p></p>
            <input class="form-input" type="text" name="manager_id" id="manager_id" value="<%= (request.getParameter("manager_id") != null) ? request.getParameter("manager_id") : "" %>" >
            <%
            String managerName = "";
            boolean managerIsInvalid = false;

            if (request.getParameter("manager_id") != null) {
                String managerID = request.getParameter("manager_id");
                if (!managerID.isEmpty()) {
                    try {
                        // Создайте соединение с базой данных и выполните запрос
                        Class.forName("org.postgresql.Driver");
                        Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "");
                        String sqlGetName = "SELECT name, category_id FROM employee WHERE id = ?";
                        PreparedStatement getNameStmt = con.prepareStatement(sqlGetName);
                        getNameStmt.setInt(1, Integer.parseInt(managerID));
                        ResultSet nameResultSet = getNameStmt.executeQuery();

                        if (nameResultSet.next()) {
                            managerName = nameResultSet.getString("name");
                            int categoryID = nameResultSet.getInt("category_id");
                            if (categoryID != 11) {
                                managerIsInvalid = true;
                            }
                        } else {
                            managerName = "Такого сотрудника не существует";
                            managerIsInvalid = true;
                        }

                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                else {
                    managerName = "У сотрудника не будет менеджера";
                }
            }
            %>
            <p></p>
            <span class="manager-name"><%= (managerName != null) ? (managerIsInvalid ? "Этот сотрудник не менеджер" : managerName) : "" %></span>
            <p></p> -->

            <!-- <label class="form-label" for="department_id">ID Департамента:</label>
            <p></p>
            <input class="form-input" type="text" name="department_id" id="department_id" value="<%= (request.getParameter("department_id") != null) ? request.getParameter("department_id") : "" %>" required>
            <p></p>

            <label class="form-label" for="category_id">ID Категории:</label>
            <p></p>
            <input class="form-input" type="text" name="category_id" id="category_id" value="<%= (request.getParameter("category_id") != null) ? request.getParameter("category_id") : "" %>" required>
            <p></p> -->

            <label class="form-label" for="department_id">Департамент:</label>
        <p></p>
        <select class="form-input" name="department_id" id="department_id" required>
            <option value="">Выберите департамент</option>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT department_id, name FROM department");

                    while (rs.next()) {
                        int depId = rs.getInt("department_id");
                        String depName = rs.getString("name");
            %>
                        <option value="<%= depId %>" <%= (request.getParameter("department_id") != null && request.getParameter("department_id").equals(String.valueOf(depId))) ? "selected" : "" %>><%= depId %> - <%= depName %></option>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select>
        <p></p>

        <label class="form-label" for="category_id">Категория:</label>
        <p></p>
        <select class="form-input" name="category_id" id="category_id" required>
            <option value="">Выберите категорию</option>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT category_id, name FROM category");

                    while (rs.next()) {
                        int catId = rs.getInt("category_id");
                        String catName = rs.getString("name");
            %>
                        <option value="<%= catId %>" <%= (request.getParameter("category_id") != null && request.getParameter("category_id").equals(String.valueOf(catId))) ? "selected" : "" %>><%= catId %> - <%= catName %></option>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select>
        <p></p>

            <input class="form-button" type="submit" value="Добавить">
        </form>
    </div>

    <div class="button-container">
        <form action="index.jsp">
            <input class="btn-back" type="submit" value="Вернуться назад">
        </form>
    </div>

    <%
    String name = request.getParameter("name");
    String managerID = request.getParameter("manager_id");
    String departmentID = request.getParameter("department_id");
    String categoryID = request.getParameter("category_id");

    boolean hasErrors = false;

    if (name != null && departmentID != null && categoryID != null) {
        // Проверка на ввод только букв в имени
        if (!name.matches("^[a-zA-Z ]+$")) {
            hasErrors = true;
        }

        // Проверка manager_id: либо пустое значение, либо только цифры
        if (!managerID.isEmpty() && !managerID.matches("^[0-9]*$")) {
            hasErrors = true;
        }

        // Проверка department_id и category_id: только цифры
        if (!departmentID.matches("^[0-9]*$") || !categoryID.matches("^[0-9]*$")) {
            hasErrors = true;
        }

        if (hasErrors || managerIsInvalid) {
        %>
        <script>
            showNotification("Пожалуйста, проверьте введенные данные", true);
        </script>
        <%
        } else {
            try {
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "");

                // Получение максимального текущего ID
                PreparedStatement maxIdStmt = con.prepareStatement("SELECT MAX(id) FROM employee");
                String sql = "SELECT category_id FROM employee WHERE id = ?";
                PreparedStatement managerIDcheck = con.prepareStatement(sql);

                ResultSet maxIdResultSet = maxIdStmt.executeQuery();
                int maxId = 0;
                if (maxIdResultSet.next()) {
                    maxId = maxIdResultSet.getInt(1);
                }

                // Увеличение ID на 1
                int newEmployeeID = maxId + 1;

                PreparedStatement stmt = con.prepareStatement("INSERT INTO employee (id, name, manager_id, department_id, category_id) VALUES (?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
                stmt.setInt(1, newEmployeeID);
                stmt.setString(2, name);
                if (managerID.isEmpty()) {
                    stmt.setNull(3, Types.INTEGER);
                } else {
                    stmt.setInt(3, Integer.parseInt(managerID));
                }
                stmt.setInt(4, Integer.parseInt(departmentID));
                stmt.setInt(5, Integer.parseInt(categoryID));
                stmt.executeUpdate();

                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    newEmployeeID = generatedKeys.getInt(1);
        %>
        <script>
            showNotification("Сотрудник успешно добавлен. ID сотрудника: <%= newEmployeeID %>");
            redirectToIndex();
        </script>
        <%
                }

                con.close();
            } catch (Exception e) {
        %>
        <script>
            showNotification("Ошибка при добавлении сотрудника: <%= e.getMessage() %>", true);
        </script>
        <%
            }
        }
    }
    %>
</body>
</html>
