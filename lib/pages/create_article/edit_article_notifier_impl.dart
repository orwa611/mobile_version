import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/pages/create_article/create_article_notifier.dart';
import 'package:mobile_version/services/pick_image_service.dart';

final class EditArticleNotifierImpl extends FormArticleNotifier {
  final PickImageService _service;

  EditArticleNotifierImpl({
    required super.globalKey,
    required super.request,
    required PickImageService service,
    String? imageUrl,
  }) : _service = service {
    tags = request.tags;
    image = imageUrl;
  }

  @override
  void createArticle(Function(ArticleRequest p1) callBack) {
    errorImage = null;
    final isValid = globalKey.currentState?.validate();
    if (isValid != null && isValid && image != null) {
      globalKey.currentState?.save();
      callBack(request);
    } else if (image == null) {
      errorImage = 'Image is required ';
    }
    notifyListeners();
  }

  @override
  void getImage() async {
    final result = await _service.getImage();
    image = result.path;
    request.imageName = result.name;
    request.image = result.image;
    notifyListeners();
  }

  @override
  void removeImage() {
    request.image = [];
    image = null;
    notifyListeners();
  }

  @override
  void removeTag(String value) {
    request.tags.remove(value);
    tags = request.tags;
    notifyListeners();
  }

  @override
  void saveDescription(String? value) {
    request.content = value ?? '';
    notifyListeners();
  }

  @override
  void saveTag(String? value) {
    if (value != null && value.isNotEmpty) {
      request.tags.add(value);
    }
    tags = request.tags;
    notifyListeners();
  }

  @override
  void saveTitle(String? value) {
    request.title = value ?? '';
    notifyListeners();
  }

  @override
  String? validateDescription(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length > 500) {
        return null;
      } else {
        return 'Content must contain at least 500 character';
      }
    } else {
      return 'Content is required';
    }
  }

  @override
  String? validateTitle(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return 'Title is required';
    }
  }
}
