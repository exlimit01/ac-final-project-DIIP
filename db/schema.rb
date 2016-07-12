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

ActiveRecord::Schema.define(version: 20160721121926) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",     limit: 65535
    t.integer  "likes",                     default: 0
    t.integer  "profile_id"
    t.integer  "question_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["profile_id"], name: "index_answers_on_profile_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
  end

  create_table "friendships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "love_level", default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "status",     default: "none"
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "hobbies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hobby_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "profile_id"
    t.integer  "hobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hobby_id"], name: "index_hobby_tags_on_hobby_id", using: :btree
    t.index ["profile_id"], name: "index_hobby_tags_on_profile_id", using: :btree
  end

  create_table "interactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "mission_id"
    t.integer  "friendship_id"
    t.integer  "score",                       default: 0
    t.text     "comment",       limit: 65535
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "status",                      default: "request"
    t.integer  "room_id"
    t.integer  "co_status",                   default: 0
    t.index ["friendship_id"], name: "index_interactions_on_friendship_id", using: :btree
    t.index ["mission_id"], name: "index_interactions_on_mission_id", using: :btree
    t.index ["room_id"], name: "index_interactions_on_room_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< f03095b90ca0ab069286b09494146a0e90fd8938
  create_table "missions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",      limit: 65535
    t.integer  "unlock_level",               default: 0
    t.integer  "popular",                    default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
=======
  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "missions", force: :cascade do |t|
    t.text     "content"
    t.integer  "unlock_level", default: 0
    t.integer  "popular",      default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
>>>>>>> Add Model message
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["profile_id"], name: "index_photos_on_profile_id", using: :btree
  end

  create_table "profession_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "profile_id"
    t.integer  "profession_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["profession_id"], name: "index_profession_tags_on_profession_id", using: :btree
    t.index ["profile_id"], name: "index_profession_tags_on_profile_id", using: :btree
  end

  create_table "professions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "nickname"
    t.integer  "age",                                 default: 18
    t.text     "description",           limit: 65535
    t.string   "facebook_link"
    t.integer  "facebook_access_level",               default: 0
    t.string   "line_account"
    t.integer  "line_access_level",                   default: 0
    t.string   "wechat_account"
    t.integer  "wechat_access_level",                 default: 0
    t.integer  "location_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "sex"
    t.string   "relation"
    t.text     "aboutme",               limit: 65535
    t.index ["location_id"], name: "index_profiles_on_location_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "qa_customs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "question",      limit: 65535
    t.text     "answer",        limit: 65535
    t.integer  "loves",                       default: 0
    t.integer  "friendship_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["friendship_id"], name: "index_qa_customs_on_friendship_id", using: :btree
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",      limit: 65535
    t.integer  "unlock_level",               default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id1"
    t.integer  "user_id2"
    t.integer  "interaction_id1"
    t.integer  "interaction_id2"
    t.integer  "mission_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "active",          default: true
  end

  create_table "talks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535
    t.string   "author"
    t.integer  "room_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["room_id"], name: "index_talks_on_room_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.string   "authentication_token"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
