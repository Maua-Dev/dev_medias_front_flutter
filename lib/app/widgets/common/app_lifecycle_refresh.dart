import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/intro_page_controller.dart';
import 'package:flutter/material.dart';

/// Refaz o GET de disciplinas quando o app volta do background.
class AppLifecycleRefresh extends StatefulWidget {
  const AppLifecycleRefresh({super.key, required this.child});

  final Widget child;

  @override
  State<AppLifecycleRefresh> createState() => _AppLifecycleRefreshState();
}

class _AppLifecycleRefreshState extends State<AppLifecycleRefresh>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    if (!introPageController.loggedIn) return;
    coursesController.refreshAllSubjects();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
