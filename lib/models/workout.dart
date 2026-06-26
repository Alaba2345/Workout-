import 'package:uuid/uuid.dart';

class WorkoutSet {
  String id;
  double weight; // kg
  int reps;
  bool completed;

  WorkoutSet({
    String? id,
    this.weight = 0,
    this.reps = 0,
    this.completed = false,
  }) : id = id ?? const Uuid().v4();
}

class WorkoutExercise {
  String id;
  String exerciseId;
  String exerciseName;
  List<WorkoutSet> sets;
  String notes;

  WorkoutExercise({
    String? id,
    required this.exerciseId,
    required this.exerciseName,
    List<WorkoutSet>? sets,
    this.notes = '',
  })  : id = id ?? const Uuid().v4(),
        sets = sets ?? [WorkoutSet()];
}

class Workout {
  String id;
  String name;
  DateTime startTime;
  DateTime? endTime;
  List<WorkoutExercise> exercises;
  String notes;

  Workout({
    String? id,
    required this.name,
    DateTime? startTime,
    this.endTime,
    List<WorkoutExercise>? exercises,
    this.notes = '',
  })  : id = id ?? const Uuid().v4(),
        startTime = startTime ?? DateTime.now(),
        exercises = exercises ?? [];

  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  int get totalSets =>
      exercises.fold(0, (sum, ex) => sum + ex.sets.length);

  int get totalVolume => exercises.fold(
        0,
        (sum, ex) => sum +
            ex.sets.fold(
              0,
              (s, set) => s + (set.weight * set.reps).toInt(),
            ),
      );
}