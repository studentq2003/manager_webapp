DO
$$
BEGIN
    IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'public') THEN
        CREATE SCHEMA public;
    END IF;
END
$$;

COMMENT ON SCHEMA public IS 'standard public schema';

CREATE TABLE IF NOT EXISTS public.category (
    category_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    salary NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS public.department (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    mail VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    department_id INTEGER,
    category_id INTEGER,
    manager_id INTEGER,
    date_of_employment DATE NOT NULL,
    FOREIGN KEY (category_id) REFERENCES public.category(category_id),
    FOREIGN KEY (department_id) REFERENCES public.department(department_id),
    FOREIGN KEY (manager_id) REFERENCES public.employee(id)
);

INSERT INTO public.category (title, salary) VALUES ('Frontend-разработчик', 40000);
INSERT INTO public.category (title, salary) VALUES ('Backend-разработчик', 90000);
INSERT INTO public.category (title, salary) VALUES ('QA', 50000);
INSERT INTO public.category (title, salary) VALUES ('Project Manager', 300000);
INSERT INTO public.category (title, salary) VALUES ('Team Leader', 400000);

INSERT INTO public.department (name, city, address, mail) VALUES ('Отдел разработки', 'Москва', 'ул. Ленина, д. 123', 'dev_department@example.com');
INSERT INTO public.department (name, city, address, mail) VALUES ('Отдел продаж', 'Санкт-Петербург', 'пр. Невский, д. 456', 'sales_department@example.com');

INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Иван', 'Иванов', 1, 1, NULL, '2023-01-01');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Петр', 'Петров', 1, 2, 1, '2023-02-15');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Сидор', 'Сидоров', 1, 3, 1, '2023-03-20');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Анна', 'Иванова', 1, 4, 1, '2023-04-10');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Елена', 'Петрова', 1, 5, 1, '2023-05-05');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Михаил', 'Сидоров', 1, 1, 1, '2023-06-10');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Ольга', 'Алексеева', 2, 1, NULL, '2023-07-15');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Ирина', 'Петрова', 2, 2, 7, '2023-08-20');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Алексей', 'Иванов', 2, 3, 7, '2023-09-25');
INSERT INTO public.employee (name, surname, department_id, category_id, manager_id, date_of_employment) VALUES ('Наталья', 'Сидорова', 2, 4, 7, '2023-10-30');
