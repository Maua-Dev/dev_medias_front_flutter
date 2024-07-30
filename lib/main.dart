import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/view/add_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/edit_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevMédias',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins'
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/add': (context) => AddPage(title: "DevMédias"),
        '/edit': (context) => EditPage(title: "DevMédias"),
      },
      // home: const HomePage(title: 'DevMédias'),
    );
  }
}

