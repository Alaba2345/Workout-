import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/exercise.dart';
import 'package:uuid/uuid.dart';

class WorkoutProvider extends ChangeNotifier {
  Workout? _activeWorkout;
  bool _isRunning = false;

  Workout? get activeWorkout => _activeWorkout;
  bool get isRunning => _isRunning;

  void startWorkout(String name) {
    _activeWorkout = Workout(name: name);
    _isRunning = true;
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    if (_activeWorkout == null) return;
    _activeWorkout!.exercises.add(
      WorkoutExercise(
        exerciseId: exercise.id,
        exerciseName: exercise.name,
      ),
    );
    notifyListeners();
  }

  void addSet(String exerciseId) {
    final ex = _activeWorkout?.exercises
        .firstWhere((e) => e.id == exerciseId);
    if (ex == null) return;
    // Copy last set values as default for next set
    final last = ex.sets.isNotEmpty ? ex.sets.last : null;
    ex.sets.add(WorkoutSet(
      weight: last?.weight ?? 0,
      reps: last?.reps ?? 0,
    ));
    notifyListeners();
  }

  void removeSet(String exerciseId, String setId) {
    final ex = _activeWorkout?.exercises
        .firstWhere((e) => e.id == exerciseId);
    if (ex == null || ex.sets.length <= 1) return;
    ex.sets.removeWhere((s) => s.id == setId);
    notifyListeners();
  }

  void updateSet(String exerciseId, String setId,
      {double? weight, int? reps}) {
    final ex = _activeWorkout?.exercises
        .firstWhere((e) => e.id == exerciseId);
    if (ex == null) return;
    final set = ex.sets.firstWhere((s) => s.id == setId);
    if (weight != null) set.weight = weight;
    if (reps != null) set.reps = reps;
    notifyListeners();
  }

  void toggleSetComplete(String exerciseId, String setId) {
    final ex = _activeWorkout?.exercises
        .firstWhere((e) => e.id == exerciseId);
    if (ex == null) return;
    final set = ex.sets.firstWhere((s) => s.id == setId);
    set.completed = !set.completed;
    notifyListeners();
  }

  void removeExercise(String exerciseId) {
    _activeWorkout?.exercises.removeWhere((e) => e.id == exerciseId);
    notifyListeners();
  }

  Workout? finishWorkout() {
    if (_activeWorkout == null) return null;
    _activeWorkout!.endTime = DateTime.now();
    final finished = _activeWorkout;
    _activeWorkout = null;
    _isRunning = false;
    notifyListeners();
    return finished;
  }

  void cancelWorkout() {
    _activeWorkout = null;
    _isRunning = false;
    notifyListeners();
  }

  int get completedSets {
    return _activeWorkout?.exercises.fold(
          0,
          (sum, ex) =>
              sum + ex.sets.where((s) => s.completed).length,
        ) ??
        0;
  }

  int get totalSets {
    return _activeWorkout?.exercises
            .fold(0, (sum, ex) => sum + ex.sets.length) ??
        0;
  }
}