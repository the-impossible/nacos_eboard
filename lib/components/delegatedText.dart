import 'package:flutter/material.dart';
import 'package:nacos_eboard/services/constants.dart';

class DelegatedText extends StatelessWidget {
  final String text;
  final double fontSize;
  String? fontName = 'InterBold';
  Color? color = Constants.tertiaryColor;
  TextAlign? align;
  bool? truncate;
  bool? overflow;

  DelegatedText({
    required this.text,
    required this.fontSize,
    this.fontName,
    this.color,
    this.align,
    this.truncate,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (truncate == true)
          ? truncateString(text, 13)
          : (overflow == true)
              ? truncateString(text, 50)
              : text,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        letterSpacing: 1,
        fontFamily: fontName,
      ),
      textAlign: align,
    );
  }

  String truncateString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      return "${input.substring(0, maxLength)}...";
    }
  }
}
