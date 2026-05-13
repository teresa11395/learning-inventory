# Análisis SQL · Learning Inventory

## INNER JOIN vs LEFT JOIN

### INNER JOIN
Devuelve únicamente las filas donde existe coincidencia
en **ambas** tablas. Si un registro no tiene relación, desaparece.

**Escenario real:** obtener productos con su categoría.
Si un producto no tuviera categoría asignada, no aparecería
en el resultado. Útil cuando solo nos interesan datos completos.

```sql
SELECT p.name, p.price, c.name AS categoria
FROM products p
INNER JOIN categories c ON p.category_id = c.id;
```

### LEFT JOIN
Devuelve **todas** las filas de la tabla izquierda, y las
coincidentes de la derecha. Si no hay coincidencia, devuelve NULL.

**Escenario real:** contar productos por categoría.
Necesitamos ver todas las categorías aunque alguna esté vacía,
para detectar categorías sin productos asignados.

```sql
SELECT c.name, COUNT(p.id) AS total_productos
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
GROUP BY c.name;
```

### Regla para elegir
- ¿Solo quiero datos completos con relación en ambos lados? → INNER JOIN
- ¿Quiero todos los registros del lado izquierdo aunque no tengan relación? → LEFT JOIN