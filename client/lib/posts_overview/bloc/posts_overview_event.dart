part of 'posts_overview_bloc.dart';

@immutable
abstract class PostsOverviewEvent {}

class PostOverviewFetch extends PostsOverviewEvent {
  PostOverviewFetch({this.afterDate});

  final DateTime? afterDate;
}
