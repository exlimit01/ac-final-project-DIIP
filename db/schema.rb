# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160714075531) do

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes",       default: 0
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "love_level", default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "hobbies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hobby_tags", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "hobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hobby_id"], name: "index_hobby_tags_on_hobby_id"
    t.index ["profile_id"], name: "index_hobby_tags_on_profile_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.integer  "mission_id"
    t.integer  "friendship_id"
    t.integer  "score",         default: 0
    t.text     "comment"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["friendship_id"], name: "index_interactions_on_friendship_id"
    t.index ["mission_id"], name: "index_interactions_on_mission_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.text     "content"
    t.integer  "unlock_level", default: 0
    t.integer  "popular",      default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["profile_id"], name: "index_photos_on_profile_id"
  end

  create_table "profession_tags", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "profession_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["profession_id"], name: "index_profession_tags_on_profession_id"
    t.index ["profile_id"], name: "index_profession_tags_on_profile_id"
  end

  create_table "professions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "nickname"
    t.integer  "age",                   default: 18
    t.text     "description"
    t.string   "facebook_link"
    t.integer  "facebook_access_level", default: 0
    t.string   "line_account"
    t.integer  "line_access_level",     default: 0
    t.string   "wechat_account"
    t.integer  "wechat_access_level",   default: 0
    t.integer  "location_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["location_id"], name: "index_profiles_on_location_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "qa_customs", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "loves",         default: 0
    t.integer  "friendship_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["friendship_id"], name: "index_qa_customs_on_friendship_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "unlock_level", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fb_uid"
    t.string   "fb_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["fb_uid"], name: "index_users_on_fb_uid"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
