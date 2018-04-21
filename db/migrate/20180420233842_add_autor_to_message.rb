class AddAutorToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :autor, :string
  end
end
