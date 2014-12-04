class CreateUserFeelings < ActiveRecord::Migration
  def change
    create_table :user_feelings do |t|
      t.integer :user_id, :feeling_id
      t.timestamps      
    end
  end
end
