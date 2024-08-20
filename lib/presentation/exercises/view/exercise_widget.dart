import 'package:flutter/material.dart';
import 'package:health_horizon_webos/presentation/exercises/controller/exercise_provider.dart';
import 'package:health_horizon_webos/presentation/exercises/view/exercise_card.dart';
import 'package:provider/provider.dart';

class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget({super.key});

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<ExerciseProvider>(context, listen: false);
    provider.getAllExercises();
    provider.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExerciseProvider>(
      builder: (context, provider, child) => Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Exercieses",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Showing ${provider.allExercises.length} results.........",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        onSelected: (value) {},
                        label: Text(
                          provider.categories[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  childAspectRatio: 16 / 14,
                  mainAxisSpacing: 20,
                ),
                itemCount: provider.allExercises.length,
                itemBuilder: (context, index) {
                  return ExerciseCardWidget(
                      exercise: provider.allExercises[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
