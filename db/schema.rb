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

ActiveRecord::Schema.define(:version => 20110927175355) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "access_secret"
  end

  create_table "awards", :force => true do |t|
    t.string   "award"
    t.date     "award_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "career_users", :force => true do |t|
    t.integer  "career_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "careers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "onet_code"
    t.string   "api_safe_onet_code"
  end

  create_table "certifications", :force => true do |t|
    t.string   "name"
    t.string   "institution"
    t.date     "date_acquired"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "linkedin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "long"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "educations", :force => true do |t|
    t.string   "school_name"
    t.string   "degree"
    t.string   "study_field"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "activities"
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industry_lookups", :force => true do |t|
    t.integer  "industry_id"
    t.string   "onet_code"
    t.string   "occupation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_histories", :force => true do |t|
    t.string   "org_name"
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "job_searches", :force => true do |t|
    t.string   "keyword"
    t.string   "location"
    t.float    "lat"
    t.float    "long"
    t.boolean  "user_saved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "search_params"
  end

  create_table "job_searches_jobs", :force => true do |t|
    t.integer  "job_search_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_searches_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_search_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_users", :force => true do |t|
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.date     "date_acquired"
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.integer  "company_id"
    t.text     "snippet"
    t.string   "job_source"
  end

  create_table "languages", :force => true do |t|
    t.string   "language"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "location"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.string   "skill"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", :force => true do |t|
    t.string   "training"
    t.date     "training_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "goal"
    t.string   "relocate"
    t.string   "desired_salary"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "family"
    t.date     "dob"
    t.string   "military_status"
    t.string   "service_branch"
    t.string   "moc"
    t.string   "rank"
    t.string   "disability"
    t.string   "security_clearance"
    t.string   "unit"
    t.text     "resume"
    t.text     "privacy_settings"
    t.text     "email_settings"
    t.string   "name"
    t.string   "twitter"
    t.string   "location"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wars", :force => true do |t|
    t.string   "war"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
