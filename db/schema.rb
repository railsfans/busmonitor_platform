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

ActiveRecord::Schema.define(:version => 20141130011528) do

  create_table "buses", :force => true do |t|
    t.string   "updatetime"
    t.integer  "updatecount"
    t.integer  "totalcount"
    t.string   "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "never_online_count"
    t.integer  "pass_48h_never_online_count"
    t.float    "pass_24h_update_rate"
    t.float    "pass_48h_update_rate"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.string   "rootpasswd"
    t.string   "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "online_state"
    t.string   "online_time"
    t.string   "offline_time"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stations", :force => true do |t|
    t.string   "station_name"
    t.string   "station_num"
    t.string   "online_state"
    t.string   "online_time"
    t.string   "offline_time"
    t.string   "offline_count"
    t.string   "update_percent"
    t.string   "update_speed"
    t.string   "sync_state"
    t.string   "service_state"
    t.string   "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "station_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "phone"
    t.boolean  "sex"
    t.string   "realname"
    t.string   "loginip"
    t.string   "logintime"
    t.string   "logincity"
    t.string   "new_token"
  end

end
