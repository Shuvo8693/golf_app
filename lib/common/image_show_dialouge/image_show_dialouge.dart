import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/app/modules/home/model/sponsor_content_model.dart';
import 'package:golf_game_play/common/widgets/casess_network_image.dart';

class imageShowDialouge extends StatelessWidget {
  const imageShowDialouge({
    super.key,
    required this.sponsorContentAttributes,
  });

  final SponsorContentAttributes sponsorContentAttributes;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Stack(
        children: [
          // Main image container
          Container(
            width: double.infinity,
            height: 400.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.black,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CustomNetworkImage(
                imageUrl: '${ApiConstants.imageBaseUrl}/${sponsorContentAttributes.sponserImage?.url}',
                height: 400.h,
                boxShape: BoxShape.rectangle,
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}