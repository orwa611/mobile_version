import 'package:image_picker/image_picker.dart';
import 'package:mobile_version/core/exceptions/image_picker_exception.dart';

abstract class AppImagePicker {
  Future<ImageModel> getImage({ImageSource source});
}

class ImageModel {
  final String path;
  final String name;
  final List<int> image;

  ImageModel({required this.name, required this.path, required this.image});
}

final class AppImagePickerImpl implements AppImagePicker {
  final ImagePicker picker;

  AppImagePickerImpl({required this.picker});

  @override
  Future<ImageModel> getImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final result = await picker.pickImage(source: source);
      if (result != null) {
        final image = await result.readAsBytes();
        return ImageModel(path: result.path, image: image, name: result.name);
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
