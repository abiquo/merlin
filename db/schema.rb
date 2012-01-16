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

ActiveRecord::Schema.define(:version => 4) do

  create_table "accounts", :force => true do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "role"
  end

  create_table "dhcp_hosts", :force => true do |t|
    t.string "ip"
    t.string "port"
  end

  create_table "esx_hosts", :force => true do |t|
    t.string "ip"
    t.string "user"
    t.string "password"
    t.string "datastore"
  end

  create_table "vms", :force => true do |t|
    t.string  "name"
    t.string  "os_type"
    t.string  "size"
    t.string  "memory"
    t.string  "networks"
    t.string  "lease_name"
    t.string  "ip"
    t.string  "mask"
    t.string  "pxe_path"
    t.integer "cpus"
    t.integer "dhcp_host_id"
    t.integer "esx_host_id"
    t.boolean "deployed"
  end

end
