import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:golf_game_play/app/modules/subscription/controllers/make_payment_controller.dart';
import 'package:golf_game_play/app/modules/subscription/model/subscription_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_icons/app_icons.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/common/widgets/custom_button.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionAttributes subscriptionAttributes;
  final int index;
   SubscriptionCard({
    super.key, required this.subscriptionAttributes, required this.index,
  });
   final PaymentController _paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        //height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30).r,
          color: AppColors.primaryColor.withOpacity(0.7),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppIcons.crownIcon,
              ),
              Text(subscriptionAttributes.subscribeType=='superUser'?'Super User':'Basic User',
                style: AppStyles.h2(
                  family: "Schuyler",
                ),
              ),
              Divider(
                color: AppColors.dark2Color.withOpacity(0.2),
              ),

              ///=============>
              Column(
                  children: subscriptionAttributes.features!.map((feature) {
                return Row(
                  children: [
                    Icon(Icons.join_right),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        feature,
                        overflow: TextOverflow.clip,
                        style: AppStyles.h4(
                          family: "Schuyler",
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()),

              ///=============>
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    '\$${subscriptionAttributes.price}',
                    style: AppStyles.h1(
                      family: "Schuyler",
                    ),
                  ),
                  horizontalSpacing(8.w),
                  Text(
                    '/ ${subscriptionAttributes.typeOfSubscription}',
                    style: AppStyles.h3(
                      family: "Schuyler",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Obx(() {
                return CustomButton(
                  loading: _paymentController.isLoading[index]??false,
                  onTap: () async {
                    String myId = await PrefsHelper.getString('userId');
                    await _paymentController.makePayment(
                        subscriptionAttributes.price.toString(),
                        'USD',
                        subscriptionAttributes.sId,
                        myId,
                        subscriptionAttributes.subscribeType ?? '',
                        subscriptionAttributes.typeOfSubscription ?? '',
                       index
                    );
                  },
                  color: Colors.black,
                  text: 'Buy',
                  textStyle: AppStyles.h3(color: AppColors.white),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}