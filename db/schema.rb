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

ActiveRecord::Schema.define(:version => 20160801051617) do

  create_table "child_drugs", :force => true do |t|
    t.string   "user_id"
    t.integer  "child_id"
    t.string   "drug_name"
    t.string   "amount_left"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "dosage"
    t.string   "frequency"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "child_todays", :force => true do |t|
    t.string   "user_id"
    t.integer  "child_id"
    t.string   "drug_name"
    t.boolean  "should_take_today"
    t.boolean  "has_taken_today"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "children", :force => true do |t|
    t.string   "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "child_id"
    t.string   "phone"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "relation_type"
  end

  add_index "children", ["child_id"], :name => "index_children_on_child_id"

  create_table "drug_infos", :force => true do |t|
    t.string   "drug_name"
    t.string   "side_effects"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["user_id"], :name => "index_users_on_user_id"

end
