class Exercise {
  final String id;
  final String name;
  final String category;
  final String muscleGroup;
  final String equipment;
  final String difficulty; // beginner, intermediate, advanced
  final String description;
  final List<String> instructions;

  const Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.muscleGroup,
    required this.equipment,
    required this.difficulty,
    required this.description,
    required this.instructions,
  });
}