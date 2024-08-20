import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/presentation/exercises/model/exercise_model.dart';
import 'package:health_horizon_webos/presentation/videos/controller/video_provider.dart';
import 'package:health_horizon_webos/widgets/animated_images.dart';
import 'package:provider/provider.dart';

class ExerciseCardWidget extends StatelessWidget {
  ExerciseModel exercise;
  ExerciseCardWidget({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        openDialog(context);
      },
      child: Container(
        child: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) => Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  color: ConstantColor.secondaryColor,
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://health-horizon-backend.onrender.com/images/${exercise.images![0]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ConstantColor.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${exercise.name}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${exercise.category}",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openDialog(context) {
    showDialog(
      builder: (context) => AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          // width: MediaQuery.of(context).size.width / 1.5,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: exercise.images!.length == 1
                          ? CachedNetworkImage(
                              imageUrl:
                                  "https://health-horizon-backend.onrender.com/images/${exercise.images![0]}",
                              fit: BoxFit.cover,
                            )
                          : AnimatedImages(
                              imagePaths: exercise.images!,
                            )),
                ),
                SizedBox(height: 10),
                Text(
                  exercise.name!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  exercise.category! + " - " + exercise.level!,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text("Primary Muscles: ${List.generate(
                  exercise.primaryMuscles!.length,
                  (index) => exercise.primaryMuscles![index],
                ).join(", ")},"),
                SizedBox(height: 10),
                Text("Secondary Muscles: ${List.generate(
                  exercise.primaryMuscles!.length,
                  (index) => exercise.primaryMuscles![index],
                ).join(", ")},"),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: exercise.instructions!
                      .map((item) => ListTile(
                            leading: Icon(Icons.circle),
                            title: Text(item),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
      context: context,
    );
  }
}
