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

ActiveRecord::Schema.define(version: 2019_08_11_184750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cargapp_integrations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "provider"
    t.string "code"
    t.string "url"
    t.string "url_provider"
    t.string "url_production"
    t.string "url_develop"
    t.string "email"
    t.string "username"
    t.string "password"
    t.string "phone"
    t.string "pin"
    t.string "token"
    t.string "app_id"
    t.string "client_id"
    t.string "api_key"
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cargapp_integrations_on_user_id"
  end

  create_table "cargapp_models", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "value"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.string "image"
    t.integer "point"
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.bigint "state_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "company_type"
    t.bigint "load_type_id", null: false
    t.string "sector"
    t.string "legal_representative"
    t.string "address"
    t.string "phone"
    t.bigint "user_id", null: false
    t.date "constitution_date"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["load_type_id"], name: "index_companies_on_load_type_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.string "cioc"
    t.string "currency_code"
    t.string "currency_name"
    t.string "currency_symbol"
    t.string "language_iso639"
    t.string "language_name"
    t.string "language_native_name"
    t.string "image"
    t.string "date_utc"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "description"
    t.boolean "is_porcentage"
    t.integer "value"
    t.integer "quantity"
    t.bigint "cargapp_model_id", null: false
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cargapp_model_id"], name: "index_coupons_on_cargapp_model_id"
    t.index ["user_id"], name: "index_coupons_on_user_id"
  end

  create_table "document_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "document_id"
    t.bigint "document_type_id", null: false
    t.string "file"
    t.bigint "statu_id", null: false
    t.bigint "user_id", null: false
    t.date "expire_date"
    t.boolean "approved"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_type_id"], name: "index_documents_on_document_type_id"
    t.index ["statu_id"], name: "index_documents_on_statu_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "code"
    t.string "url"
    t.string "url_pro"
    t.string "url_dev"
    t.string "email"
    t.string "username"
    t.string "password"
    t.string "phone"
    t.string "pin"
    t.string "token"
    t.string "app_id"
    t.string "client_id"
    t.string "api_key"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "load_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "icon"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.bigint "user_id", null: false
    t.string "value"
    t.bigint "cargapp_model_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cargapp_model_id"], name: "index_parameters_on_cargapp_model_id"
    t.index ["user_id"], name: "index_parameters_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "cargapp_model_id", null: false
    t.string "action"
    t.string "method"
    t.boolean "allow"
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cargapp_model_id"], name: "index_permissions_on_cargapp_model_id"
    t.index ["role_id"], name: "index_permissions_on_role_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "firt_name"
    t.string "last_name"
    t.string "avatar"
    t.string "phone"
    t.string "document_id"
    t.bigint "document_type_id", null: false
    t.bigint "user_id", null: false
    t.date "birth_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_type_id"], name: "index_profiles_on_document_type_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_roles_on_code"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.bigint "country_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "status", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "cargapp_model_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cargapp_model_id"], name: "index_status_on_cargapp_model_id"
    t.index ["user_id"], name: "index_status_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "image"
    t.string "media"
    t.bigint "statu_id", null: false
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["statu_id"], name: "index_tickets_on_statu_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "user_challenges", force: :cascade do |t|
    t.integer "position"
    t.integer "point"
    t.bigint "challenge_id", null: false
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["challenge_id"], name: "index_user_challenges_on_challenge_id"
    t.index ["user_id"], name: "index_user_challenges_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "user_id", null: false
    t.bigint "admin_id"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_id"], name: "index_user_roles_on_admin_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "icon"
    t.text "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.integer "model_year"
    t.string "color"
    t.string "plate"
    t.string "chassis"
    t.string "owner_vehicle"
    t.bigint "vehicle_type_id", null: false
    t.bigint "owner_document_type_id"
    t.string "owner_document_id"
    t.bigint "user_id", null: false
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_document_type_id"], name: "index_vehicles_on_owner_document_type_id"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cargapp_integrations", "users"
  add_foreign_key "challenges", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "companies", "load_types"
  add_foreign_key "companies", "users"
  add_foreign_key "coupons", "cargapp_models"
  add_foreign_key "coupons", "users"
  add_foreign_key "documents", "document_types"
  add_foreign_key "documents", "status", column: "statu_id"
  add_foreign_key "documents", "users"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "parameters", "cargapp_models"
  add_foreign_key "parameters", "users"
  add_foreign_key "permissions", "cargapp_models"
  add_foreign_key "permissions", "roles"
  add_foreign_key "permissions", "users"
  add_foreign_key "profiles", "document_types"
  add_foreign_key "profiles", "users"
  add_foreign_key "states", "countries"
  add_foreign_key "status", "cargapp_models"
  add_foreign_key "status", "users"
  add_foreign_key "tickets", "status", column: "statu_id"
  add_foreign_key "tickets", "users"
  add_foreign_key "user_challenges", "challenges"
  add_foreign_key "user_challenges", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_types"
end
