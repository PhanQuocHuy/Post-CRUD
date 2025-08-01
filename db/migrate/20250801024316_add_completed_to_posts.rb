class AddCompletedToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :completed, :boolean
  end
end
