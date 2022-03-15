class AddRequestsDetailToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :request_detail, :string
  end
end
