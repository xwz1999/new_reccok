/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/icons/app_icon.png');

  /// File path: assets/icons/home_tab_search.png
  AssetGenImage get homeTabSearch =>
      const AssetGenImage('assets/icons/home_tab_search.png');

  /// File path: assets/icons/navigation_msg.png
  AssetGenImage get navigationMsg =>
      const AssetGenImage('assets/icons/navigation_msg.png');

  /// File path: assets/icons/navigation_scan.png
  AssetGenImage get navigationScan =>
      const AssetGenImage('assets/icons/navigation_scan.png');

  /// File path: assets/icons/shop_page_smile.png
  AssetGenImage get shopPageSmile =>
      const AssetGenImage('assets/icons/shop_page_smile.png');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/HomeRefreshHeader3.gif
  AssetGenImage get homeRefreshHeader3 =>
      const AssetGenImage('assets/images/HomeRefreshHeader3.gif');

  /// File path: assets/images/placeholder_new_1x1_a.png
  AssetGenImage get placeholderNew1x1A =>
      const AssetGenImage('assets/images/placeholder_new_1x1_a.png');

  /// File path: assets/images/placeholder_new_1x2_a.png
  AssetGenImage get placeholderNew1x2A =>
      const AssetGenImage('assets/images/placeholder_new_1x2_a.png');

  /// File path: assets/images/placeholder_new_2x1_a.png
  AssetGenImage get placeholderNew2x1A =>
      const AssetGenImage('assets/images/placeholder_new_2x1_a.png');
}

class $AssetsWebpGen {
  const $AssetsWebpGen();

  /// File path: assets/webp/recook_splash.webp
  AssetGenImage get recookSplash =>
      const AssetGenImage('assets/webp/recook_splash.webp');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsWebpGen webp = $AssetsWebpGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale = 1.0,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;
}
