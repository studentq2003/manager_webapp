<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Простой калькулятор</title>
    <link rel="stylesheet" href="../styles/calculator.css">
    <script src="javascripts/index.js"></script>


    <link rel="stylesheet" href="snow_settings/snowfall.css">
    <script src="snow_settings/snowfall.js"></script>
</head>
<body>
    <h1>Простой калькулятор</h1>
    <form class='container1' id="calculatorForm">
        <input class='inp1' type="text" id="num1" placeholder="введите 1 число" required>
        <select class='selector' id="operation" name="operation">
            <option value="add">+</option>
            <option value="subtract">-</option>
            <option value="multiply">*</option>
            <option value="divide">/</option>
        </select>
        <input class='inp1' type="text" id="num2" placeholder="введите 2 число" required>
        <input class='btn' type="button" value="Calculate" onclick="calculate()">
        <button class="btn" onclick="window.location.href='../index.jsp'">На главную</button>
        <span class='out' id="result"></span>

        <span id="error" style="color: red;"></span>
        

    </form>
    

    <script>
        function calculate() {
            var num1 = parseFloat(document.getElementById("num1").value);
            var num2 = parseFloat(document.getElementById("num2").value);
            var operation = document.getElementById("operation").value;
            var result = 0;
            var error = "";

            switch (operation) {
                case "add":
                    o = '+'
                    result = num1 + num2;
                    break;
                case "subtract":
                    o = '-'
                    result = num1 - num2;
                    break;
                case "multiply":
                    o = '*'
                    result = num1 * num2;
                    break;
                case "divide":
                    if (num2 != 0) {
                        o = '/'
                        result = num1 / num2;
                    } else {
                        error = "Деление на 0.";
                    }
                    break;
            }

            if (error === "") {
                document.getElementById("result").innerHTML = num1 + " " + o + " " + num2 + " = " + result;
                document.getElementById("error").innerHTML = "";
            } else {
                document.getElementById("error").innerHTML = error;
                document.getElementById("result").innerHTML = "";
                window.location.href = "error.jsp";
            }
        }
    </script>
</body>
</html>
