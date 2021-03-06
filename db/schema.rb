# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131208185554) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categorizations", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["lesson_id", "category_id"], :name => "index_categorizations_on_lesson_id_and_category_id", :unique => true
  add_index "categorizations", ["lesson_id"], :name => "index_categorizations_on_lesson_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "companies", ["name"], :name => "index_companies_on_name"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "languages", ["name"], :name => "index_languages_on_name"

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.decimal  "price"
    t.integer  "user_id"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "city"
    t.string   "state"
    t.string   "state_code"
    t.string   "postal_code"
    t.string   "country"
    t.string   "country_code"
  end

  add_index "lessons", ["latitude", "longitude"], :name => "index_lessons_on_latitude_and_longitude"
  add_index "lessons", ["user_id", "created_at"], :name => "index_lessons_on_user_id_and_created_at"
  add_index "lessons", ["user_id", "price"], :name => "index_lessons_on_user_id_and_price"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "sent"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "messages", ["recipient_id"], :name => "index_messages_on_recipient_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"
  add_index "messages", ["subject"], :name => "index_messages_on_subject"
  add_index "messages", ["user_id", "subject"], :name => "index_messages_on_user_id_and_subject"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "positions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "positions", ["company_id"], :name => "index_positions_on_company_id"
  add_index "positions", ["user_id", "company_id"], :name => "index_positions_on_user_id_and_company_id"
  add_index "positions", ["user_id"], :name => "index_positions_on_user_id"

  create_table "reviews", :force => true do |t|
    t.integer  "reviewed_id"
    t.integer  "reviewer_id"
    t.text     "content"
    t.integer  "rating"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reviews", ["rating"], :name => "index_reviews_on_rating"
  add_index "reviews", ["reviewed_id", "created_at"], :name => "index_reviews_on_reviewed_id_and_created_at"
  add_index "reviews", ["reviewed_id"], :name => "index_reviews_on_reviewed_id"
  add_index "reviews", ["reviewer_id", "created_at"], :name => "index_reviews_on_reviewer_id_and_created_at"
  add_index "reviews", ["reviewer_id"], :name => "index_reviews_on_reviewer_id"

  create_table "scholarships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "degree"
    t.string   "field"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scholarships", ["school_id"], :name => "index_scholarships_on_school_id"
  add_index "scholarships", ["user_id", "school_id"], :name => "index_scholarships_on_user_id_and_school_id"
  add_index "scholarships", ["user_id"], :name => "index_scholarships_on_user_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "schools", ["city"], :name => "index_schools_on_city"
  add_index "schools", ["country"], :name => "index_schools_on_country"
  add_index "schools", ["name"], :name => "index_schools_on_name"

  create_table "speakings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "speakings", ["language_id"], :name => "index_speakings_on_language_id"
  add_index "speakings", ["user_id", "language_id"], :name => "index_speakings_on_user_id_and_language_id", :unique => true
  add_index "speakings", ["user_id"], :name => "index_speakings_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "birthday"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "avatar"
    t.text     "summary"
    t.string   "gender"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["gender"], :name => "index_users_on_gender"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
