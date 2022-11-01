import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/2M/Module/Money/DA/money_controller.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:exif/exif.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as im;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Core/routes.dart';
import '../../Project/2M/Contains/skin/color_skin.dart';

class OcrScan {
  MoneyController moneyController = Get.find();
  final ImagePicker _picker = ImagePicker();
  final ImageCropper imageCropper = ImageCropper();
  TextRecognizer textDetector = GoogleMlKit.vision.textRecognizer();

  Future<String> TakeImgAndOCR({bool forRoleStaff = false}) async {
    final _pickedImageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (_pickedImageFile == null) {
      // Cancelled by user.
      return null;
    }

    final fileCropped = await imageCropper.cropImage(
        sourcePath: _pickedImageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1.5, ratioY: 1.0),
        cropStyle: CropStyle.rectangle,
        compressQuality: 80,
        maxHeight: 200,
        compressFormat: ImageCompressFormat.jpg);
    if (fileCropped != null) {
      // add full img into money note when cropped done
      moneyController.imgOCR.clear();
      final file = File(_pickedImageFile.path);
      final imgShow = await ImageHelper.compressImage(file);
      moneyController.imgOCR.add(imgShow);
    }
    await _PhotoOptimizerForOCR.optimizeByResize(fileCropped.path);

    final inputImage = InputImage.fromFilePath(fileCropped.path);

    final recognisedText = await textDetector.processImage(inputImage);

    return recognisedText.text.toString().toLowerCase();
  }

  void Close() {
    // vision
    textDetector.close();
  }
}

/// A helper class to provide support for Photo optimizations.
///
/// All methods provided are static (stateless) and available as follows:
/// * getPhotoFileMeta - returning the exif metadata on the provided image / photo file.
/// * getPhotoFileMetaInString - returning the exif metadata in String format.
/// * optimizeByResize - optimization based on resizing the given photo by a certain dimension value.
class _PhotoOptimizerForOCR {
  /// The exif metadata key representing a photo's length (corresponding to width of an [ui.Image])
  static const exifTagImageLength = 'EXIF ExifImageLength';

  /// The exif metadata key representing a photo's width (corresponding to height of an [ui.Image])
  static const exifTagImageWidth = 'EXIF ExifImageWidth';

  /// Returns the raw Map of exif metadata on the [path].
  ///
  /// __PS__. Not every photo would have exif metadata; hence it is normal to return an empty [Map].
  static Future<Map<String, IfdTag>> getPhotoFileMeta(String path) async {
    final _meta = readExifFromBytes(File(path).readAsBytesSync());
    return _meta;
  }

  /// Returns the String description of the exif metadata on [path].
  ///
  /// __PS__. Not every photo would have exif metadata;
  /// hence if no metadata available a message "oops, no exif data available for this photo!!!" would be returned
  static Future<String> getPhotoFileMetaInString(String path) async {
    final _meta = await readExifFromBytes(File(path).readAsBytesSync());
    final _s = StringBuffer();

    if (_meta == null || _meta.isEmpty) {
      _s.writeln('oops, no exif data available for this photo!!!');
      return _s.toString();
    }
    // Iterate all keys and its value.
    _meta.keys.forEach((_k) {
      _s.writeln('[$_k]: (${_meta[_k].tagType} - ${_meta[_k]})');
    });
    return _s.toString();
  }

  /// Optimizes the photo at [path] by a constraint of [maxWidthOrLength].
  ///
  /// Resize logic is based on comparing the width and height of the image on [path] with the [maxWidthOrLength];
  /// if either dimension is larger than [maxWidthOrLength], a corresponding resizing would be implemented.
  /// Aspect ratio would be maintained to prevent image distortion. Finally the resized image would replace the original one.
  static Future<bool> optimizeByResize(String path,
      {int maxWidthOrLength = 1500}) async {
    var _w = 0;
    var _h = 0;
    final _meta = await _PhotoOptimizerForOCR.getPhotoFileMeta(path);

    // Note that not every photo might have exif information~~~
    if (_meta == null ||
        _meta.isEmpty ||
        _meta[_PhotoOptimizerForOCR.exifTagImageWidth] == null ||
        _meta[_PhotoOptimizerForOCR.exifTagImageLength] == null) {
      // Use the old fashion ImageProvider to resolve the photo's dimensions.
      final _completer = Completer();
      FileImage(File(path))
          .resolve(ImageConfiguration())
          .addListener(ImageStreamListener((imgInfo, _) {
        _completer.complete(imgInfo.image);
      }));
      final _img = await _completer.future as ui.Image;
      _w = _img.height;
      _h = _img.width;
    } else {
      _w = _meta[_PhotoOptimizerForOCR.exifTagImageWidth].values.firstAsInt();
      _h = _meta[_PhotoOptimizerForOCR.exifTagImageLength].values.firstAsInt();
    }

    var _factor = 1.0;
    // Update the resized w and h after resizing.
    if (_w >= _h) {
      _factor = maxWidthOrLength / _w;
      _w = (_w * _factor).round();
      _h = (_h * _factor).round();
    } else {
      _factor = maxWidthOrLength / _h;
      _w = (_w * _factor).round();
      _h = (_h * _factor).round();
    }

    // [DOC] note the exif width = height of the image !! whilst exif length = width of the image !!
    final _resizedImage = im.copyResize(
        im.decodeImage(File(path).readAsBytesSync()),
        width: _h,
        height: _w);

    // Overwrite existing file with the resized one.
    File(path).writeAsBytesSync(im.encodeJpg(_resizedImage));

    return true;
  }
}
