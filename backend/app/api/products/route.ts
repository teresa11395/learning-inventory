import { NextResponse } from 'next/server';
import { neon } from '@neondatabase/serverless';
import { drizzle } from 'drizzle-orm/neon-http';
import { products, categories } from '@/lib/schema';
import { eq } from 'drizzle-orm';

const sql = neon(process.env.DATABASE_URL!);
const db = drizzle(sql);

// GET - Obtener todos los productos con su categoría usando Drizzle
export async function GET() {
  try {
    const result = await db
      .select({
        id: products.id,
        name: products.name,
        price: products.price,
        stock: products.stock,
        category: categories.name,
      })
      .from(products)
      .innerJoin(categories, eq(products.category_id, categories.id));

    return NextResponse.json(result);
  } catch (error) {
    return NextResponse.json(
      { error: 'Error al obtener productos' },
      { status: 500 }
    );
  }
}

// POST - Insertar un nuevo producto
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { name, price, stock, category_id } = body;

    const result = await db.insert(products).values({
      name,
      price,
      stock,
      category_id,
    }).returning();

    return NextResponse.json(result[0], { status: 201 });
  } catch (error) {
    return NextResponse.json(
      { error: 'Error al insertar producto' },
      { status: 500 }
    );
  }
}