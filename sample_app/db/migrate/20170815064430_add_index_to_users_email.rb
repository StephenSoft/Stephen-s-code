class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
  	#添加郵件唯一性約束的遷移
  	add_index :users, :email, unique: true
  end
end
