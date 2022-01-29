import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:post_repository/src/models/models.dart';

/// {@template post_repository}
/// Post Repository
/// {@endtemplate}
class PostRepository {
  /// {@macro post_repository}
  PostRepository() {
    initialize();
  }

  final _config = FirebaseRemoteConfig.instance;
  final _functions = FirebaseFunctions.instance;

  late HttpsCallable _createPostCallable;
  late HttpsCallable _getPostCallable;
  late HttpsCallable _getPostsCallable;
  late HttpsCallable _deletePostCallable;
  late HttpsCallable _reactToPostCallable;

  /// Gets latest posts.
  Future<PagedPostsResponse> getPosts({DateTime? afterDate}) async {
    final parameters = <String, dynamic>{};

    if (afterDate != null) {
      parameters['afterDate'] = afterDate.toString();
    }

    final httpsCallableResult =
        await _getPostsCallable<Map<dynamic, dynamic>>(parameters);
    final pagedPostsMap = Map<String, dynamic>.from(httpsCallableResult.data);
    return PagedPostsResponse.fromMap(pagedPostsMap);
  }

  Future<Post> getPost(String postId) async {
    final httpsCallableResult =
        await _getPostCallable<String>(<String, dynamic>{"postId": postId});
    return Post.fromMap(const <String, dynamic>{});
  }

  /// Returns available tags for posts.
  List<Tag> getTags() {
    final tagsMap =
        jsonDecode(_config.getString('tags')) as Map<String, String>?;

    if (tagsMap == null) {
      return [];
    }

    return tagsMap.entries.map((e) => Tag(int.parse(e.key), e.value)).toList();
  }

  /// Returns available preset texts for posts.
  List<PresetText> getPresetTexts() {
    final presetTextsMap =
        jsonDecode(_config.getString('presetTexts')) as Map<String, String>?;

    if (presetTextsMap == null) {
      return [];
    }

    return presetTextsMap.entries
        .map((e) => PresetText(int.parse(e.key), e.value))
        .toList();
  }

  Future<void> initialize() async {
    _createPostCallable = _functions.httpsCallable('createPost');
    _getPostCallable = _functions.httpsCallable('getPost');
    _getPostsCallable = _functions.httpsCallable('getPosts');
    _deletePostCallable = _functions.httpsCallable('deletePost');
    _reactToPostCallable = _functions.httpsCallable('reactToPost');

    await _config.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 24),
      ),
    );
    await _config.fetchAndActivate();
  }
}
