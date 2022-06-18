import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  TextWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLines = 10,
  }) : super(key: key);
  final String text;
  final Color color;
  final double textSize;
  bool isTitle;
  int maxLines = 10;

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: widget.maxLines,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: widget.color,
          fontSize: widget.textSize,
          fontWeight: widget.isTitle ? FontWeight.bold : FontWeight.normal),
    );
  }
}
