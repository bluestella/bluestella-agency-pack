Language: TypeScript
File path convention: src/services/[domain]/[entity].repository.ts

export class [ENTITY]Repository {
  constructor(private db: any) {}

  async findById(id: string) {
    const row = await this.db.query(`SELECT * FROM [entity]Table WHERE id = $1 AND deletedAt IS NULL`, [id])
    return row?.rows?.[0] ?? null
  }

  async findMany({ page = 1, limit = 20 }: { page?: number; limit?: number }) {
    const offset = (page - 1) * limit
    const itemsRes = await this.db.query(`SELECT * FROM [entity]Table WHERE deletedAt IS NULL ORDER BY createdAt DESC LIMIT $1 OFFSET $2`, [limit, offset])
    const totalRes = await this.db.query(`SELECT COUNT(*) as total FROM [entity]Table WHERE deletedAt IS NULL`)
    const total = Number(totalRes.rows[0].total || 0)
    const pages = Math.ceil(total / limit)
    return { items: itemsRes.rows, meta: { page, limit, total, pages } }
  }

  async create(data: any) {
    const res = await this.db.query(`INSERT INTO [entity]Table (...) VALUES (...) RETURNING *`, [])
    return res.rows[0]
  }

  async update(id: string, data: any) {
    const res = await this.db.query(`UPDATE [entity]Table SET ... WHERE id = $1 AND deletedAt IS NULL RETURNING *`, [id])
    return res.rows[0] ?? null
  }

  async softDelete(id: string) {
    await this.db.query(`UPDATE [entity]Table SET deletedAt = NOW() WHERE id = $1`, [id])
    return { id }
  }
}

Placeholders: [ENTITY], [entity], [entity]Table — replace when instantiating
