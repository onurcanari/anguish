import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';

part 'posts_overview_event.dart';
part 'posts_overview_state.dart';

class PostsOverviewBloc extends Bloc<PostsOverviewEvent, PostsOverviewState> {
  PostsOverviewBloc({required this.postRepository})
      : super(PostsOverviewInitial()) {
    on<PostOverviewFetch>((event, emit) async {
      emit(PostsOverviewInitial());
      try {
        final postsResponse =
            await postRepository.getPosts(afterDate: event.afterDate);
        emit(
          PostsOverviewSuccess(
            posts: postsResponse.items,
            fetchMore: postsResponse.fetchNextPage,
          ),
        );
      } catch (e) {
        emit(PostsOverviewFailure(e.toString()));
      }
    });
  }

  final PostRepository postRepository;
}
