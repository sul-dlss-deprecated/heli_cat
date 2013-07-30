class CreatePurchaseOptions < ActiveRecord::Migration
  def change
    create_table :purchase_options do |t|
      t.belongs_to :item
      t.string     :make
      t.string     :model
      t.string     :description
      t.boolean    :active, default: true
      t.timestamps
    end
  end
end
