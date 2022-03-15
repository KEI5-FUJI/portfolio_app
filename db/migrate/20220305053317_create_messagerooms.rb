class CreateMessagerooms < ActiveRecord::Migration[6.1]
  def change
    create_table :messagerooms do |t|
      t.integer :owner_id, null: false
      t.integer :guest_id, null: false
      t.references :request, foreign_key: true, null: false
    end
    add_index :messagerooms, [:owner_id, :guest_id, :request_id], unique: true
  end
end
