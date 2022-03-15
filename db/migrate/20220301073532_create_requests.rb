class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :request_name
      t.boolean :is_solved?, null: false, default: false
      t.string :reward
      t.references :user, foreign_key: true,  null: false
      t.timestamps
    end
  end
end
