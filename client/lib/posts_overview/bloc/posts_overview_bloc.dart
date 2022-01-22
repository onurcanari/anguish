import 'package:bloc/bloc.dart';
import 'package:depression/models/models.dart';
import 'package:depression/posts_overview/post_overview.dart';
import 'package:depression/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'posts_overview_event.dart';
part 'posts_overview_state.dart';

class PostsOverviewBloc extends Bloc<PostsOverviewEvent, PostsOverviewState> {
  PostsOverviewBloc({required this.postRepository})
      : super(PostsOverviewInitial()) {
    on<PostOverviewFetch>((event, emit) async {
      emit(PostsOverviewInitial());
      try {
        final posts = await postRepository.getPosts();
        emit(PostsOverviewSuccess(posts: [], fetchMore: false));
      } catch (e) {
        emit(PostsOverviewFailure(e.toString()));
      }
    });
  }

  final PostRepository postRepository;
}
