import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sponsore_web_controller.dart';

class SponsorWebView extends GetView<SponsoreWebController> {
  const SponsorWebView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SponsoreWebView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SponsoreWebView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
