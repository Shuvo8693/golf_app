import 'package:flutter/material.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';

class CustomAppBarTitle extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBarTitle({
    super.key,  required this.text, this.textStyle, this.maxLine,
  });
  final String text;
  final TextStyle? textStyle;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text,style:textStyle?? AppStyles.h2(),maxLines: maxLine??1,),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
