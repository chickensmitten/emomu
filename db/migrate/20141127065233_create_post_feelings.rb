class CreatePostFeelings < ActiveRecord::Migration
  def change
    create_table :post_feelings do |t|
      t.integer :feeling_id, :post_id
      t.timestamps      
    end
  end
end
