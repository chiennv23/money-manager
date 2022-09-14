import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'ImagePickerDialog.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;
  bool chooseMutil = false;
  bool isCrop = true;
  CropStyle cropStyle;

  ImagePickerHandler(this._listener, this._controller,
      {this.chooseMutil = false,
      this.isCrop = true,
      this.cropStyle = CropStyle.circle});

  final ImagePicker _picker = ImagePicker();

  List<File> _imagesFile = [];

  openCamera() async {
    imagePicker.dismissDialog();
    final image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (chooseMutil) {
      _imagesFile.add(File(image.path));
      _listener.userImageList(_imagesFile);
    } else {
      if (isCrop) {
        await cropImage(image.path);
      } else {
        _imagesFile.add(File(image.path));
        _listener.userImageList(_imagesFile);
      }
    }
  }

  openGallery() async {
    imagePicker.dismissDialog();

    if (chooseMutil) {
      final image = await _picker.pickMultiImage(
        imageQuality: 100,
      );
      for (var i = 0; i < image.length; i++) {
        _imagesFile.add(File(image[i].path));
        // _images.add(image[i]);
      }
    } else {
      final image = await _picker.pickImage(
        imageQuality: 100,
        source: ImageSource.gallery,
      );
      if (image.path != null) {
        if (isCrop) {
          await cropImage(image.path);
        } else {
          _imagesFile.add(File(image.path));
        }
      }
    }
    _listener.userImageList(_imagesFile);
  }

  void init() {
    imagePicker = ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  List<File> _imagesFileCrop = [];

  ImageCropper imageCropper = ImageCropper();

  Future cropImage(String image) async {
    final croppedFile = await imageCropper.cropImage(
        sourcePath: image,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        cropStyle: cropStyle,
        maxWidth: 512,
        maxHeight: 512,
        compressQuality: 75,
        compressFormat: ImageCompressFormat.jpg);

    if (croppedFile != null) {
      _imagesFileCrop.add(croppedFile);
      _listener.userImageList(_imagesFileCrop);
      print('upload-avatar');
      // var user = await AccountDA.uploadAvatar(
      //   croppedFile.path,
      // );
      // if (user.code == 200) {
      //   _listener.userImageList(_imagesFileCrop);
      //   AccountDA.user.UrlAvatar = user.string;
      //   UserService.setUser(userItem: AccountDA.user);
      //   await SharedPreferencesHelper.instance
      //       .setString(key: 'avatarCustomer', val: croppedFile.path);
      //   await SnackBarCore.success(
      //       title: 'Cập nhật thành công', isBottom: true);
      // } else {
      //   await SnackBarCore.fail(isBottom: true);
      // }
      _imagesFileCrop.clear();
    }
  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImageList(List<File> _image);
}
