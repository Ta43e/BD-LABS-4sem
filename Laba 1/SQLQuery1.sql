SELECT Наименование_товара
FROM     ЗАКАЗЫ
WHERE  (Дата_поставки > CONVERT(DATETIME, '2023-02-17 00:00:00', 102))