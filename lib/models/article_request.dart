import 'package:dio/dio.dart';

class ArticleRequest {
  String title;
  String content;
  List<String> tags;
  String image;
  String? imageName;

  ArticleRequest({
    required this.title,
    required this.content,
    required this.tags,
    required this.image,
    this.imageName,
  });

  FormData toFormData() {
    final formData = FormData.fromMap({
      'title': title,
      'content': content,
      'tag': tags,
      'image': MultipartFile.fromFile(image, filename: imageName),
    });

    return formData;
  }
}
