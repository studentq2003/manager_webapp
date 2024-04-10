<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles//styles_index.css">
    <script src="javascripts/index.js"></script>


    <link rel="stylesheet" href="snow_settings/snowfall.css">
    <script src="snow_settings/snowfall.js"></script>

    <title>Сотрудники</title>
</head>

<body>
    <h1>Сотрудники</h1>

    <div class="btn-container">

        <form action="calculator/calculator.jsp">
            <button class="btn">Калькулятор</button>
        </form>

        <form action="searchid.jsp">
            <button class="btn">Искать по ID</button>
        </form>
    
        <form action="ajax_searchname.jsp">
            <button class="btn">Искать по имени</button>
        </form>

        <form action="searchmanager.jsp">
            <button class="btn">Искать по менеджеру</button>
        </form>
    
        <form action="add.jsp">
            <button class="btn">Добавить сотрудника</button>
        </form>
    
        <form action="delete.jsp">
            <button class="btn">Удалить сотрудника</button>
        </form>
    </div>
    
    <div class="table-container">
        <table>
            <tr>
                <th>ID</th>
                <th>Имя</th>
                <th>Менеджер</th>
                <th>Дата трудоустройства</th>
                <th>Департамент</th>
                <th>Город</th>
                <th>Адрес</th>
                <th>Почта</th>
                <th>Должность</th>
                <th>Зарплата</th>
            </tr>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection con = DriverManager.getConnection("jdbc:postgresql://db:5432/employees", "root", "1234");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT a.id, a.name AS employee_name, a.surname AS employee_surname, a.date_of_employment, " +
                        "b.name AS manager_name, " +
                        "c.name AS department_name, c.city, d.title AS category_name, " +
                        "d.salary, c.address AS adress, " +
                        "c.mail AS mail " +
                        "FROM employee a " +
                        "LEFT OUTER JOIN employee b ON (a.manager_id=b.id) " +
                        "INNER JOIN department c ON (a.department_id=c.department_id) " +
                        "INNER JOIN category d ON (a.category_id=d.category_id);"
                        );
                    while (rs.next()) {
                        String managerName = rs.getString("manager_name");
                        String managerClass = (managerName == null) ? "null-manager" : "";
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("employee_name") %></td>
                    <td class="<%= managerClass %>"><%= (managerName == null) ? "Сам себе менеджер" : managerName %></td>
                    <td><%= rs.getString("date_of_employment") %></td>
                    <td><%= rs.getString("department_name") %></td>
                    <td><%= rs.getString("city") %></td>
                    <td><%= rs.getString("adress") %></td>
                    <td><%= rs.getString("mail") %></td>
                    <td><%= rs.getString("category_name") %></td>
                    <td><%= rs.getString("salary") %></td>
                </tr>
                <script>showLoadingNotification()</script>
            <%
                    }
                    con.close();
                } catch (Exception e) {
            %>
                <script>
                    function showErrorNotification(error) {
                        var notification = document.createElement("div");
                        notification.className = "notification error-notification";
                        notification.innerText = "Ошибка: " + error;
                        document.body.appendChild(notification);
                        setTimeout(function () {
                            notification.style.top = "0";
                        }, 10);
                    }
                    showErrorNotification("<%= e.getMessage() %>");
                </script>
            <%
                }
            %>
        </table>
    </div>
    <p>

    </p>

</body>
</html>
