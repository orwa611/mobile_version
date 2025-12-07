import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_version/blocs/article_bloc/article_bloc.dart';
import 'package:mobile_version/blocs/article_detail_bloc.dart/article_detail_bloc.dart';
import 'package:mobile_version/blocs/auth_bloc/auth_bloc.dart';
import 'package:mobile_version/blocs/comment_bloc.dart/comment_bloc.dart';
import 'package:mobile_version/blocs/form_article_bloc/form_article_bloc.dart';
import 'package:mobile_version/blocs/edit_article_bloc.dart/edit_article_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/blocs/register_bloc/register_bloc.dart';
import 'package:mobile_version/blocs/user_bloc/user_bloc.dart';
import 'package:mobile_version/core/app_image_picker.dart';
import 'package:mobile_version/core/network/authenticated_dio_network_session.dart';
import 'package:mobile_version/core/network/authenticated_http_network_session.dart';
import 'package:mobile_version/core/network/http_network_session.dart';
import 'package:mobile_version/core/storage/storage_adapter.dart';
import 'package:mobile_version/core/storage/storage_session.dart';
import 'package:mobile_version/factories/article_page_factory.dart';
import 'package:mobile_version/factories/author_page_factory.dart';
import 'package:mobile_version/factories/create_article_page_factory.dart';
import 'package:mobile_version/factories/edit_article_page_factory.dart';
import 'package:mobile_version/factories/home_page_factory.dart';
import 'package:mobile_version/factories/login_page_factory.dart';
import 'package:mobile_version/factories/register_page_factory.dart';
import 'package:mobile_version/pages/article_page.dart';
import 'package:mobile_version/pages/author_page.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';
import 'package:mobile_version/pages/edit_profile/edit_profile_notifier.dart';
import 'package:mobile_version/pages/edit_profile/edit_profile_page.dart';
import 'package:mobile_version/pages/edit_profile/update_profile_model.dart';
import 'package:mobile_version/pages/login/login_page.dart';
import 'package:mobile_version/pages/register/register_page.dart';
import 'package:mobile_version/services/account_service.dart';
import 'package:mobile_version/services/article_service.dart';
import 'package:mobile_version/services/article_service_manager.dart';
import 'package:mobile_version/services/auth_service.dart';
import 'package:mobile_version/services/auth_storage_service.dart';
import 'package:mobile_version/services/comment_service.dart';
import 'package:mobile_version/services/pick_image_service.dart';
import 'package:mobile_version/services/register_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  runApp(const MyApp());
}

class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HttpNetworkSession>(
          create: (context) => HttpNetworkSession(),
        ),
        RepositoryProvider<StorageSession>(
          create:
              (context) => SecureStorageSession(
                flutterSecureStorage: FlutterSecureStorage(),
              ),
        ),
        RepositoryProvider<StorageAdapter>(
          create:
              (context) =>
                  StorageAdapterImpl(session: context.read<StorageSession>()),
        ),
        RepositoryProvider<AuthService>(
          create:
              (context) =>
                  AuthServiceImpl(session: context.read<HttpNetworkSession>()),
        ),
        RepositoryProvider<RegisterService>(
          create:
              (context) => RegisterServiceImpl(
                session: context.read<HttpNetworkSession>(),
              ),
        ),
        RepositoryProvider<AuthStorageService>(
          create:
              (context) =>
                  AuthStorageService(storage: context.read<StorageAdapter>()),
        ),
        RepositoryProvider<AuthenticatedHttpNetworkSession>(
          create:
              (context) => AuthenticatedHttpNetworkSession(
                networkSession: context.read<HttpNetworkSession>(),
                manager: context.read<AuthStorageService>(),
              ),
        ),
        RepositoryProvider<AuthenticatedDioNetworkSession>(
          create:
              (context) => AuthenticatedDioNetworkSession(
                manager: context.read<AuthStorageService>(),
                dio: Dio(),
              ),
        ),
        RepositoryProvider<ArticleService>(
          create:
              (context) => ArticleServiceImpl(
                session: context.read<HttpNetworkSession>(),
              ),
        ),
        RepositoryProvider<AccountService>(
          create:
              (context) => AccountServiceImpl(
                session: context.read<AuthenticatedDioNetworkSession>(),
              ),
        ),
        RepositoryProvider<CommentService>(
          create:
              (context) => CommentServiceImpl(
                session: context.read<AuthenticatedHttpNetworkSession>(),
              ),
        ),
        RepositoryProvider<AppImagePicker>(
          create: (context) => AppImagePickerImpl(picker: ImagePicker()),
        ),
        RepositoryProvider<PickImageService>(
          create:
              (context) =>
                  PickImageServiceImpl(picker: context.read<AppImagePicker>()),
        ),
        RepositoryProvider<ArticleServiceManager>(
          create:
              (context) => ArticleServiceManagerImpl(
                session: context.read<AuthenticatedDioNetworkSession>(),
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => AuthBloc(
                  authService: context.read<AuthService>(),
                  authStorageService: context.read<AuthStorageService>(),
                ),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(context.read<RegisterService>()),
          ),
          BlocProvider(
            create:
                (context) =>
                    UserBloc(service: context.read<AuthStorageService>())
                      ..add(UserLoggedInEvent()),
          ),
          BlocProvider(
            create:
                (context) =>
                    ArticleBloc(service: context.read<ArticleService>())
                      ..add(GetArticlesEvent()),
          ),
          BlocProvider(
            create:
                (context) =>
                    ArticleDetailBloc(service: context.read<ArticleService>()),
          ),
          BlocProvider(
            create:
                (context) =>
                    CommentBloc(service: context.read<CommentService>()),
          ),
          BlocProvider(
            create:
                (context) =>
                    MyAccountBloc(service: context.read<AccountService>()),
          ),
          BlocProvider(
            create:
                (context) => FormArticleBloc(
                  service: context.read<ArticleServiceManager>(),
                ),
          ),
          BlocProvider(create: (context) => EditArticleBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            "/": HomePageFactory.buildHomePage,
            LoginPage.route: LoginPageFactory.buildLoginPage,
            RegisterPage.route: RegisterPageFactory.buildRegisterPage,
            ArticlePage.route: ArticlePageFactory.buildArticlePage,
            AuthorPage.route: AuthorPageFactory.buildAuthorPage,
            CreateArticlePage.route:
                CreateArticlePageFactory.buildCreateArticlePage,
            EditArticlePageFactory.route:
                EditArticlePageFactory.buildEditArticlePage,
            EditProfilePage.route: (context) {
              return BlocBuilder<MyAccountBloc, MyAccountState>(
                builder: (context, state) {
                  if (state is MyAccountStateSuccess) {
                    return EditProfilePage(
                      notifier: EditProfileNotifierImpl(
                        globalKey: GlobalKey(),
                        model: UpdateProfileModel(
                          firstName: state.author.firstName,
                          lastName: state.author.lastName,
                          email: state.author.email,
                          bio: state.author.about,
                        ),
                      ),
                      isLoading: false,
                      onUpdate: (model) {
                        context.read<MyAccountBloc>().add(
                          UpdateMyAccountEvent(author: model),
                        );
                        Navigator.of(context).pop();
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              );
            },
          },
        ),
      ),
    );
  }
}
