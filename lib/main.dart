import 'package:api_integration_3/controller/home_screen_controller.dart';
import 'package:api_integration_3/controller/news_detail_screen_controller.dart';
import 'package:api_integration_3/controller/search_screen_controller.dart';
import 'package:api_integration_3/model/save_screen_model/save_model.dart';

import 'package:api_integration_3/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox<SaveModel>('newsBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeScreenController(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchScreenController(),
          ),
          ChangeNotifierProvider(
            create: (context) => NewsDetailScreenController(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}
