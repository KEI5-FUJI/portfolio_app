class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :message
      t.references :user, foreign_key: true, null: false
      t.references :messageroom, foreign_key: true, null: false
      t.timestamps
    end
  end
end
