import 'package:mobile_version/core/exceptions/app_image_exception.dart';

abstract class ImagePickerException implements Exception {
  final String message;

  ImagePickerException({required this.message});

  AppImageException toAppException() {
    return AppImageErrorException(message: message);
  }
}

class ImageNotFoundException extends ImagePickerException {
  ImageNotFoundException() : super(message: 'Image not found!');

  @override
  String get message => 'Image not found!';
}

class ImageErrorException extends ImagePickerException {
  ImageErrorException() : super(message: 'Image Error');
}
