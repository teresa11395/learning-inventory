# Learning Inventory — Backend

API REST construida con Next.js y desplegada en Vercel.
Conectada a una base de datos PostgreSQL serverless en Neon.

## Stack técnico

- **Next.js** — framework para API Routes
- **Neon** — PostgreSQL serverless
- **Drizzle ORM** — ORM tipado para TypeScript
- **TypeScript** — tipado estático

## Endpoints

- `GET /api/products` — devuelve todos los productos con su categoría
- `POST /api/products` — inserta un nuevo producto

## Ventaja de usar Drizzle ORM

Escribir SQL puro funciona y es fundamental para entender los cimientos
de las bases de datos. Sin embargo, en proyectos grandes presenta
limitaciones: las queries son strings sin validación, los errores
solo aparecen en tiempo de ejecución y el código es difícil de
mantener.

Drizzle ORM resuelve esto definiendo el esquema de la base de datos
en TypeScript. Esto permite que el editor detecte errores antes de
ejecutar el código — si intentas acceder a un campo que no existe,
TypeScript te avisa con una línea roja directamente en VS Code.

Además las queries se escriben en TypeScript con autocompletado,
lo que hace el código más legible, más seguro y más fácil de mantener.

## Variables de entorno

Crea un archivo `.env.local` con:

```
DATABASE_URL="postgresql://..."
```