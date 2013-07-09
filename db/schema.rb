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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130708194551) do

  create_table "items", force: true do |t|
    t.string   "department"
    t.string   "location"
    t.string   "user"
    t.string   "make"
    t.string   "model"
    t.string   "barcode"
    t.string   "serial"
    t.string   "express_service_code"
    t.string   "computer_name"
    t.string   "ip_address"
    t.string   "wireless_mac"
    t.string   "wired_mac"
    t.string   "swap_cycle"
    t.date     "warranty_start"
    t.text     "notes"
    t.boolean  "received",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_options", force: true do |t|
    t.string   "make"
    t.string   "model"
    t.string   "description"
    t.boolean  "active",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
