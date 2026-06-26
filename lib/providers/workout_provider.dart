import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/exercise.dart';

class WorkoutProvider extends ChangeNotifier {
  Workout? _activeWorkout;
  bool _isRunning = false;
  final List<Workout> _history = [];

  // ── Getters ───────────────────────────────────────────
  Workout? get activeWorkout => _activeWorkout;
  bool get isRunning => _isRunning;
  List<Workout> get history => List.unmodifiable(_history);

  // ── Active Workout ────────────────────────────────────
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
    final finished = _activeWorkout!;
    _history.insert(0, finished); // newest first
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

  void deleteWorkout(String workoutId) {
    _history.removeWhere((w) => w.id == workoutId);
    notifyListeners();
  }

  // ── Progress / Stats ──────────────────────────────────

  int get completedSets {
    return _activeWorkout?.exercises.fold(
          0,
          (sum, ex) => sum + ex.sets.where((s) => s.completed).length,
        ) ??
        0;
  }

  int get totalSets {
    return _activeWorkout?.exercises
            .fold(0, (sum, ex) => sum + ex.sets.length) ??
        0;
  }

  // Total workouts this week
  int get weeklyWorkouts {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return _history
        .where((w) => w.startTime.isAfter(weekStart))
        .length;
  }

  // Total volume this week (kg)
  int get weeklyVolume {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return _history
        .where((w) => w.startTime.isAfter(weekStart))
        .fold(0, (sum, w) => sum + w.totalVolume);
  }

  // Total workout time this week
  Duration get weeklyTime {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final workouts =
        _history.where((w) => w.startTime.isAfter(weekStart));
    return workouts.fold(Duration.zero,
        (sum, w) => sum + w.duration);
  }

  // Volume per day for last 7 days (for chart)
  List<Map<String, dynamic>> get last7DaysVolume {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      final dayWorkouts = _history.where((w) =>
          w.startTime.year == day.year &&
          w.startTime.month == day.month &&
          w.startTime.day == day.day);
      final volume =
          dayWorkouts.fold(0, (sum, w) => sum + w.totalVolume);
      return {
        'date': day,
        'volume': volume,
        'hasWorkout': dayWorkouts.isNotEmpty,
      };
    });
  }

  // Personal records: best set per exercise (highest weight)
  Map<String, double> get personalRecords {
    final Map<String, double> records = {};
    for (final workout in _history) {
      for (final ex in workout.exercises) {
        for (final set in ex.sets) {
          if (set.weight > 0) {
            final current = records[ex.exerciseName] ?? 0;
            if (set.weight > current) {
              records[ex.exerciseName] = set.weight;
            }
          }
        }
      }
    }
    return records;
  }

  // Volume history per exercise (for progress chart)
  List<Map<String, dynamic>> volumeHistory(String exerciseName) {
    final List<Map<String, dynamic>> data = [];
    for (final workout in _history.reversed) {
      final ex = workout.exercises
          .where((e) => e.exerciseName == exerciseName)
          .toList();
      if (ex.isEmpty) continue;
      final volume = ex.first.sets
          .fold(0.0, (sum, s) => sum + s.weight * s.reps);
      data.add({'date': workout.startTime, 'volume': volume});
    }
    return data;
  }

  // All unique exercise names across history
  List<String> get allTrackedExercises {
    final Set<String> names = {};
    for (final w in _history) {
      for (final ex in w.exercises) {
        names.add(ex.exerciseName);
      }
    }
    return names.toList()..sort();
  }

  // Seed demo data so the charts look great on first launch
  void seedDemoData() {
    if (_history.isNotEmpty) return;
    final now = DateTime.now();

    final workouts = [
      _makeWorkout('Push Day', now.subtract(const Duration(days: 6)),
          [('Bench Press', [(80.0, 8), (85.0, 6), (85.0, 5)])]),
      _makeWorkout('Pull Day', now.subtract(const Duration(days: 5)),
          [('Barbell Row', [(60.0, 10), (65.0, 8), (70.0, 6)])]),
      _makeWorkout('Leg Day', now.subtract(const Duration(days: 4)),
          [('Back Squat', [(100.0, 8), (105.0, 6), (110.0, 5)])]),
      _makeWorkout('Push Day', now.subtract(const Duration(days: 2)),
          [('Bench Press', [(82.5, 8), (87.5, 6), (90.0, 4)])]),
      _makeWorkout('Pull Day', now.subtract(const Duration(days: 1)),
          [('Barbell Row', [(65.0, 10), (70.0, 8), (72.5, 6)])]),
    ];

    _history.addAll(workouts);
    notifyListeners();
  }

  Workout _makeWorkout(
    String name,
    DateTime date,
    List<(String, List<(double, int)>)> exerciseData,
  ) {
    final exercises = exerciseData.map((data) {
      final (exName, setData) = data;
      final sets = setData
          .map((s) => WorkoutSet(weight: s.$1, reps: s.$2, completed: true))
          .toList();
      return WorkoutExercise(
        exerciseId: exName.toLowerCase().replaceAll(' ', '_'),
        exerciseName: exName,
        sets: sets,
      );
    }).toList();

    return Workout(
      name: name,
      startTime: date,
      endTime: date.add(const Duration(minutes: 55)),
      exercises: exercises,
    );
  }
}