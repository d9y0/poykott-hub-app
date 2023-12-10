import 'package:flutter/material.dart';

class ContainerLayerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double? width;
  final double? height;

  /// propertes inside BoxDecoration
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final DecorationImage? image;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BlendMode? backgroundBlendMode;
  final BoxShape shape = BoxShape.rectangle;

  const ContainerLayerWidget({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.border,
    this.image,
    this.boxShadow,
    this.gradient,
    this.backgroundBlendMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Material(
        borderRadius: borderRadius,
        elevation: elevation,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: border,
            color: color,
            borderRadius: borderRadius,
            image: image,
            boxShadow: boxShadow,
            gradient: gradient,
            backgroundBlendMode: backgroundBlendMode,
            shape: shape,
          ),
          child: child,
        ),
      ),
    );
  }
}

class InkWellLayerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double? width;
  final double? height;

  /// propertes inside BoxDecoration
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final DecorationImage? image;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BlendMode? backgroundBlendMode;
  final BoxShape shape = BoxShape.rectangle;

  /// propertes inside Inkwill
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final void Function(TapDownDetails)? onTapDown;
  final void Function(TapUpDetails)? onTapUp;
  final void Function()? onTapCancel;
  final void Function()? onSecondaryTap;
  final void Function(TapUpDetails)? onSecondaryTapUp;
  final void Function(TapDownDetails)? onSecondaryTapDown;
  final void Function()? onSecondaryTapCancel;
  final void Function(bool)? onHighlightChanged;
  final void Function(bool)? onHover;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final double? radius;
  final ShapeBorder? customBorder;

  final bool? enableFeedback;
  final bool excludeFromSemantics;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final void Function(bool)? onFocusChange;
  final bool autofocus;
  final MaterialStatesController? statesController;
  final MaterialStateProperty<Color?>? overlayColor;

  const InkWellLayerWidget({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.border,
    this.image,
    this.boxShadow,
    this.gradient,
    this.backgroundBlendMode,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.onSecondaryTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.radius,
    this.customBorder,
    this.focusNode,
    this.onFocusChange,
    this.statesController,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.canRequestFocus = true,
    this.autofocus = false,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Material(
        borderRadius: borderRadius,
        elevation: elevation,
        color: color,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: onTapCancel,
          onSecondaryTap: onSecondaryTap,
          onSecondaryTapUp: onSecondaryTapUp,
          onSecondaryTapDown: onSecondaryTapDown,
          onSecondaryTapCancel: onSecondaryTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          mouseCursor: mouseCursor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          overlayColor: overlayColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          radius: radius,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          onFocusChange: onFocusChange,
          autofocus: autofocus,
          statesController: statesController,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              border: border,
              borderRadius: borderRadius,
              image: image,
              boxShadow: boxShadow,
              gradient: gradient,
              backgroundBlendMode: backgroundBlendMode,
              shape: shape,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
