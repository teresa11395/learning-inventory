-- =============================================================
-- FASE 6 · Paso 2 · Datos de prueba (seed)
-- =============================================================

-- -------------------------------------------------------------
-- Insertar categorías
-- -------------------------------------------------------------
INSERT INTO categories (name, description) VALUES
('Electrónica',   'Dispositivos y gadgets tecnológicos'),
('Hogar',         'Muebles, decoración y electrodomésticos'),
('Deportes',      'Material deportivo y ropa técnica'),
('Alimentación',  'Productos frescos y de despensa');

-- -------------------------------------------------------------
-- Insertar productos
-- -------------------------------------------------------------
INSERT INTO products (name, price, stock, category_id) VALUES
('Laptop Pro 15',     999.99,  10, (SELECT id FROM categories WHERE name = 'Electrónica')),
('Auriculares BT',     59.99,  35, (SELECT id FROM categories WHERE name = 'Electrónica')),
('Smart TV 55"',      499.99,   8, (SELECT id FROM categories WHERE name = 'Electrónica')),
('Silla Ergonómica',  249.00,   5, (SELECT id FROM categories WHERE name = 'Hogar')),
('Lámpara LED',        29.99,  50, (SELECT id FROM categories WHERE name = 'Hogar')),
('Zapatillas Running', 89.99,  20, (SELECT id FROM categories WHERE name = 'Deportes')),
('Botella Térmica',    19.99,  60, (SELECT id FROM categories WHERE name = 'Deportes')),
('Aceite de Oliva',     8.99, 100, (SELECT id FROM categories WHERE name = 'Alimentación'));

-- -------------------------------------------------------------
-- Simular una venta: restar 3 unidades de Laptop Pro 15
-- -------------------------------------------------------------
UPDATE products
SET stock = stock - 3
WHERE name = 'Laptop Pro 15';

-- -------------------------------------------------------------
-- Eliminar un producto descatalogado
-- -------------------------------------------------------------
DELETE FROM products
WHERE name = 'Botella Térmica';