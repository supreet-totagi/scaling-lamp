CREATE TABLE "users" (
  "id" varchar PRIMARY KEY,
  "full_name" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "approval_status" int DEFAULT 0,
  "comments" varchar
);

CREATE TABLE "login_attempts" (
  "user_id" varchar,
  "created_at" timestamp,
  "is_success" boolean,
  "channel" varchar
);

CREATE TABLE "food_inventory" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "price" float,
  "quantity" int,
  "start_date" timestamp,
  "end_date" timestamp,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "purchases" (
  "id" SERIAL PRIMARY KEY,
  "user_id" varchar,
  "food_id" int,
  "quantity" int,
  "created_at" timestamp,
  "updated_at" timestamp
);

ALTER TABLE "login_attempts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "purchases" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "purchases" ADD FOREIGN KEY ("food_id") REFERENCES "food_inventory" ("id");

CREATE INDEX ON "users" ("approval_status");

CREATE INDEX ON "login_attempts" ("created_at");

COMMENT ON COLUMN "users"."approval_status" IS '0: waiting, 1: approved, 2: rejected';
