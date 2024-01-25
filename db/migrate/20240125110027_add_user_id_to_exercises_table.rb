class AddUserIdToExercisesTable < ActiveRecord::Migration[7.0]
  def change
    remove_reference :exercises, :group, index: true, foreign_key: true
    add_reference :exercises, :user, index: true, foreign_key: true
  end
end
