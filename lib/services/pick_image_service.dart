import 'package:mobile_version/core/app_image_picker.dart';
import 'package:mobile_version/core/exceptions/image_picker_exception.dart';

abstract class PickImageService {
  Future<ImageModel> getImage();
}

final class PickImageServiceImpl extends PickImageService {
  final AppImagePicker picker;

  PickImageServiceImpl({required this.picker});
  @override
  Future<ImageModel> getImage() async {
    try {
      final result = await picker.getImage();
      return result;
    } on ImagePickerException catch (e) {
      throw e.toAppException();
    }
  }
}
