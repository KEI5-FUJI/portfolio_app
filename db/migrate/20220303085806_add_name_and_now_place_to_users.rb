class AddNameAndNowPlaceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :now_place, :string
  end
end
