# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_04_152714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cookbooks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_cookbooks_on_recipe_id"
    t.index ["user_id"], name: "index_cookbooks_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "party_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["party_id"], name: "index_messages_on_party_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_parties_on_user_id"
  end

  create_table "party_ingredients", force: :cascade do |t|
    t.string "name"
    t.bigint "user_party_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_party_id"], name: "index_party_ingredients_on_user_party_id"
  end

  create_table "party_recipes", force: :cascade do |t|
    t.boolean "choosen"
    t.bigint "party_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["party_id"], name: "index_party_recipes_on_party_id"
    t.index ["recipe_id"], name: "index_party_recipes_on_recipe_id"
  end

  create_table "query_recipes", force: :cascade do |t|
    t.bigint "user_query_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_query_recipes_on_recipe_id"
    t.index ["user_query_id"], name: "index_query_recipes_on_user_query_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.jsonb "ingredients"
    t.jsonb "instructions"
    t.integer "api_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_parties", force: :cascade do |t|
    t.bigint "party_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["party_id"], name: "index_user_parties_on_party_id"
    t.index ["user_id"], name: "index_user_parties_on_user_id"
  end

  create_table "user_queries", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_queries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "cookbooks", "recipes"
  add_foreign_key "cookbooks", "users"
  add_foreign_key "messages", "parties"
  add_foreign_key "messages", "users"
  add_foreign_key "parties", "users"
  add_foreign_key "party_ingredients", "user_parties"
  add_foreign_key "party_recipes", "parties"
  add_foreign_key "party_recipes", "recipes"
  add_foreign_key "query_recipes", "recipes"
  add_foreign_key "query_recipes", "user_queries"
  add_foreign_key "user_parties", "parties"
  add_foreign_key "user_parties", "users"
  add_foreign_key "user_queries", "users"
end
