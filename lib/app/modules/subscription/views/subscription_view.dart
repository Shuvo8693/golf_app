import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/subscription/model/subscription_model.dart';
import 'package:golf_game_play/app/modules/subscription/widgets/subscription_card_item.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends StatelessWidget {
  SubscriptionView({super.key});

  final SubscriptionController _subscriptionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription',
          style: AppStyles.h2(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              List<SubscriptionAttributes>  subscriptionAttributes =  _subscriptionController.subscriptionModel.value.data?.attributes??[];
              if(_subscriptionController.isLoading.value){
                return  Center(child: CircularProgressIndicator());
              } else if(subscriptionAttributes.isEmpty){
                return Center(child: Text('Subscription is not available',style: AppStyles.h4(),));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: subscriptionAttributes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                   final subscriptionAttributesIndex = subscriptionAttributes[index];
                    return SubscriptionCard(subscriptionAttributes: subscriptionAttributesIndex, index: index,);
                  },
                ),
              );
            }),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
