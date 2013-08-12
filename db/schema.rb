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

ActiveRecord::Schema.define(:version => 20130812191352) do

  create_table "courses", :force => true do |t|
    t.string   "subject"
    t.string   "season"
    t.integer  "seats"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.date     "starting_date"
  end

  create_table "dossier_comments", :force => true do |t|
    t.integer  "dossier_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "dossier_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "dossier_id"
  end

  create_table "dossiers", :force => true do |t|
    t.integer  "user_id"
    t.string   "tagline"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "phone_number"
    t.text     "city"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "blog"
    t.string   "github"
    t.string   "website"
    t.text     "other_links"
    t.text     "career"
    t.text     "purpose"
    t.text     "code_skills"
    t.text     "analytic_skills"
    t.text     "tidbits"
    t.string   "aasm_state"
    t.integer  "course_id"
    t.string   "skype"
    t.string   "gender"
    t.string   "codeschool_link"
    t.string   "treehouse_link"
    t.string   "nyc"
  end

  create_table "hashtags", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "dossier_id"
    t.string   "stage"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "interview_time"
  end

  create_table "scores", :force => true do |t|
    t.integer  "leadership"
    t.integer  "tech"
    t.integer  "passion"
    t.integer  "dossier_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_dossier_hashtags", :force => true do |t|
    t.integer  "hashtag_id"
    t.integer  "dossier_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.integer  "roles"
    t.string   "last_name"
    t.string   "gravatar_id"
  end

end
