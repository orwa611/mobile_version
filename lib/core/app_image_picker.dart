import 'package:image_picker/image_picker.dart';
import 'package:mobile_version/core/exceptions/image_picker_exception.dart';

abstract class AppImagePicker {
  Future<String> getImage({ImageSource source});
}

final class AppImagePickerImpl implements AppImagePicker {
  final ImagePicker picker;

  AppImagePickerImpl({required this.picker});

  @override
  Future<String> getImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final result = await picker.pickImage(source: source);
      if (result != null) {
        return result.path;
      } else {
        throw ImageNotFoundException();
      }
    } on ImagePickerException catch (_) {
      rethrow;
    } catch (e) {
      throw ImageErrorException();
    }
  }
}
