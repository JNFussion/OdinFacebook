class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.bigint :requestor_id
      t.bigint :receiver_id
      t.index [:requestor_id, :receiver_id], :unique => true
      t.timestamps
    end
  end
end
