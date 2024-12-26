import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';
import 'package:golf_game_play/common/widgets/spacing.dart';

class ChallengeMatchPlayerDetails extends StatelessWidget {
  const ChallengeMatchPlayerDetails(
      {super.key,
        required this.imageUrl,
        required this.playerName,
        required this.playerHandicap});

  final String imageUrl;
  final String playerName;
  final String playerHandicap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNetworkImage(
          imageUrl: imageUrl,
          height: 55.h,
          width: 55.w,
          boxShape: BoxShape.circle,
        ),
        verticalSpacing(8.h),
        Text(playerName, style: AppStyles.h4()),
        verticalSpacing(8.h),
        Text('${AppString.handicapText} : $playerHandicap',
            style: AppStyles.h4()),
      ],
    );
  }
}
