import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/to_buy_list_controller.dart';
import 'pages/home_page.dart';
import 'repositories/shared_preferences_repository.dart';
import 'shared/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ChangeNotifierProvider(
        create: (_) => ToBuyListController(
          localStorageRepository: SharedPreferenceRepository(),
        ),
        child: const HomePage(),
      ),
    );
  }
}
