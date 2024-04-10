# Используем официальный образ Maven
FROM maven:3.8.4-openjdk-11 AS build

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . .

# Собираем проект с помощью Maven
RUN mvn clean package



# Используем официальный образ Tomcat
FROM tomcat:latest

# Копируем .war файл из предыдущего этапа сборки в директорию Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/

# Экспонируем порт 8080 для доступа к веб-приложению
EXPOSE 8080

# Копируем JDBC драйвер PostgreSQL в директорию lib Tomcat
COPY ./src/lib/postgresql-42.7.2.jar /usr/local/tomcat/lib/

# Запускаем Tomcat
CMD ["catalina.sh", "run"]