function showNotification(message, isError) {
    var notification = document.createElement("div");
    notification.className = "notification" + (isError ? " error" : "");
    notification.innerText = message;
    document.body.appendChild(notification);

    // Анимация плавного появления
    setTimeout(function () {
        notification.classList.add("show");
    }, 10);

    // Удаляем уведомление через 3 секунды
    setTimeout(function () {
        notification.classList.remove("show");
        setTimeout(function () {
            document.body.removeChild(notification);
        }, 500); // Длительность анимации
    }, 3000);
}

function redirectToIndex() {
    setTimeout(function () {
        window.location.href = "index.jsp";
    }, 3000);
}