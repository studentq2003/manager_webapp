function showNotification(message, isError) {
    var notification = document.createElement("div");
    notification.className = isError ? "notification" : "notification notification-success";
    notification.innerText = message;
    document.body.appendChild(notification);

    setTimeout(function () {
        notification.classList.add("show");
    }, 10);

    setTimeout(function () {
        notification.classList.remove("show");
        setTimeout(function () {
            document.body.removeChild(notification);
        }, 500);
    }, 3000);
}