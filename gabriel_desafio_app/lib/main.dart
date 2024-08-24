import 'package:flutter/material.dart';

import 'core/routes/routes.dart';
import 'core/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gabriel Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themeData,
      initialRoute: LOGIN,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
