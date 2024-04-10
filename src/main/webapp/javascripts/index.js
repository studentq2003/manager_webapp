function showLoadingNotification() {
    var notification = document.createElement("div");
    notification.className = "notification";
    notification.innerText = "Данные загружены";
    document.body.appendChild(notification);
    setTimeout(function () {
        notification.style.backgroundColor = "#4CAF50";
        notification.style.top = "0";
    }, 10);
    setTimeout(function () {
        notification.style.top = "-100px";
        setTimeout(function () {
            document.body.removeChild(notification);
        }, 500);
    }, 1000);
}
showLoadingNotification();