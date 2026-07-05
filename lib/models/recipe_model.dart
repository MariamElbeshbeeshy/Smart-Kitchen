class Recipe {
  final String title;

  final List<String> ingredients;

  final List<String> steps;

  final int savedIngredients;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.savedIngredients,
  });
}
