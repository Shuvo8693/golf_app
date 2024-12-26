import 'package:flutter/material.dart';
import 'package:golf_game_play/common/app_images/app_images.dart';

class BackgroundImage extends StatelessWidget {
  final List<Widget> children;

  const BackgroundImage({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            AppImage.appBgImg,
            fit: BoxFit.fill,
          )),
          SafeArea(
              child: Stack(
            children: children,
          ))
        ],
      ),
    );
  }
}
