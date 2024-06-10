-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)

alter table products
    add constraint new_price check (products.unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1

alter table products
    add constraint new_discontinued check (products.discontinued in (0, 1));


-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)

create table withdrawn as
select *
from products
where products.discontinued = 1;


-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.


delete
from order_details
where order_details.product_id in (select products.product_id from products where discontinued = 1);

delete
from products
where products.discontinued = 1;

