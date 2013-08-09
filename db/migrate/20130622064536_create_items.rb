class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :department
      t.string  :location
      t.string  :user
      t.string  :make
      t.string  :model
      t.string  :barcode
      t.string  :serial
      t.string  :express_service_code # only for Dell computers
      t.string  :computer_name
      t.string  :ip_address
      t.string  :wireless_mac
      t.string  :wired_mac
      t.string  :swap_cycle
      t.date    :warranty_end
      t.text    :notes
      t.integer :swap_item
      t.boolean :purchased, default: false
      t.boolean :received, default: false
      t.timestamps
    end
  end
end
