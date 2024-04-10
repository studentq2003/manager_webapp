<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles/searchname.css">
    <title>Поиск по имени</title>

<script>
    function searchByName() {
        var name = document.getElementById("nameInput").value;
        var searchForm = document.getElementById("searchForm");

        if (name.trim() === "") {
            // Если в имени есть цифры, показываем предупреждение
            document.getElementById("warning-container").style.display = "flex";
            return;
        }

        // Проверка на наличие цифр в имени
        if (/\d/.test(name)) {
            // Если в имени есть цифры, показываем предупреждение
            document.getElementById("warning-container").style.display = "flex";
            return;
        }

        // Если в имени нет цифр и поле не пустое, отправляем форму на сервер
        searchForm.submit();
    }
</script>

</head>
<body>

    <div id="results-container">
        <table id="results-table">
            <!-- <tr>
                <th>ID</th>
                <th>Имя</th>
                <th>Менеджер</th>
                <th>Департамент</th>
                <th>Город</th>
                <th>Должность</th>
                <th>Зарплата</th>
            </tr> -->
            <%
                String searchName = request.getParameter("searchName");
                if (searchName != null && !searchName.matches(".*\\d.*")) {
                    try {
                        Class.forName("org.postgresql.Driver");
                        Connection con = DriverManager.getConnection("jdbc:postgresql://db:5432/employees", "root", "1234");
                        PreparedStatement stmt = con.prepareStatement(
                                "SELECT a.id, a.name AS employee_name, " +
                                "b.name AS manager_name, " +
                                "c.name AS department_name, c.city, " + 
                                "d.title AS category_name, d.salary " +
                                "FROM employee a LEFT OUTER JOIN employee b ON (a.manager_id=b.id) " + 
                                "INNER JOIN department c ON (a.department_id=c.department_id) " +
                                "INNER JOIN category d ON (a.category_id=d.category_id) " +
                                "WHERE a.name LIKE ?"
                            );
                        stmt.setString(1, searchName + "%");
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
            %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("employee_name") %></td>
                                <td><%= rs.getString("manager_name") %></td>
                                <td><%= rs.getString("department_name") %></td>
                                <td><%= rs.getString("city") %></td>
                                <td><%= rs.getString("category_name") %></td>
                                <td><%= rs.getString("salary") %></td>
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
                    }
                }
            %>
        </table>
    </div>

    <div id="warning-container">
        <div id="warning-box">
            <p>Поле не может быть пустым или содержать цифры.</p>
            <button id="close-warning" onclick="document.getElementById('warning-container').style.display = 'none'">Закрыть</button>
        </div>
    </div>

    <!-- <div class="button-container">
        <form action="index.jsp">
            <input class="btn-back" type="submit" value="Вернуться назад">
        </form>
    </div> -->

</body>
</html>
