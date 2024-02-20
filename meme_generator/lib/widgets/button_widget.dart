import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button.text(
      {super.key,
      required this.text,
      required this.onTap,
      this.isExpanded = true,
      this.hasShadow = true,
      this.hasBorder = true,
      this.disabled = false,
      this.child,
      this.style,
      this.bgColor,
      this.borderColor,
      this.padding,
      this.margin,
      this.height,
      this.borderRadius,
      this.width,
      this.alignment,
      this.icon});

  final VoidCallback? onTap;
  final bool isExpanded;
  final bool hasShadow;
  final bool hasBorder;
  final bool disabled;
  final Widget? child;
  final Alignment? alignment;
  final double? width;
  final double? height;
  final String? text;
  final TextStyle? style;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? icon;

  EdgeInsetsGeometry get getPadding =>
      padding ??
      EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: isExpanded ? 16.0 : 24.0,
      );

  BoxBorder? get getBorder => hasBorder
      ? Border.all(width: 2.0, color: borderColor ?? Colors.black)
      : null;

  List<BoxShadow> get getShadow => [
        if (hasShadow)
          BoxShadow(
            color: borderColor ?? Colors.black,
            offset: const Offset(0.0, 8.0),
          ),
      ];

  Widget get getChild {
    final textChild = Text(text ?? '',
        style: style ??
            (disabled
                ? const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)
                : const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)));

    if (icon != null) {
      final rowChildren = <Widget>[];
      rowChildren.add(textChild);
      rowChildren.add(const Spacer());
      // rowChildren.add(SvgPicture.asset(icon!));
      return isExpanded
          ? Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rowChildren))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rowChildren);
    }

    return isExpanded ? Center(child: child ?? textChild) : child ?? textChild;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? () {} : onTap ?? () {},
      child: Container(
        alignment: alignment,
        width: isExpanded ? double.infinity : width,
        height: height,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
        padding: getPadding,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          border: getBorder,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          boxShadow: getShadow,
        ),
        child: getChild,
      ),
    );
  }
}
