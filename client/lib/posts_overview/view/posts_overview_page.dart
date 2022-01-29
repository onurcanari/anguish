import 'package:depression/l10n/l10n.dart';
import 'package:depression/posts_overview/bloc/posts_overview_bloc.dart';
import 'package:depression/posts_overview/view/posts_overview_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';

class PostsOverviewPage extends StatelessWidget {
  const PostsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postRepository = context.read<PostRepository>();
    return BlocProvider(
      create: (_) => PostsOverviewBloc(postRepository: postRepository),
      child: const PostsOverviewView(),
    );
  }
}

class PostsOverviewView extends StatelessWidget {
  const PostsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return const PostsOverviewList();
  }
}
