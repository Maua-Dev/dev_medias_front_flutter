import 'package:flutter/material.dart';

class CommunityLogo extends StatelessWidget {
  const CommunityLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(
            'lib/app/assets/images/dev_logo.png'));
  }
}