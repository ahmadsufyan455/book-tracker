import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

extension ContextX on BuildContext {
  /// theme
  ThemeData get theme => Theme.of(this);

  /// size
  double get xtraLarge => 34.0;
  double get veryLarge => 24.0;
  double get large => 18.0;
  double get medium => 16.0;
  double get small => 14.0;
  double get verySmall => 12.0;
  double get xtraSmall => 10.0;

  /// device size
  double get deviceWidth => MediaQuery.sizeOf(this).width;
  double get deviceHeight => MediaQuery.sizeOf(this).height;

  /// dialog, toast, etc..
  void showMessageToast({required String message}) {
    showToast(
      message,
      context: this,
      animation: StyledToastAnimation.slideFromRightFade,
      reverseAnimation: StyledToastAnimation.slideToRightFade,
      toastHorizontalMargin: 0.0,
      position: StyledToastPosition(align: Alignment.topRight, offset: 20.0),
      startOffset: Offset(1.0, 0.0),
      reverseEndOffset: Offset(1.0, 0.0),
      animDuration: Duration(milliseconds: 600),
      duration: Duration(seconds: 3),
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }
}
