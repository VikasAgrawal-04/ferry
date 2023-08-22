import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WhiteBoxCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<Widget> children;
  final Color? color;
  final List<BoxShadow>? shadows;
  const WhiteBoxCard(
      {required this.children,
      this.margin,
      this.padding,
      this.color,
      this.shadows,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: margin,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: ShapeDecoration(
        color: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: shadows ??
            [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: children),
    );
  }
}
