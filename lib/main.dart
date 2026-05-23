import 'package:dev_medias_front_flutter/app/widgets/common/app_lifecycle_refresh.dart';
import 'package:dev_medias_front_flutter/app/view/add_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/edit_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/intro_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/loading_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/no_connection_page_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => AppLifecycleRefresh(
        child: MaterialApp(
        title: 'DevMédias',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: '/',
        routes: {
          '/': (_) => const LoadingPage(),
          '/first': (_) => const IntroPage(),
          '/home': (_) => const HomePage(),
          '/add': (_) => const AddPage(),
          '/edit': (context) {
            final args = ModalRoute.of(context)?.settings.arguments as Map;
            return EditPage(course: args['course']);
          },
          '/disconnected': (_) => const NoConnectionPage(),
        },
        ),
      ),
    );
  }
}
