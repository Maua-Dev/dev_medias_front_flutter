import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Image(
        image: AssetImage(
            'lib/app/assets/images/dev_medias_logo.png'));
  }
}