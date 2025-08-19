import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:librio/core/theme/app_colors.dart';

class CommonAsset {
  const CommonAsset._();

  static Widget loadSvg({
    required String assetName,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      width: width ?? 24.0,
      height: height ?? 24.0,
      assetName,
      colorFilter: ColorFilter.mode(
        color ?? AppColors.librioBlue,
        BlendMode.srcIn,
      ),
    );
  }
}
