class AddNameToStores < ActiveRecord::Migration[7.2]
  def change
    add_column :stores, :name, :string
  end
end
