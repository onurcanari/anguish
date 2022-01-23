import 'package:cloud_functions/cloud_functions.dart';
import 'package:post_repository/src/models/models.dart';

/// {@template post_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class PostRepository {
  /// {@macro post_repository}
  PostRepository() {
    _initializeCallables();
  }

  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  late HttpsCallable _createPostCallable;
  late HttpsCallable _getPostCallable;
  late HttpsCallable _getPostsCallable;
  late HttpsCallable _deletePostCallable;
  late HttpsCallable _reactToPostCallable;

  Future<PagedPostsResponse> getPosts() async {
    final httpsCallableResult =
        await _getPostsCallable<Map<dynamic, dynamic>>();
    final pagedPostsMap = Map<String, dynamic>.from(httpsCallableResult.data);
    return PagedPostsResponse.fromMap(pagedPostsMap);
  }

  Future<Post> getPost() async {
    final httpsCallableResult = await _getPostCallable<String>(
        <String, dynamic>{"postId": "OI53IxXPdydKZjluqhME"});
    return Post.fromMap(const <String, dynamic>{});
  }

  void _initializeCallables() {
    _createPostCallable = _functions.httpsCallable('reatePost');
    _getPostCallable = _functions.httpsCallable('getPost');
    _getPostsCallable = _functions.httpsCallable('getPosts');
    _deletePostCallable = _functions.httpsCallable('deletePost');
    _reactToPostCallable = _functions.httpsCallable('reactToPost');
  }
}