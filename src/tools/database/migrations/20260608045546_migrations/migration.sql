-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('male', 'female');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "meta" JSONB,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "fullName" VARCHAR(255) NOT NULL,
    "placeOfBirth" VARCHAR(255) NOT NULL,
    "dateOfBirth" DATE NOT NULL,
    "gender" "Gender" NOT NULL,
    "age" INTEGER NOT NULL,
    "imagePath" VARCHAR(255),
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_has_permissions" (
    "roleId" INTEGER NOT NULL,
    "permissionId" INTEGER NOT NULL,

    CONSTRAINT "role_has_permissions_pkey" PRIMARY KEY ("roleId","permissionId")
);

-- CreateTable
CREATE TABLE "user_has_roles" (
    "userId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "user_has_roles_pkey" PRIMARY KEY ("userId","roleId")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE INDEX "users_username_index" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "profiles_userId_key" ON "profiles"("userId");

-- CreateIndex
CREATE INDEX "profiles_full_name_index" ON "profiles"("fullName");

-- CreateIndex
CREATE INDEX "profiles_gender_index" ON "profiles"("fullName");

-- CreateIndex
CREATE INDEX "profiles_nis_index" ON "profiles"("fullName");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE INDEX "roles_name_index" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_name_key" ON "permissions"("name");

-- CreateIndex
CREATE INDEX "permissions_name_index" ON "permissions"("name");

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_has_permissions" ADD CONSTRAINT "role_has_permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_has_permissions" ADD CONSTRAINT "role_has_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_has_roles" ADD CONSTRAINT "user_has_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_has_roles" ADD CONSTRAINT "user_has_roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
