<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">


    <script src="javascripts/delete.js"></script>
    <link rel="stylesheet" href="styles/style_delete.css" />
    <title>Удаление сотрудника</title>

    <script src="javascripts/snowfall.js"></script>
    <style>
        body {
        overflow: hidden;
        margin: 0;
        }

        .snowfall {
        position: fixed;
        top: -100vh; /* Помещаем снег за верхнюю границу страницы */
        left: 0;
        pointer-events: none;
        width: 100%;
        height: 110vh; /* Увеличиваем высоту для плавного появления снега */
        z-index: 1;
        opacity: 0;
        }

        .snowflake {
        position: absolute;
        font-size: 20px;
        color: #fff;
        user-select: none;
        animation: fall linear infinite, fadeIn 5s forwards;
        transform: translateY(-10vh);
        text-shadow: 0 0 3px #000; /* Добавляем черный контур снегу */
            
        }

        @keyframes fall {
            to {
                transform: translateY(110vh);
            }
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

    </style>

</head>
<body>
    
    <h1>Удаление сотрудника</h1>
    <p></p>

    <div class="container">
        <form action="delete.jsp" method="post">
            <label for="employee_id">ID Сотрудника:</label>
            <input type="number" name="employee_id" id="employee_id" required>

            <div class="btn-container">
                <button id="btn-delete" type="button" onclick="deleteEmployee()">Удалить</button>
                <button id="btn-back" type="button" onclick="redirectToIndex()">Вернуться назад</button>
            </div>
        </form>
    </div>

    <div class="notification"></div>
    <div class="error-notification"></div>

</body>
</html>
