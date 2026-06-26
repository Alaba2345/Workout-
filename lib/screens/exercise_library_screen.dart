import 'package:flutter/material.dart';
import '../data/exercise_library.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';
import '../widgets/exercise_card.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  late List<Exercise> _displayedExercises;
  String? _selectedMuscleGroup;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedExercises = ExerciseLibrary.all;
    _searchController.addListener(_filterExercises);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterExercises() {
    final query = _searchController.text;
    setState(() {
      if (query.isEmpty && _selectedMuscleGroup == null) {
        _displayedExercises = ExerciseLibrary.all;
      } else if (query.isNotEmpty) {
        _displayedExercises = ExerciseLibrary.search(query);
      } else if (_selectedMuscleGroup != null) {
        _displayedExercises =
            ExerciseLibrary.byMuscleGroup(_selectedMuscleGroup!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App Bar ────────────────────────────────
            SliverAppBar(
              backgroundColor: AppTheme.background,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppTheme.textPrimary,
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Exercise Library',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: false,
              pinned: true,
            ),

            // ── Search Bar ─────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppTheme.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Search exercises...',
                    hintStyle: const TextStyle(color: AppTheme.textSecondary),
                    filled: true,
                    fillColor: AppTheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppTheme.textSecondary,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: AppTheme.textSecondary,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _filterExercises();
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ),

            // ── Muscle Group Filter ────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMuscleGroup = null;
                          });
                          _filterExercises();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedMuscleGroup == null
                                ? AppTheme.accent
                                : AppTheme.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: _selectedMuscleGroup == null
                                  ? Colors.white
                                  : AppTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ...ExerciseLibrary.categories.map((category) {
                        final isSelected =
                            _selectedMuscleGroup == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMuscleGroup =
                                    isSelected ? null : category;
                              });
                              _filterExercises();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.accent
                                    : AppTheme.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),

            // ── Exercise List ─────────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final exercise = _displayedExercises[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ExerciseCard(
                        exercise: exercise,
                        onTap: () {
                          // TODO: Navigate to exercise details or add to workout
                        },
                      ),
                    );
                  },
                  childCount: _displayedExercises.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}