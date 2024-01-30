# Categories
categories = Category.create([
  { name: "Chest", description: "Chest exercises", user_id: nil },
  { name: "Back", description: "Back exercises", user_id: nil },
  { name: "Legs", description: "Leg exercises", user_id: nil },
  { name: "Shoulders", description: "Shoulder exercises", user_id: nil },
  { name: "Biceps", description: "Bicep exercises", user_id: nil },
  { name: "Triceps", description: "Tricep exercises", user_id: nil },
  { name: "Abs", description: "Core exercises", user_id: nil }
])

def find_category_id_by_name(categories, name)
  category = categories.detect { |c| c.name == name }
  category ? category.id : nil
end

# Exercise Types
ExerciseType.create([{ name: "Strength", description: "Weights and Reps" }])

# Exercises
Exercise.create([
  # Chest
  { name: "Bench Press", category_id: find_category_id_by_name(categories, "Chest"), exercise_type_id: 1, user_id: nil },
  { name: "Incline Bench Press", category_id: find_category_id_by_name(categories, "Chest"), exercise_type_id: 1, user_id: nil },
  { name: "Pectorial Flys", category_id: find_category_id_by_name(categories, "Chest"), exercise_type_id: 1, user_id: nil },
  # Back
  { name: "Pull Ups", category_id: find_category_id_by_name(categories, "Back"), exercise_type_id: 1, user_id: nil },
  { name: "Deadlift", category_id: find_category_id_by_name(categories, "Back"), exercise_type_id: 1, user_id: nil },
  { name: "Rows", category_id: find_category_id_by_name(categories, "Back"), exercise_type_id: 1, user_id: nil },
  { name: "Lat Pulldowns", category_id: find_category_id_by_name(categories, "Back"), exercise_type_id: 1, user_id: nil },
  # Legs
  { name: "Squats", category_id: find_category_id_by_name(categories, "Legs"), exercise_type_id: 1, user_id: nil },
  { name: "Leg Press", category_id: find_category_id_by_name(categories, "Legs"), exercise_type_id: 1, user_id: nil },
  { name: "Lunges", category_id: find_category_id_by_name(categories, "Legs"), exercise_type_id: 1, user_id: nil },
  { name: "Calf Raises", category_id: find_category_id_by_name(categories, "Legs"), exercise_type_id: 1, user_id: nil },
  { name: "Hamstring Curls", category_id: find_category_id_by_name(categories, "Legs"), exercise_type_id: 1, user_id: nil },
  # Shoulders
  { name: "Shoulder Press", category_id: find_category_id_by_name(categories, "Shoulders"), exercise_type_id: 1, user_id: nil },
  { name: "Lateral Raises", category_id: find_category_id_by_name(categories, "Shoulders"), exercise_type_id: 1, user_id: nil },
  { name: "Front Raises", category_id: find_category_id_by_name(categories, "Shoulders"), exercise_type_id: 1, user_id: nil },
  # Biceps
  { name: "Bicep Curls", category_id: find_category_id_by_name(categories, "Biceps"), exercise_type_id: 1, user_id: nil },
  { name: "Hammer Curls", category_id: find_category_id_by_name(categories, "Biceps"), exercise_type_id: 1, user_id: nil },
  { name: "Preacher Curls", category_id: find_category_id_by_name(categories, "Biceps"), exercise_type_id: 1, user_id: nil },
  # Triceps
  { name: "Tricep Dips", category_id: find_category_id_by_name(categories, "Triceps"), exercise_type_id: 1, user_id: nil },
  { name: "Tricep Pushdown", category_id: find_category_id_by_name(categories, "Triceps"), exercise_type_id: 1, user_id: nil },
  { name: "Skullcrushers", category_id: find_category_id_by_name(categories, "Triceps"), exercise_type_id: 1, user_id: nil },
  # Abs
  { name: "Crunches", category_id: find_category_id_by_name(categories, "Abs"), exercise_type_id: 1, user_id: nil },
  { name: "Situps", category_id: find_category_id_by_name(categories, "Abs"), exercise_type_id: 1, user_id: nil },
  { name: "Russian Twists", category_id: find_category_id_by_name(categories, "Abs"), exercise_type_id: 1, user_id: nil },
  { name: "Plank", category_id: find_category_id_by_name(categories, "Abs"), exercise_type_id: 1, user_id: nil }
])
