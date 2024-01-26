class ModifyCategoriesTable < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :user, index: true, foreign_key: true
    remove_reference :categories, :group, index: true, foreign_key: true
  end
end
