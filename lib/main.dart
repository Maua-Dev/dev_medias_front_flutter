import 'package:dev_medias_front_flutter/app/view/add_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/edit_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/intro_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/loading_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/no_connection_page_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'DevMédias',
        theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: '/',
        routes: {
          '/': (_) => const LoadingPage(),
          '/first' : (_) => const IntroPage(),
          '/home': (_) => const HomePage(),
          '/add': (_) => const AddPage(),
          '/edit': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map;
            return EditPage(course: args['course']);
          },
          '/disconnected': (_) => const NoConnectionPage(),
      
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
      ),
    );
  }
}
