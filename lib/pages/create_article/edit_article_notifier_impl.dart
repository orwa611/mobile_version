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
    // TODO: implement createArticle
  }

  @override
  void getImage() {
    // TODO: implement getImage
  }

  @override
  void removeImage() {
    // TODO: implement removeImage
  }

  @override
  void removeTag(String value) {
    // TODO: implement removeTag
  }

  @override
  void saveDescription(String? value) {
    // TODO: implement saveDescription
  }

  @override
  void saveTag(String? value) {}

  @override
  void saveTitle(String? value) {
    request.title = value ?? '';
    notifyListeners();
  }

  @override
  String? validateDescription(String? value) {
    // TODO: implement validateDescription
    throw UnimplementedError();
  }

  @override
  String? validateTitle(String? value) {
    // TODO: implement validateTitle
    throw UnimplementedError();
  }
}
