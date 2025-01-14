import 'package:flutter/material.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.wifi_off,
                size: 100,
                color: AppColors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Sem conexão com a internet',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Verifique sua conexão e tente novamente.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
