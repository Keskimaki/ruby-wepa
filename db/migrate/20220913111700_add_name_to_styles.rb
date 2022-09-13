class AddNameToStyles < ActiveRecord::Migration[7.0]
  def change
    add_column :styles, :name, :string
  end
end
