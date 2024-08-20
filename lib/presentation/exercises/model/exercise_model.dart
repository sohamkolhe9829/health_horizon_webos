class ExerciseModel {
  String? name;
  String? force;
  String? level;
  String? mechanic;
  String? equipment;
  List<String>? primaryMuscles;
  List<String>? secondaryMuscles;
  List<String>? instructions;
  String? category;
  List<String>? images;
  String? id;

  ExerciseModel({
    this.name,
    this.force,
    this.level,
    this.mechanic,
    this.equipment,
    this.primaryMuscles,
    this.secondaryMuscles,
    this.instructions,
    this.category,
    this.images,
    this.id,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      name: json['name'],
      force: json['force'],
      level: json['level'],
      mechanic: json['mechanic'],
      equipment: json['equipment'],
      primaryMuscles: List<String>.from(json['primaryMuscles']),
      secondaryMuscles: List<String>.from(json['secondaryMuscles']),
      instructions: List<String>.from(json['instructions']),
      category: json['category'],
      images: List<String>.from(json['images']),
      id: json['id'],
    );
  }
}
