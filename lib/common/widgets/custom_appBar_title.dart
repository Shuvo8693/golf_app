import 'package:flutter/material.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

class CustomAppBarTitle extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBarTitle({
    super.key,  required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text,style: AppStyles.h2(),),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
