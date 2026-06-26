import '../models/exercise.dart';

class ExerciseLibrary {
  static const List<Exercise> all = [
    // ── CHEST ──────────────────────────────────────────
    Exercise(
      id: 'bench_press',
      name: 'Bench Press',
      category: 'Strength',
      muscleGroup: 'Chest',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'The king of chest exercises. Builds mass and strength.',
      instructions: [
        'Lie flat on bench, grip bar slightly wider than shoulder-width',
        'Unrack bar and lower slowly to mid-chest',
        'Press back up explosively to starting position',
        'Keep feet flat, back slightly arched, shoulders retracted',
      ],
    ),
    Exercise(
      id: 'incline_bench',
      name: 'Incline Bench Press',
      category: 'Strength',
      muscleGroup: 'Chest',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'Targets the upper chest for a fuller look.',
      instructions: [
        'Set bench to 30–45 degree incline',
        'Grip bar slightly wider than shoulders',
        'Lower bar to upper chest with control',
        'Press back up fully extending arms',
      ],
    ),
    Exercise(
      id: 'push_up',
      name: 'Push Up',
      category: 'Bodyweight',
      muscleGroup: 'Chest',
      equipment: 'None',
      difficulty: 'beginner',
      description: 'Classic bodyweight chest builder.',
      instructions: [
        'Start in high plank position, hands shoulder-width apart',
        'Lower chest to just above the floor',
        'Push back up in one controlled motion',
        'Keep core tight and body straight throughout',
      ],
    ),
    Exercise(
      id: 'dumbbell_fly',
      name: 'Dumbbell Fly',
      category: 'Isolation',
      muscleGroup: 'Chest',
      equipment: 'Dumbbell',
      difficulty: 'beginner',
      description: 'Stretches and isolates the chest for definition.',
      instructions: [
        'Lie on flat bench, dumbbells above chest',
        'Lower arms out in wide arc until you feel a stretch',
        'Bring dumbbells back together at top',
        'Maintain slight bend in elbows throughout',
      ],
    ),
    Exercise(
      id: 'cable_crossover',
      name: 'Cable Crossover',
      category: 'Isolation',
      muscleGroup: 'Chest',
      equipment: 'Cable Machine',
      difficulty: 'intermediate',
      description: 'Cable tension isolates the chest through full range.',
      instructions: [
        'Stand between two high cable pulleys',
        'Grab handles and step forward slightly',
        'Bring handles together in a crossing arc',
        'Squeeze chest at the bottom, return slowly',
      ],
    ),

    // ── BACK ───────────────────────────────────────────
    Exercise(
      id: 'deadlift',
      name: 'Deadlift',
      category: 'Strength',
      muscleGroup: 'Back',
      equipment: 'Barbell',
      difficulty: 'advanced',
      description: 'The most complete strength movement. Total body.',
      instructions: [
        'Stand with bar over mid-foot, hip-width stance',
        'Hinge at hips, grip just outside legs',
        'Brace core, chest up, pull bar close to body',
        'Lock out hips and knees at the top',
      ],
    ),
    Exercise(
      id: 'pull_up',
      name: 'Pull Up',
      category: 'Bodyweight',
      muscleGroup: 'Back',
      equipment: 'Pull-up Bar',
      difficulty: 'intermediate',
      description: 'Best bodyweight back exercise for width and strength.',
      instructions: [
        'Hang from bar with overhand grip, arms fully extended',
        'Pull chest toward bar, leading with elbows',
        'Lower with full control to starting position',
        'Avoid swinging or kipping',
      ],
    ),
    Exercise(
      id: 'barbell_row',
      name: 'Barbell Row',
      category: 'Strength',
      muscleGroup: 'Back',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'Builds back thickness and strength.',
      instructions: [
        'Hinge forward 45 degrees, grip bar shoulder-width',
        'Pull bar to lower chest, leading with elbows',
        'Squeeze shoulder blades together at top',
        'Lower with control, keeping back flat',
      ],
    ),
    Exercise(
      id: 'lat_pulldown',
      name: 'Lat Pulldown',
      category: 'Strength',
      muscleGroup: 'Back',
      equipment: 'Cable Machine',
      difficulty: 'beginner',
      description: 'Great for building lat width for beginners.',
      instructions: [
        'Sit at cable machine, grip bar wider than shoulders',
        'Lean back slightly and pull bar to upper chest',
        'Squeeze lats at the bottom',
        'Return bar slowly with arms fully extended',
      ],
    ),
    Exercise(
      id: 'seated_cable_row',
      name: 'Seated Cable Row',
      category: 'Strength',
      muscleGroup: 'Back',
      equipment: 'Cable Machine',
      difficulty: 'beginner',
      description: 'Excellent for back thickness and posture.',
      instructions: [
        'Sit with feet on platform, knees slightly bent',
        'Pull handle to lower abdomen, elbows tight to body',
        'Squeeze shoulder blades together',
        'Extend arms fully between each rep',
      ],
    ),

    // ── SHOULDERS ──────────────────────────────────────
    Exercise(
      id: 'overhead_press',
      name: 'Overhead Press',
      category: 'Strength',
      muscleGroup: 'Shoulders',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'The shoulder mass builder.',
      instructions: [
        'Stand with bar at shoulder height, grip shoulder-width',
        'Press bar directly overhead, arms fully extended',
        'Lower back to shoulders with control',
        'Keep core braced, avoid excessive back arch',
      ],
    ),
    Exercise(
      id: 'lateral_raise',
      name: 'Lateral Raise',
      category: 'Isolation',
      muscleGroup: 'Shoulders',
      equipment: 'Dumbbell',
      difficulty: 'beginner',
      description: 'Builds shoulder width for a V-taper look.',
      instructions: [
        'Stand holding dumbbells at sides',
        'Raise arms out to sides to shoulder height',
        'Lead with elbows, pinky slightly higher than thumb',
        'Lower slowly, maintaining tension',
      ],
    ),
    Exercise(
      id: 'face_pull',
      name: 'Face Pull',
      category: 'Isolation',
      muscleGroup: 'Shoulders',
      equipment: 'Cable Machine',
      difficulty: 'beginner',
      description: 'Builds rear delts and protects shoulders.',
      instructions: [
        'Set cable to face height with rope attachment',
        'Pull rope toward face, elbows flaring out',
        'External rotate at the end of movement',
        'Return slowly to full extension',
      ],
    ),

    // ── LEGS ───────────────────────────────────────────
    Exercise(
      id: 'squat',
      name: 'Back Squat',
      category: 'Strength',
      muscleGroup: 'Legs',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'The king of all exercises. Total leg development.',
      instructions: [
        'Bar on upper traps, feet shoulder-width apart',
        'Break at hips and knees simultaneously',
        'Descend until thighs are parallel to floor',
        'Drive through heels to stand, chest up throughout',
      ],
    ),
    Exercise(
      id: 'leg_press',
      name: 'Leg Press',
      category: 'Strength',
      muscleGroup: 'Legs',
      equipment: 'Machine',
      difficulty: 'beginner',
      description: 'Safe heavy leg loading without spinal stress.',
      instructions: [
        'Sit in machine, feet shoulder-width on platform',
        'Lower platform until 90-degree knee angle',
        'Press through heels to starting position',
        'Never lock out knees at the top',
      ],
    ),
    Exercise(
      id: 'romanian_deadlift',
      name: 'Romanian Deadlift',
      category: 'Strength',
      muscleGroup: 'Legs',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'Best hamstring exercise for strength and size.',
      instructions: [
        'Stand with bar at hip height, slight knee bend',
        'Hinge at hips, sliding bar down thighs',
        'Feel deep hamstring stretch at the bottom',
        'Drive hips forward to return to start',
      ],
    ),
    Exercise(
      id: 'lunges',
      name: 'Lunges',
      category: 'Strength',
      muscleGroup: 'Legs',
      equipment: 'Dumbbell',
      difficulty: 'beginner',
      description: 'Builds legs and improves balance and coordination.',
      instructions: [
        'Stand with dumbbells at sides',
        'Step forward and lower back knee toward ground',
        'Front thigh should be parallel to floor',
        'Push off front foot to return to start',
      ],
    ),
    Exercise(
      id: 'calf_raise',
      name: 'Calf Raise',
      category: 'Isolation',
      muscleGroup: 'Legs',
      equipment: 'Machine',
      difficulty: 'beginner',
      description: 'Builds calf size and definition.',
      instructions: [
        'Stand on edge of step or calf raise platform',
        'Lower heels below platform level',
        'Rise up on toes as high as possible',
        'Pause at the top, lower slowly',
      ],
    ),

    // ── ARMS ───────────────────────────────────────────
    Exercise(
      id: 'barbell_curl',
      name: 'Barbell Curl',
      category: 'Isolation',
      muscleGroup: 'Arms',
      equipment: 'Barbell',
      difficulty: 'beginner',
      description: 'The most effective bicep mass builder.',
      instructions: [
        'Stand with underhand grip, hands shoulder-width',
        'Curl bar toward shoulders, keeping elbows fixed',
        'Squeeze biceps at the top',
        'Lower fully to stretch biceps at bottom',
      ],
    ),
    Exercise(
      id: 'tricep_pushdown',
      name: 'Tricep Pushdown',
      category: 'Isolation',
      muscleGroup: 'Arms',
      equipment: 'Cable Machine',
      difficulty: 'beginner',
      description: 'Isolates triceps for size and definition.',
      instructions: [
        'Stand at high cable, grip bar overhand',
        'Keep elbows at sides, push bar down to full extension',
        'Squeeze triceps at the bottom',
        'Return slowly, upper arms stay still',
      ],
    ),
    Exercise(
      id: 'hammer_curl',
      name: 'Hammer Curl',
      category: 'Isolation',
      muscleGroup: 'Arms',
      equipment: 'Dumbbell',
      difficulty: 'beginner',
      description: 'Builds bicep peak and forearm thickness.',
      instructions: [
        'Hold dumbbells with neutral grip (palms facing in)',
        'Curl toward shoulders without rotating wrists',
        'Keep elbows fixed at sides',
        'Lower fully between each rep',
      ],
    ),
    Exercise(
      id: 'skull_crusher',
      name: 'Skull Crusher',
      category: 'Isolation',
      muscleGroup: 'Arms',
      equipment: 'Barbell',
      difficulty: 'intermediate',
      description: 'Heavy tricep isolation for serious arm size.',
      instructions: [
        'Lie on bench, hold bar above chest, arms extended',
        'Lower bar toward forehead by bending only at elbows',
        'Press back up to starting position',
        'Keep upper arms vertical throughout',
      ],
    ),

    // ── CORE ───────────────────────────────────────────
    Exercise(
      id: 'plank',
      name: 'Plank',
      category: 'Core',
      muscleGroup: 'Core',
      equipment: 'None',
      difficulty: 'beginner',
      description: 'Foundation core stability exercise.',
      instructions: [
        'Forearms on ground, elbows under shoulders',
        'Body straight from head to heels',
        'Brace core and squeeze glutes',
        'Hold for time without sagging hips',
      ],
    ),
    Exercise(
      id: 'cable_crunch',
      name: 'Cable Crunch',
      category: 'Core',
      muscleGroup: 'Core',
      equipment: 'Cable Machine',
      difficulty: 'beginner',
      description: 'Weighted ab training for visible definition.',
      instructions: [
        'Kneel at cable machine with rope attachment',
        'Crunch elbows toward knees, rounding spine',
        'Hold the contraction for a moment',
        'Return slowly, maintaining tension',
      ],
    ),
    Exercise(
      id: 'hanging_leg_raise',
      name: 'Hanging Leg Raise',
      category: 'Core',
      muscleGroup: 'Core',
      equipment: 'Pull-up Bar',
      difficulty: 'intermediate',
      description: 'Builds lower abs and hip flexor strength.',
      instructions: [
        'Hang from pull-up bar, arms fully extended',
        'Raise legs to parallel or higher by curling hips',
        'Lower slowly without swinging',
        'Exhale on the way up, inhale down',
      ],
    ),
  ];

  static List<String> get categories =>
      all.map((e) => e.muscleGroup).toSet().toList()..sort();

  static List<Exercise> byMuscleGroup(String group) =>
      all.where((e) => e.muscleGroup == group).toList();

  static List<Exercise> search(String query) {
    final q = query.toLowerCase();
    return all
        .where((e) =>
            e.name.toLowerCase().contains(q) ||
            e.muscleGroup.toLowerCase().contains(q) ||
            e.equipment.toLowerCase().contains(q))
        .toList();
  }
}