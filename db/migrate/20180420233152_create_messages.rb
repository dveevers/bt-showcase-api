class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :channel
      t.datetime :created_at
      t.string :content

      t.timestamps
    end
  end
end
