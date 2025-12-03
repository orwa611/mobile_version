import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/models/author_model.dart';
import 'package:mobile_version/pages/create_article/create_article_notifier.dart';
import 'package:mobile_version/widgets/author_picture_widget.dart';
import 'package:mobile_version/widgets/input_field.dart';
import 'package:mobile_version/widgets/primary_button.dart';

class CreateArticlePage extends StatelessWidget {
  static const String route = '/create_article_page';
  final Author author;
  final CreateArticleNotifier _notifier;
  final Function(ArticleRequest) onShare;
  final bool isEdit;

  CreateArticlePage({
    super.key,
    required this.author,
    required CreateArticleNotifier notifier,
    required this.onShare,
    this.isEdit = false,
  }) : _notifier = notifier;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text((isEdit) ? 'Edit post' : 'Create post')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 10,
                  children: [
                    AuthorPictureWidget(
                      height: 30,
                      width: 30,
                      authorImage: author.authorImageUrl,
                    ),

                    Text(author.fullName),
                  ],
                ),
              ),
              Divider(),
              ListenableBuilder(
                listenable: _notifier,
                builder: (context, child) {
                  return Form(
                    key: _notifier.globalKey,
                    child: Column(
                      spacing: 20,
                      children: [
                        InputField(
                          hintText: 'Title :',
                          initialValue: _notifier.request.title,
                          validator: _notifier.validateTitle,
                          onSaved: _notifier.saveTitle,
                        ),
                        _buildImageField(),
                        (_notifier.tags != null)
                            ? Row(
                              spacing: 8,
                              children:
                                  _notifier.tags!
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            _notifier.removeTag(e);
                                          },
                                          child: Chip(label: Text(e)),
                                        ),
                                      )
                                      .toList(),
                            )
                            : SizedBox.shrink(),
                        Row(
                          children: [
                            Expanded(
                              child: InputField(
                                hintText: 'Add tags',
                                controller: controller,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _notifier.saveTag(controller.value.text);
                                controller.clear();
                              },
                              child: Text('Add Tag'),
                            ),
                          ],
                        ),
                        InputField(
                          initialValue: _notifier.request.content,
                          hintText: 'type your content',
                          maxLine: 5,
                          onSaved: _notifier.saveDescription,
                          validator: _notifier.validateDescription,
                        ),
                        PrimaryButton(
                          onPressed: () {
                            _notifier.createArticle(onShare);
                          },
                          title: (isEdit) ? 'Edit' : 'Share',
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageField() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (_notifier.image == null)
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('Choose image :'),
                  ),
                  IconButton(
                    onPressed: () {
                      _notifier.getImage();
                    },
                    icon: Icon(Icons.image),
                  ),
                ],
              )
              : Stack(
                children: [
                  Image.network(_notifier.image!, height: 100),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton.filled(
                      onPressed: () {
                        _notifier.removeImage();
                      },
                      icon: Icon(Icons.close_outlined, color: Colors.red),
                    ),
                  ),
                ],
              ),
          (_notifier.errorImage != null)
              ? Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  _notifier.errorImage!,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 148, 12, 2),
                    fontSize: 12,
                  ),
                ),
              )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
