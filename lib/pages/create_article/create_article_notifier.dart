import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/services/pick_image_service.dart';

abstract class CreateArticleNotifier extends ChangeNotifier {
  String? image;
  List<String>? tags;
  String? errorImage;

  final GlobalKey<FormState> globalKey;

  CreateArticleNotifier({required this.globalKey});

  String? validateTitle(String? value);
  void saveTitle(String? value);

  String? validateDescription(String? value);
  void saveDescription(String? value);

  void getImage();
  void removeImage();
  void createArticle(Function(ArticleRequest) callBack);

  void saveTag(String? value);
  void removeTag(String value);
}

final class CreateArticleNotifierImpl extends CreateArticleNotifier {
  final PickImageService _service;
  ArticleRequest request = ArticleRequest(
    title: '',
    content: '',
    tags: [],
    image: [],
  );

  CreateArticleNotifierImpl({
    required super.globalKey,
    required PickImageService service,
  }) : _service = service;
  @override
  String? validateTitle(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    } else {
      return 'Title is required';
    }
  }

  @override
  void saveTitle(String? value) {
    request.title = value ?? '';
  }

  @override
  void createArticle(Function(ArticleRequest) callBack) {
    errorImage = null;
    final isValid = globalKey.currentState?.validate();
    if (isValid == true && image != null) {
      globalKey.currentState?.save();
      callBack(request);
    } else if (image == null) {
      errorImage = 'Image is required ';
    }
    notifyListeners();
  }

  @override
  void getImage() async {
    errorImage = null;
    final model = await _service.getImage();
    request.image = model.image;
    request.imageName = model.name;
    image = model.path;
    notifyListeners();
  }

  @override
  void removeImage() {
    request.image = [];
    image = null;
    notifyListeners();
  }

  @override
  void saveDescription(String? value) {
    request.content = value ?? '';
  }

  @override
  String? validateDescription(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.length > 500) {
        return null;
      } else {
        return 'Content must be over 500 character!';
      }
    } else {
      return 'Content is required';
    }
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
  void removeTag(String value) {
    request.tags.remove(value);
    tags = request.tags;
    notifyListeners();
  }
}
