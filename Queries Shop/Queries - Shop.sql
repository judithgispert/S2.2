USE tienda;

-- 1. List the names of all products in the PRODUCTO table:
SELECT nombre AS Product_name FROM producto;

-- 2. List the names + prices of all products in the PRODUCTO table:
SELECT nombre AS Product_name, precio AS Product_pice FROM producto;

-- 3. List all the columns of the PRODUCTO table:
SELECT * FROM producto;

-- 4. List the names + prices in € + prices in $ off all the products in PRODUCTO table:
SELECT nombre AS Product_name, precio AS Price_€, ROUND(precio * 1.07, 2) AS Price_$ FROM producto;

-- 5. List the names + prices in € + prices in $ off all the products in PRODUCTO table, use these names for the columns (Product name, euros, dollars):
SELECT nombre AS 'Product name', precio AS 'Euros', ROUND(precio * 1.07, 2) AS 'Dollars' FROM producto;

-- 6. List the names + prices of all the products in the PRODUCTO table, changing names to uppercase:
SELECT UPPER(nombre) AS Product_name, precio AS Price FROM producto;

-- 7. List the names + prices of all the products in the PRODUCTO table, changing names to lowercase:
SELECT LOWER(nombre) AS Product_name, precio AS Price FROM producto;

-- 8. List the name of all manufacturers in one column, in the other, get the first 2 char (uppercase) of the name:
SELECT nombre, SUBSTRING(UPPER(nombre), 1, 2) AS nombre_2 FROM fabricante;

-- 9. List the names + prices (rounded result) of all products in the PRODUCTO table:
SELECT nombre AS Product_name, ROUND(precio) AS Rounded_price FROM producto;

-- 10. List the names + prices (truncate price value to display without decimals) of all products in the PRODUCTO table:
SELECT nombre AS Product_name, TRUNCATE (precio, 0) AS Price_without_Decimals FROM producto;

-- 11. List the code of the manufacturers that have products in the PRODUCTO table:
SELECT f.codigo AS Manufacturer_code FROM fabricante f INNER JOIN producto p ON codigo_fabricante = f.codigo;

-- 12. List the code of the manufacturers that have products in the PRODUCTO table (delete repeated codes):
SELECT DISTINCT f.codigo AS Manufacturer_code FROM fabricante f INNER JOIN producto p ON codigo_fabricante = f.codigo;

-- 13. List the names of all the manufacturers in ascending order:
SELECT nombre AS Manufacturer_name_ASC FROM fabricante ORDER BY nombre ASC;

-- 14. List the names of all the manufacturers in descending order:
SELECT nombre AS Manufacturer_name_DESC FROM fabricante ORDER BY nombre DESC;

-- 15. List the names of all the products, first ascending order, then the price in descending order:
SELECT nombre AS Product_name, precio AS Price FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. Returns a list with the first 5 rows of the FABRICANTE table:
SELECT * FROM fabricante LIMIT 5;

-- 17. Returns a list with 2 row starting from the 4th row (included) of FABRICANTE table:
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- 18. List the cheapest product (name + price), use Order by and Limit clauses:
SELECT nombre AS Product_name, precio AS Price FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. List the most expensive product (name + price), use ORDER BY and LIMIT clauses:
SELECT nombre AS Product_name, precio AS Price FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. List the name of all the products where manufacturer code = 2:
SELECT nombre AS Product_name FROM producto WHERE codigo_fabricante = 2;

-- 21. Return a list with (product name + product price + manufacturer name) of all products in the database:
SELECT p.nombre AS Product_name, precio AS Product_price, f.nombre AS Manufacturer_name FROM producto p INNER JOIN fabricante f ON  codigo_fabricante = f.codigo;

-- 22. Return a list with (product name + product price + manufacturer name) of all products in the database. Sort the result by manufacturer name (alphabetical order):
SELECT p.nombre AS Product_name, precio AS Price, f.nombre AS Manufacturer_name FROM producto p INNER JOIN fabricante f ON  codigo_fabricante = f.codigo ORDER BY f.nombre ASC;

-- 23. Return a list with (product code + product name + manufacturer code + manufacturer name) of all the products in the database:
SELECT p.codigo AS Product_code, p.nombre AS Product_name, f.codigo AS Manufacturer_code, f.nombre AS Manufacturer_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo;

-- 24. Return (product name + product price + manufacturer name) of the cheapest product:
SELECT p.nombre AS Product_name, p.precio AS Product_price, f.nombre AS Manufacturer_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo ORDER BY p.precio ASC LIMIT 1;

-- 25. Return (product name + product price + manufacturer name) of the most expensive product:
SELECT p.nombre AS Product_name, p.precio AS Product_price, f.nombre AS Manufacturer_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;

-- 26. Returns a list of all products from manufacturer LENOVO:
SELECT p.* FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- 27. Returns a list of all products from manufacturer CRUCIAL that (price < 200€):
SELECT p.* FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' && p.precio > 200;

-- 28. Returns a list with all products from manufacturers (Asus, Hewlett-Packard & Seagate), without using the IN operator:
SELECT p.* FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- 29. Returns a list with all products from manufacturers (Asus, Hewlett-Packard & Seagate), using the IN operator:
SELECT * FROM producto INNER JOIN fabricante ON codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30. Returns a list with name + price of all products  where manufacturers name ends with 'e':
SELECT p.nombre AS Product_name, p.precio AS Product_price FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';

-- 31. Returns a list with name + price of all products where manufacturers name contains 'w':
SELECT p.nombre AS Product_name, p.precio AS Product_price FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre LIKE '%w%';

-- 32. Returns a list with (product name + product price + manufacturer name) of all products that price >= 180€. First, sort the result by price (DESC) and second by name (ASC):
SELECT p.nombre AS Product_name, p.precio AS Product_price, f.nombre AS Manufacturer_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre ASC;

-- 33. Returns a list with manufacturer code + name, only of those manufacturers that have products in the database:
SELECT DISTINCT f.codigo AS Manufacturer_code, f.nombre AS Manufacturer_name FROM fabricante f INNER JOIN producto p ON f.codigo = codigo_fabricante;

-- 34. Returns a list of all the manufacturers that exist + products. The list must also show those manufacturers that don't have products:
SELECT * FROM fabricante f LEFT OUTER JOIN producto p ON f.codigo = codigo_fabricante;

-- 35. Returns a list showing only those manufacturers that don't have products:
SELECT f.* FROM fabricante f LEFT OUTER JOIN producto p ON f.codigo = codigo_fabricante WHERE codigo_fabricante IS NULL;

-- 36. Returns all products from the manufacturer LENOVO (without using INNER JOIN):
SELECT p.* FROM producto p LEFT OUTER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- 37. Returns all products that have the same price as the most expensive product from manufacturer LENOVO (without using INNER JOIN):
SELECT p.* FROM producto p LEFT OUTER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE p.precio = (SELECT MAX(p.precio) FROM producto p LEFT OUTER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

-- 38. List the name of the most expensive product from the manufacturer LENOVO:
SELECT p.nombre AS Product_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE p.precio = (SELECT MAX(p.precio) FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

-- 39. List the cheapest product name from the manufacturer HEWLETT-PACKARD:
SELECT p.nombre AS Product_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio ASC LIMIT 1;

-- 40. Returns all products in the database that have a price >= the most expensive product from manufacturer LENOVO:
SELECT p.nombre AS Product_name FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE p.precio >= (SELECT MAX(p.precio) FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

-- 41. List all products from manufacturer ASUS that have price > the average price of all their products:
SELECT p.* FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE p.precio > (SELECT AVG(p.precio) FROM producto p INNER JOIN fabricante f ON codigo_fabricante = f.codigo WHERE f.nombre = 'Asus') AND f.nombre = 'Asus';





