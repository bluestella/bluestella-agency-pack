Language: TypeScript
File path convention: src/api/[domain]/route.ts

Imports:
- import { NextRequest, NextResponse } from 'next/server'
- import { z } from 'zod'
- import { withAuth } from '@/middleware/auth'
- import { withRateLimit } from '@/middleware/rateLimit'
- import { [ENTITY]Repository } from '@/services/[domain]/[entity].repository'
- import { handleApiError } from '@/lib/handleApiError'

Request schemas:
- const createSchema = z.object({/* define fields */})
- const updateSchema = z.object({/* define fields */})

GET handler:
- export async function GET(req: NextRequest) {
-   try {
-     await withAuth(req)
-     await withRateLimit(req)
-     const repo = new [ENTITY]Repository()
-     const result = await repo.findMany({ page: 1, limit: 20 })
-     return NextResponse.json({ data: result })
-   } catch (err) {
-     return handleApiError(err)
-   }
- }

POST handler:
- export async function POST(req: NextRequest) {
-   try {
-     await withAuth(req)
-     await withRateLimit(req)
-     const body = await req.json()
-     const parsed = createSchema.parse(body)
-     const repo = new [ENTITY]Repository()
-     const created = await repo.create(parsed)
-     return new NextResponse(JSON.stringify({ data: created }), { status: 201 })
-   } catch (err) {
-     return handleApiError(err)
-   }
- }

PUT handler:
- export async function PUT(req: NextRequest) {
-   try {
-     await withAuth(req)
-     await withRateLimit(req)
-     const body = await req.json()
-     const parsed = updateSchema.parse(body)
-     const repo = new [ENTITY]Repository()
-     const updated = await repo.update(parsed.id, parsed)
-     if (!updated) return new NextResponse(JSON.stringify({ error: 'Not found', code: 'NOT_FOUND' }), { status: 404 })
-     return NextResponse.json({ data: updated })
-   } catch (err) {
-     return handleApiError(err)
-   }
- }

DELETE handler:
- export async function DELETE(req: NextRequest) {
-   try {
-     await withAuth(req)
-     await withRateLimit(req)
-     const { id } = await req.json()
-     const repo = new [ENTITY]Repository()
-     await repo.softDelete(id)
-     return NextResponse.json({ data: { id } })
-   } catch (err) {
-     return handleApiError(err)
-   }
- }

Notes:
- PLACEHOLDERS: [DOMAIN], [ENTITY] — fill when instantiating the template
