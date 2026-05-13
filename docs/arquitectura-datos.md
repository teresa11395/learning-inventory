# Arquitectura de datos · Learning Inventory

## ¿Qué es una Foreign Key?

Una Foreign Key (clave foránea) es una columna que almacena el `id`
de un registro de otra tabla, creando un vínculo formal entre ambas.

En nuestro caso, `products.category_id` contiene el UUID de una fila
de `categories`. PostgreSQL garantiza que ese UUID siempre existirá:
no puedes insertar un producto apuntando a una categoría inexistente,
y no puedes borrar una categoría mientras tenga productos asociados.

Esto es integridad referencial: el motor protege la coherencia
de los datos sin que tengamos que escribir esa lógica en el código.

## ON DELETE CASCADE vs ON DELETE RESTRICT

### ON DELETE CASCADE
Cuando se elimina una categoría, PostgreSQL borra automáticamente
todos sus productos asociados.

**Riesgo:** una sola operación puede borrar cientos de registros
de forma silenciosa e irreversible.

### ON DELETE RESTRICT (nuestra elección)
PostgreSQL bloquea el DELETE si la categoría tiene productos
asociados, devolviendo un error que nos obliga a actuar conscientemente.

### ¿Por qué elegimos RESTRICT?
En un inventario, un producto tiene valor propio: precio, stock,
historial. Si alguien intenta borrar "Electrónica" con 50 productos
dentro, lo más probable es que sea un error humano. RESTRICT lo
detiene y obliga a reasignar o eliminar los productos primero.

Regla general:
- Si el hijo no tiene sentido sin el padre → CASCADE
- Si el hijo puede vivir sin el padre → RESTRICT

## Tipos de datos

| Columna       | Tipo          | Razón                                           |
|---------------|---------------|-------------------------------------------------|
| id            | UUID          | Identificador único global                      |
| name          | VARCHAR(n)    | Texto con límite explícito                      |
| description   | TEXT          | Texto libre sin límite                          |
| price         | NUMERIC(10,2) | Decimal exacto, evita errores de punto flotante |
| stock         | INTEGER       | Números enteros                                 |