# This file is auto-generated from the current state of the database. Instead of editing this file,
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100203090524) do

  create_table "builds", :force => true do |t|
    t.string   "commit_hash"
    t.datetime "committed_at"
    t.text     "commit_message"
    t.text     "changed_files"
    t.string   "author"
    t.text     "output"
    t.integer  "project_id"
    t.datetime "completed_at"
    t.boolean  "success"
    t.string   "branch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "working_dir"
    t.string   "clone_from"
    t.string   "excluded_branches"
    t.text     "commands"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

