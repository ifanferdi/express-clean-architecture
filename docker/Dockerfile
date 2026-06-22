# Stage 1 — Build
FROM node:22-slim AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npx prisma generate
RUN npm run build

# Stage 2 — Production
FROM node:22-slim AS production
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=build /app/dist ./dist
COPY --from=build /app/src/infrastructure/database/prisma/generated ./src/infrastructure/database/prisma/generated

EXPOSE 3000

CMD ["npm", "run", "start"]
