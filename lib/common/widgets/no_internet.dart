import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetPage extends StatelessWidget {
  final double? lottiHeight;
  final double? lottiWeight;

  const NoInternetPage(
      {super.key,  this.lottiHeight, this.lottiWeight});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lotti/noImageLotti2.json',
          height: lottiHeight, width: lottiWeight);

  }
}
