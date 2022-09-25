import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:coresystem/Utils/ConvertTiengvietNoSign/tiengviet.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as im;
import 'package:image_picker/image_picker.dart';

class OcrScan {
  final ImagePicker _picker = ImagePicker();
  TextRecognizer textDetector = GoogleMlKit.vision.textRecognizer();

  String DetectFullName(String txt) {
    var regExp = RegExp(r'([0-9]{6}[^@]+[0-9]{2}/[0-9]{2}/[0-9]{4})');
    var match = regExp.firstMatch(txt);

    var matchedText = match?.group(0);
    if (matchedText != null) {
      var char = matchedText.replaceAll(RegExp(r'\d'), '');

      return char;
    }
    regExp = RegExp(r'([0-9]{6}[^@]+[0-9]{2}-[0-9]{2}-[0-9]{4})');
    match = regExp.firstMatch(txt);

    matchedText = match?.group(0);
    if (matchedText != null) {
      var char = matchedText.replaceAll(RegExp(r'\d'), '');

      return char;
    }
    return null;
  }

  String DetectCMT(String txt) {
    var regExp = RegExp(r'([0-9]{2}-[0-9]{2}-[0-9]{4})');
    var match = regExp.firstMatch(txt);

    var matchedText = match?.group(0);
    if (matchedText != null) {
      return matchedText;
    }
    regExp = RegExp(r'([0-9]{2}/[0-9]{2}/[0-9]{4})');
    match = regExp.firstMatch(txt);
    matchedText = match?.group(0);
    if (matchedText != null) {
      return matchedText;
    }
    return null;
  }

  String DetectNumberCMT(String txt) {
    var regExp = RegExp(r'([0-9]{12})');
    var match = regExp.firstMatch(txt);

    var matchedText = match?.group(0);
    if (matchedText != null) {
      return matchedText;
    }

    regExp = RegExp(r'([0-9]{9})');
    match = regExp.firstMatch(txt);

    matchedText = match?.group(0);
    if (matchedText != null) {
      return matchedText;
    }

    regExp = RegExp(r'([0-9]{8})');
    match = regExp.firstMatch(txt);

    matchedText = match?.group(0);
    if (matchedText != null) {
      return matchedText;
    }
    return null;
  }

  Future<String> TakeImgAndOCR({bool forRoleStaff = false}) async {
    final _pickedImageFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (_pickedImageFile == null) {
      // Cancelled by user.
      return null;
    }

    await _PhotoOptimizerForOCR.optimizeByResize(_pickedImageFile.path);

    final inputImage = InputImage.fromFilePath(_pickedImageFile.path);

    final recognisedText = await textDetector.processImage(inputImage);
    print(TiengVietCore.removeDiacritics(
        recognisedText.text.toString().toLowerCase()));
    return TiengVietCore.removeDiacritics(
        recognisedText.text.toString().toLowerCase());
    // try {
    //   final _resultString = recognisedText.text.replaceAll('\n', ' ');
    //   final obj = <String, String>{'text': _resultString};
    //   final char = obj['text'].split('');
    //
    //   final list = [];
    //
    //   var s = 0;
    //   var e = 0;
    //   var utr = '';
    //   var objq = <dynamic, dynamic>{'s': 0, 'e': 0};
    //   for (var i = 0; i < char.length; i++) {
    //     if (char[i].toString().isNotEmpty && char[i].toString() != '') {
    //       if (num.tryParse(char[i]) != null) {
    //         if (s == 0) {
    //           s = i;
    //         } else {
    //           e = i;
    //         }
    //       }
    //     }
    //   }
    //   if (e > 0) {
    //     utr = obj['text'].toString().substring(s, e + 1);
    //     utr = utr.replaceAll('.', ' ');
    //     utr = utr.replaceAll(':', ' ');
    //     print('noi dung $utr');
    //     final data = utr.split('');
    //     for (var i = 0; i < data.length; i++) {
    //       if (num.tryParse(data[i]) != null) {
    //         if (objq['s'] == 0) {
    //           objq['s'] = i;
    //         } else {
    //           objq['e'] = i;
    //         }
    //       } else {
    //         if (objq['e'] > 0) {
    //           list.add(objq);
    //           objq = {'s': 0, 'e': 0};
    //         }
    //       }
    //     }
    //   }
    //   print(list.length);
    //   if (list.length > 2) {
    //     var ht = DetectFullName(_resultString).split(' ');
    //     print('tennnnn full: ${DetectFullName(_resultString)}');
    //     var isGender = ht.any((e) => e.wUnicodeToAscii() == 'nu');
    //     var listht = [];
    //     for (var i = 0; i < ht.length; i++) {
    //       if (ht[i].isNotEmpty &&
    //           ht[i] != '' &&
    //           ht[i] == ht[i].toUpperCase() &&
    //           num.tryParse(ht[i]) == null) {
    //         if (listht.isEmpty) {
    //           if (i > 0) {
    //             if (ht[i - 1].isNotEmpty &&
    //                 ht[i - 1] != '' &&
    //                 ht[i - 1] == ht[i - 1].toUpperCase() &&
    //                 num.tryParse(ht[i - 1]) == null) {
    //               listht.add(ht[i - 1]);
    //               listht.add(ht[i]);
    //             }
    //           }
    //         } else if (i > 0) {
    //           if (ht[i - 1].isNotEmpty &&
    //               ht[i - 1] != '' &&
    //               ht[i - 1] == ht[i - 1].toUpperCase() &&
    //               num.tryParse(ht[i - 1]) == null) {
    //             listht.add(ht[i]);
    //           }
    //         }
    //       }
    //     }
    //
    //   }
    // } catch (e) {
    //   print('error in recognizing the image / photo => ${e.toString()}');
    // }
    // }
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
