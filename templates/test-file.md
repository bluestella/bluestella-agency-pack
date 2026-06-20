// Coverage target: ≥ 80%
Language: TypeScript
Test runner: Vitest
File path convention: tests/[domain]/[entity].test.ts

import { describe, it, beforeEach, afterEach, expect, vi } from 'vitest'

// Full DB mock — DO NOT use a real database in unit tests
const mockDB = {
query: vi.fn()
}

const mock[ENTITY] = {
id: 'test-id',
name: 'Example'
}

describe('[DOMAIN] [ENTITY] repository', () => {
beforeEach(() => {
mockDB.query.mockReset()
})

afterEach(() => {
mockDB.query.mockReset()
})

it('[unit]\_findById_found_returns_entity', async () => {
// Arrange
mockDB.query.mockResolvedValueOnce({ rows: [mock[ENTITY]] })

    // Act
    // call repository.findById

    // Assert
    // expect result to equal mock[ENTITY]

})

it('[unit]\_findById_not_found_returns_null', async () => {
// Arrange
mockDB.query.mockResolvedValueOnce({ rows: [] })

    // Act

    // Assert

})

it('[unit]\_softDelete_sets_deletedAt_and_keeps_row', async () => {
// Arrange
mockDB.query.mockResolvedValue({ rows: [{ id: 'test-id' }] })

    // Act

    // Assert

})
})
