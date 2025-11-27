import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/article_bloc/article_bloc.dart';
import 'package:mobile_version/blocs/article_detail_bloc.dart/article_detail_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/blocs/user_bloc/user_bloc.dart';
import 'package:mobile_version/pages/article_page.dart';
import 'package:mobile_version/pages/author_page.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';
import 'package:mobile_version/pages/home_page.dart';
import 'package:mobile_version/pages/login/login_page.dart';
import 'package:mobile_version/pages/my_account_page.dart';
import 'package:mobile_version/widgets/primary_button.dart';
import 'package:mobile_version/widgets/tab_bar_widget.dart';

final class HomePageFactory {
  static Widget buildHomePage(BuildContext context) {
    return TabBarWidget(
      widgetOptions: [
        _buildArticleList(context),
        _buildFavoritedArticles(context),
        _buildProfilePage(context),
      ],
      onTabTapped: (int index) {
        // if (index == 2) {
        //   context.read<MyAccountBloc>().add(GetMyAccountEvent());
        // }
      },
    );
  }

  static Widget _buildArticleList(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserStateLoggedIn) {
          context.read<MyAccountBloc>().add(GetMyAccountEvent());
        }
      },
      builder: (context, userState) {
        final isLoggedIn = userState is UserStateLoggedIn;
        return BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, articleState) {
            if (articleState is ArticleStateLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (articleState is ArticleStateError) {
              return Center(child: Text(articleState.errorMessage));
            }
            if (articleState is ArticleStateSuccess) {
              return HomePage(
                onGoToLogin:
                    () => Navigator.of(context).pushNamed(LoginPage.route),
                isLoggedIn: isLoggedIn,
                onLogout: () {
                  context.read<UserBloc>().add(UserLoggedOutEvent());
                  context.read<MyAccountBloc>().add(
                    UnauthenticatedMyAccountEvent(),
                  );
                },
                articles: articleState.articles,
                onGoToArticle: (article) {
                  context.read<ArticleDetailBloc>().add(
                    GetArticleDetailEvent(id: article.id),
                  );
                  Navigator.of(context).pushNamed(ArticlePage.route);
                },
                onGoToAuthor: (String id) {
                  Navigator.of(context).pushNamed(AuthorPage.route);
                },
                authorBuilder: () {
                  return BlocBuilder<MyAccountBloc, MyAccountState>(
                    builder: (context, state) {
                      if (state is MyAccountStateSuccess) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(120),
                                    child: Image.network(
                                      state.author.authorImageUrl,
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Icon(Icons.person),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(
                                          context,
                                        ).pushNamed(CreateArticlePage.route);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Text("What's on your mind?"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }

  static Widget _buildFavoritedArticles(BuildContext context) {
    return Placeholder();
  }

  static Widget _buildProfilePage(BuildContext context) {
    return BlocListener<MyAccountBloc, MyAccountState>(
      listener: (context, state) {
        if (state is MyArticleStateDeleted) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<MyAccountBloc, MyAccountState>(
        builder: (context, state) {
          if (state is MyAccountStateSuccess) {
            return MyAccountPage(
              articles: state.articles,
              onGoToArticle: (article) {
                context.read<ArticleDetailBloc>().add(
                  GetArticleDetailEvent(id: article.id),
                );
                Navigator.of(context).pushNamed(ArticlePage.route);
              },
              author: state.author,
              showActionsSheet: (String id) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IntrinsicHeight(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 16,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Row(
                                  spacing: 8,
                                  children: [
                                    Icon(Icons.edit),
                                    Text('Edit post'),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<MyAccountBloc>().add(
                                    DeleteMyArticleEvent(id: id),
                                  );
                                },
                                icon: Row(
                                  spacing: 8,
                                  children: [
                                    Icon(Icons.delete),
                                    Text('Delete post'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is MyAccountStateLoading) {
            return CircularProgressIndicator.adaptive();
          }
          if (state is MyAccountStateError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is MyAccountStateUnauthenticated) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginPage.route);
                    },
                    title: ' Go to Login',
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
