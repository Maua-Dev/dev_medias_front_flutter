import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/view/add_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/edit_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/intro_page_view.dart';
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
      theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
      initialRoute: '/',
      routes: {
        '/': (_) => const IntroPage(),
        '/home': (_) => const HomePage(),
        '/add': (_) => const AddPage(),
        '/edit': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return EditPage(course: args['course']);
        },
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/add') {
      //     return PageRouteBuilder(
      //       settings: settings,
      //       pageBuilder: (context, animation, secondaryAnimation) => const AddPage(),
      //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //         const begin = Offset(0.0, 1.0);
      //         const end = Offset.zero;
      //         const curve = Curves.ease;

      //         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      //         return SlideTransition(
      //           position: animation.drive(tween),
      //           child: child,
      //         );
      //       },
      //     );
      //   }
      // },
      // home: const HomePage(title: 'DevMédias'),
    );
  }
}
