<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles/searchname.css">
    <title>Поиск по имени</title>
</head>
<body>
    
    <div id="search-container">
        <label>Введите имя: <input type="text" name="searchName" id="nameInput"></label>
    </div>

    <div id="results-container">
        <table id="results-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Имя</th>
                    <th>Менеджер</th>
                    <th>Департамент</th>
                    <th>Город</th>
                    <th>Должность</th>
                    <th>Зарплата</th>
                </tr>
            </thead>
            <tbody id="results-body">
                <!-- Здесь будут отображаться результаты поиска -->
            </tbody>
        </table>
    </div>

    <div id="warning-container">
        <div id="warning-box">
            <p>Поле не может быть пустым или содержать цифры.</p>
            <button id="close-warning">Закрыть</button>
        </div>
    </div>

    <div class="button-container">
        <form action="index.jsp">
            <input class="btn-back" type="submit" value="Вернуться назад">
        </form>
    </div>

    <script>
        // Функция для обработки ввода в поле поиска
        document.getElementById("nameInput").addEventListener("input", function() {
            var name = this.value.trim();
            var resultsContainer = document.getElementById("results-container");
            var warningContainer = document.getElementById("warning-container");

            // Если в поле ввода менее двух символов, скрываем таблицу результатов
            if (name.length < 2) {
                resultsContainer.hidden = true;
                return;
            }

            // Если в имени есть цифры, показываем предупреждение
            if (/\d/.test(name)) {
                warningContainer.style.display = "flex";
                resultsContainer.hidden = true;
                return;
            }

            // Если в имени нет цифр и поле не пустое, отправляем запрос на сервер
            fetch("searchname.jsp?searchName=" + encodeURIComponent(name))
                .then(response => response.text())
                .then(data => {
                    // Обновляем содержимое таблицы результатов и отображаем таблицу
                    document.getElementById("results-body").innerHTML = data;
                    resultsContainer.hidden = false;
                })
                .catch(error => console.error("Ошибка при выполнении запроса:", error));
        });

        // Функция для закрытия предупреждения
        document.getElementById("close-warning").addEventListener("click", function() {
            document.getElementById("warning-container").style.display = "none";
        });
    </script>
</body>
</html>
