import 'package:health_horizon_webos/presentation/exercises/controller/exercise_provider.dart';
import 'package:health_horizon_webos/presentation/home/controller/home_provider.dart';
import 'package:health_horizon_webos/presentation/videos/controller/video_provider.dart';
import 'package:health_horizon_webos/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../presentation/chat/controller/chat_provider.dart';

List<SingleChildWidget> multiProviders = [
  //Home Provider
  ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
  //Chat Provider
  ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider()),
  //Auth Provider
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),

  //Video Provider
  ChangeNotifierProvider<VideoProvider>(create: (context) => VideoProvider()),
  //Exercise Provider
  ChangeNotifierProvider<ExerciseProvider>(
      create: (context) => ExerciseProvider()),
];
