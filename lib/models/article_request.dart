import 'package:dio/dio.dart';

class ArticleRequest {
  String title;
  String content;
  List<String> tags;
  List<int> image;
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
      'tag': tags.join(','),
      'image': MultipartFile.fromBytes(image, filename: imageName),
    });

    return formData;
  }
}
