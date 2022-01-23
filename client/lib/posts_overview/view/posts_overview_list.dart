import 'package:depression/l10n/l10n.dart';
import 'package:depression/posts_overview/post_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:post_repository/post_repository.dart';

class PostsOverviewList extends StatefulWidget {
  const PostsOverviewList() : super();

  @override
  State<PostsOverviewList> createState() => _PostsOverviewListState();
}

class _PostsOverviewListState extends State<PostsOverviewList> {
  final _pagingController =
      PagingController<DateTime?, Post>(firstPageKey: null);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<PostsOverviewBloc>()
          .add(PostOverviewFetch(afterDate: pageKey));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<PostsOverviewBloc, PostsOverviewState>(
      listener: (context, state) {
        if (state is PostsOverviewSuccess) {
          if (!state.fetchMore) {
            _pagingController.appendLastPage(state.posts);
            return;
          }

          _pagingController.appendPage(
            state.posts,
            state.posts.last.createdAt,
          );
        } else if (state is PostsOverviewFailure) {
          _pagingController.error = state.errorMessage;
        }
      },
      child: PagedListView<DateTime?, Post>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          animateTransitions: true,
          itemBuilder: (context, post, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(post.content),
              subtitle: Text(post.reactions.toString()),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
