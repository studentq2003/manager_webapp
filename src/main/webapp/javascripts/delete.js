function showNotification(message, backgroundColor) {
    var notification = document.querySelector(".notification");
    notification.style.backgroundColor = backgroundColor;
    notification.innerText = message;
    notification.classList.add("show");

    // Удаляем уведомление через 3 секунды
    setTimeout(function () {
        notification.classList.remove("show");
    }, 2000);
}

function redirectToIndex() {
    window.location.href = "index.jsp";
}

function deleteEmployee() {
    var employeeId = document.getElementById("employee_id").value;
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            if (response.success) {
                showNotification("Сотрудник успешно удален.", "#4CAF50");
                setTimeout(function () {
                    window.location.href = "index.jsp";
                }, 2000);
            } else {
                showNotification("Ошибка при удалении сотрудника.", "#FF5733");
            }
        }
    };
    xhr.open("GET", "delete_employee.jsp?employee_id=" + employeeId, true);
    xhr.send();
}