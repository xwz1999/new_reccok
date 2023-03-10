import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:power_logger/power_logger.dart';

class ImageUtils {
  static Future<File?> cropImage(File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
    AndroidUiSettings(
          toolbarTitle: "裁剪",
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white),
        IOSUiSettings(
          title: '裁剪',
        ),
      ],
    );

    return File(croppedFile!=null?croppedFile.path:'');
  }

  /// 返回bytes数组
  static Future<List<int>?> compressImageWithBytes(String filePath,
      {int minWidth = 750,
      int minHeight = 1000,
      int quality = 50,
      int rotate = 0,
      bool autoCorrectionAngle = true,
      CompressFormat format = CompressFormat.jpeg,
      bool keepExif = false}) async {
    var result = await FlutterImageCompress.compressWithFile(
      filePath,
      quality: quality,
      minHeight: minHeight,
      minWidth: minWidth,
      rotate: rotate,
      autoCorrectionAngle: autoCorrectionAngle,
      format: format,
      keepExif: keepExif,
    );
    return result;
  }

  /// From [path] to [targetPath]
  static Future<File?> compressAndGetFile(
    String path,
    String targetPath, {
    int minWidth = 1920,
    int minHeight = 1080,
    int quality = 95,
    int rotate = 0,
    bool autoCorrectionAngle = true,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
  }) async {
    return await FlutterImageCompress.compressAndGetFile(path, targetPath);
  }

  // static Future<bool> saveNetworkImageToPhoto(String url, {bool useCache: true}) async {
  //   var data = await getNetworkImageData(url, useCache: useCache);
  //   var filePath = await ImagePickerSaver.saveFile(fileData: data);
  //   DPrint.printf(filePath);
  //   return filePath != null && filePath != "";
  // }
  static Future<bool?> saveNetworkImagesToPhoto(
    List<String?> urls,
    void Function(int index) callBack,
    void Function(bool success) endBack, {
    bool useCache: true,
  }) async {
    try {
      if (Platform.isAndroid) {
        bool permissionStorage = await Permission.storage.isGranted;
        if (!permissionStorage) {
          await Permission.storage.request();
          permissionStorage = await Permission.storage.isGranted;
          if (!permissionStorage) {
            print("❌----------has no Permission");
            return false;
          }
        } else {
          print("----------has Permission");
        }
      }
      //

      for (var i = 0; i < urls.length; i++) {
        String url = urls[i]!;
        var data = await (getNetworkImageData(url, useCache: useCache));
        try {
          // final Map<dynamic, dynamic>? result =
              await (ImageGallerySaver.saveImage(data!, quality: 100));
        } catch (e) {
          if (e is ArgumentError) {
            if (Platform.isIOS) {
              callBack(i);
              continue;
            }
          }

          endBack(false);

          return false;
        }
      }
      endBack(true);
      return true;
    } catch (e) {
      print(e);
      callBack(99);
    }
    return null;
  }

  static Future<bool?> saveImage(List<Uint8List> fileDatas,
      void Function(int index) callBack, void Function(bool success) endBack,
      {int quality = 80}) async {
    //
    try {
      if (Platform.isAndroid) {
        bool permissionStorage = await Permission.storage.isGranted;
        if (!permissionStorage) {
          await Permission.storage.request();
          permissionStorage = await Permission.storage.isGranted;
          if (!permissionStorage) {
            print("❌----------has no Permission");
            return false;
          }
        }
      }
      //
      for (var i = 0; i < fileDatas.length; i++) {
        Uint8List data = fileDatas[i];
        try {
          final Map<dynamic, dynamic> result =
              await (ImageGallerySaver.saveImage(data, quality: quality));

          LoggerData.addData(result.containsValue(true));
          if (Platform.isAndroid) {
            if (result.containsValue(true)) {
              callBack(i);
            } else {
              endBack(false);
              return false;
            }
          } else if (Platform.isIOS) {
            if (result.containsValue(true)) {
              callBack(i);
            } else {
              endBack(false);
              return false;
            }
          }
        } catch (e) {
          LoggerData.addData(e.toString());
          if (e is ArgumentError) {
            if (Platform.isIOS) {
              callBack(i);
              if (i == (fileDatas.length - 1)) {
                endBack(true);
                return true;
              }
              continue;
            }
          }
          LoggerData.addData(e.toString());
          endBack(false);
          return false;
        }
      }
      endBack(true);
      return true;
    } catch (e) {}
    return null;
  }
}
