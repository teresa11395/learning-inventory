import { pgTable, uuid, varchar, numeric, integer } from 'drizzle-orm/pg-core';

export const categories = pgTable('categories', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: varchar('name', { length: 100 }).notNull().unique(),
  description: varchar('description'),
});

export const products = pgTable('products', {
  id: uuid('id').defaultRandom().primaryKey(),
  name: varchar('name', { length: 150 }).notNull(),
  price: numeric('price', { precision: 10, scale: 2 }).notNull(),
  stock: integer('stock').notNull().default(0),
  category_id: uuid('category_id').notNull().references(() => categories.id),
});