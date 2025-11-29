import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/models/article_model.dart';

part 'edit_article_event.dart';
part 'edit_article_state.dart';

class EditArticleBloc extends Bloc<EditArticleEvent, EditArticleState> {
  EditArticleBloc() : super(EditArticleInitialState());
}
