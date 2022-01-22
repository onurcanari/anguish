import 'package:depression/l10n/l10n.dart';
import 'package:depression/posts_overview/bloc/posts_overview_bloc.dart';
import 'package:depression/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsOverviewPage extends StatelessWidget {
  const PostsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postRepository = context.read<PostRepository>();
    return BlocProvider(
      create: (_) => PostsOverviewBloc(postRepository: postRepository)
        ..add(PostOverviewFetch()),
      child: const PostsOverviewView(),
    );
  }
}

class PostsOverviewView extends StatelessWidget {
  const PostsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: BlocBuilder<PostsOverviewBloc, PostsOverviewState>(
          builder: (context, state) {
        if (state is PostsOverviewSuccess) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ListTile(
                title: Text(post.content),
                subtitle: Text(post.reactions.toString()),
              );
            },
          );
        } else if (state is PostsOverviewFailure) {
          return Center(
            child: Text("l10n.error"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text('1', style: theme.textTheme.headline1);
  }
}
