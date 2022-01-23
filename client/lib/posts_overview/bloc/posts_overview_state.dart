part of 'posts_overview_bloc.dart';

@immutable
abstract class PostsOverviewState {}

class PostsOverviewInitial extends PostsOverviewState {}

class PostsOverviewSuccess extends PostsOverviewState {
  PostsOverviewSuccess({required this.posts, required this.fetchMore});

  final List<Post> posts;
  final bool fetchMore;
}

class PostsOverviewFailure extends PostsOverviewState {
  PostsOverviewFailure(this.errorMessage);

  final String errorMessage;
}
