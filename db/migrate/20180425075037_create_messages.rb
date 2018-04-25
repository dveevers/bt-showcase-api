class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :channel
      t.datetime :created_at
      t.string :content
      t.string :keyword
      t.string :created_by
      t.string :direction
      t.string :extra

      t.timestamps
    end
  end
end
