document.addEventListener('DOMContentLoaded', function () {
  const container = document.createElement('div');
  container.className = 'snowfall';
  document.body.appendChild(container);

  const numFlakes = 100;

  for (let i = 0; i < numFlakes; i++) {
    createSnowflake(container);
  }

  container.style.opacity = '1'; // Показываем снег после создания всех снежинок
});

function createSnowflake(container) {
  const snowflake = document.createElement('div');
  snowflake.className = 'snowflake';
  snowflake.innerHTML = '❄';

  const randomX = Math.random() * window.innerWidth;
  const randomY = Math.random() * window.innerHeight - 10; // Помещаем снег за верхнюю границу страницы
  const randomDelay = Math.random() * 5;
  const randomDuration = Math.random() * 3 + 2;

  snowflake.style.left = `${randomX}px`;
  snowflake.style.top = `${randomY}px`;
  snowflake.style.animationDelay = `${randomDelay}s`;
  snowflake.style.animationDuration = `${randomDuration}s`;

  container.appendChild(snowflake);
}
