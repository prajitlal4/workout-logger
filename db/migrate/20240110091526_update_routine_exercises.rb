class UpdateRoutineExercises < ActiveRecord::Migration[7.0]
  def change
    remove_column :routine_exercises, :name, :string
    remove_reference :routine_exercises, :category
    remove_reference :routine_exercises, :exercise_type
  end
end
