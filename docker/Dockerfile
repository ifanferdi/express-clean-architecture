# Stage 1 — build (install semua + devDependencies)
FROM oven/bun:1 AS build
WORKDIR /app

COPY package.json bun.lockb* ./
RUN bun install

COPY . .
RUN bunx prisma generate
RUN bun run build

# Stage 2 — production (install ulang tanpa devDependencies)
FROM oven/bun:1-slim AS production
WORKDIR /app

COPY package.json bun.lockb* ./
RUN bun install --production

COPY --from=build /app/dist ./dist
COPY --from=build /app/src/infrastructure/database/prisma/generated ./src/infrastructure/database/prisma/generated

EXPOSE 3000
CMD ["bun", "run", "dist/app.js"]