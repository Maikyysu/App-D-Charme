import 'package:flutter/material.dart';


class LinkText extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final double fontSize;
  final Alignment alignment;

  const LinkText({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    this.fontSize = 14,
    this.alignment = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}


class RichLinkText extends StatelessWidget {
  final String normalText;
  final String highlightedText;
  final Color normalColor;
  final Color highlightedColor;
  final VoidCallback onTap;

  const RichLinkText({
    super.key,
    required this.normalText,
    required this.highlightedText,
    required this.normalColor,
    required this.highlightedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: normalText,
          style: TextStyle(
            color: normalColor,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: highlightedText,
              style: TextStyle(
                color: highlightedColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
