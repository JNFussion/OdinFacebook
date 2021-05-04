class ChangeColumnsOfUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :birth_date, true
    change_column_null :users, :nationality, true
  end
end
