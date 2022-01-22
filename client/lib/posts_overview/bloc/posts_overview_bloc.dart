import 'package:bloc/bloc.dart';
import 'package:depression/models/models.dart';
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
        final postsResponse = await postRepository.getPosts();
        emit(
          PostsOverviewSuccess(
              posts: postsResponse.items,
              fetchMore: postsResponse.fetchNextPage),
        );
      } catch (e) {
        emit(PostsOverviewFailure(e.toString()));
      }
    });
  }

  final PostRepository postRepository;
}
