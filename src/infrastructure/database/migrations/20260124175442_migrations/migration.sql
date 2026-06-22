-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('male', 'female');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "role" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "nis" VARCHAR(255) NOT NULL,
    "fullName" VARCHAR(255) NOT NULL,
    "placeOfBirth" VARCHAR(255),
    "dateOfBirth" DATE,
    "gender" "Gender",
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "classes" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "grade" INTEGER NOT NULL,
    "maxStudent" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "classes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subjects" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "grade" INTEGER NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "subjects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "class_has_students" (
    "classId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,

    CONSTRAINT "class_has_students_pkey" PRIMARY KEY ("classId","studentId")
);

-- CreateTable
CREATE TABLE "topics" (
    "id" SERIAL NOT NULL,
    "subjectId" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "text" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "topics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sub_topics" (
    "id" SERIAL NOT NULL,
    "topicId" INTEGER NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255),
    "video" VARCHAR(255),
    "pdf" VARCHAR(255),

    CONSTRAINT "sub_topics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "projects" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assignments" (
    "id" SERIAL NOT NULL,
    "projectId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,
    "file" VARCHAR(255) NOT NULL,
    "fileType" VARCHAR(255) NOT NULL,
    "isScored" BOOLEAN NOT NULL DEFAULT false,
    "assessorId" INTEGER,
    "detailScore" JSON,
    "score" DOUBLE PRECISION,
    "feedback" VARCHAR(255),
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teams" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "projectId" INTEGER NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "teams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team_members" (
    "teamId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,

    CONSTRAINT "team_members_pkey" PRIMARY KEY ("teamId","studentId")
);

-- CreateTable
CREATE TABLE "report_cards" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "score" DOUBLE PRECISION,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,

    CONSTRAINT "report_cards_pkey" PRIMARY KEY ("id")
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
CREATE INDEX "classes_name_index" ON "classes"("name");

-- CreateIndex
CREATE INDEX "subjects_name_index" ON "subjects"("name");

-- CreateIndex
CREATE INDEX "topics_title_index" ON "topics"("title");

-- CreateIndex
CREATE INDEX "sub_topics_title_index" ON "sub_topics"("title");

-- CreateIndex
CREATE INDEX "projects_name_index" ON "projects"("name");

-- CreateIndex
CREATE INDEX "projects_start_time_index" ON "projects"("startTime");

-- CreateIndex
CREATE INDEX "projects_end_time_index" ON "projects"("endTime");

-- CreateIndex
CREATE UNIQUE INDEX "assignments_teamId_key" ON "assignments"("teamId");

-- CreateIndex
CREATE UNIQUE INDEX "report_cards_studentId_key" ON "report_cards"("studentId");

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "class_has_students" ADD CONSTRAINT "class_has_students_classId_fkey" FOREIGN KEY ("classId") REFERENCES "classes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "class_has_students" ADD CONSTRAINT "class_has_students_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "topics" ADD CONSTRAINT "topics_subjectId_fkey" FOREIGN KEY ("subjectId") REFERENCES "subjects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sub_topics" ADD CONSTRAINT "sub_topics_topicId_fkey" FOREIGN KEY ("topicId") REFERENCES "topics"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignments" ADD CONSTRAINT "assignments_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignments" ADD CONSTRAINT "assignments_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "assignments" ADD CONSTRAINT "assignments_assessorId_fkey" FOREIGN KEY ("assessorId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teams" ADD CONSTRAINT "teams_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team_members" ADD CONSTRAINT "team_members_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team_members" ADD CONSTRAINT "team_members_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "report_cards" ADD CONSTRAINT "report_cards_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
