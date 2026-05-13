# Seguridad de base de datos · Learning Inventory

## ¿Qué es la inyección SQL?

Es un ataque donde el usuario introduce código SQL malicioso
en un campo de texto que se concatena directamente en una query.

### Ejemplo vulnerable

```typescript
const name = req.body.name; // el usuario escribe: ' OR '1'='1
const query = "SELECT * FROM products WHERE name = '" + name + "'";
// La query resultante devuelve TODOS los productos
```

## Cómo lo hemos prevenido

Usamos el driver `@neondatabase/serverless` con template literals
que separan la query de los datos automáticamente.

### Código seguro en nuestro proyecto

```typescript
// POST /api/products - app/api/products/route.ts
const result = await sql`
  INSERT INTO products (name, price, stock, category_id)
  VALUES (${name}, ${price}, ${stock}, ${category_id})
  RETURNING *
`;
```

Los valores entre `${}` se transmiten como parámetros separados,
nunca concatenados. El motor los trata como datos puros,
no como código SQL ejecutable.

## Otras medidas de seguridad aplicadas

- `DATABASE_URL` guardada en `.env.local`, nunca en el código
- `.env*` añadido al `.gitignore` para que nunca llegue a GitHub
- Validación de tipos con TypeScript en los endpoints