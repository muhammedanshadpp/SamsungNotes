import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/extensions/theme/light_darkthem.dart';
import 'package:flutter_application_1/first_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(
        deletedNotesNotifier: ValueNotifier([]),
      ),
      theme: lighttheme,
      darkTheme: darktheme,
      themeMode: ThemeMode.system,
    );
  }
}
