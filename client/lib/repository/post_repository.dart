import 'package:cloud_functions/cloud_functions.dart';
import 'package:depression/models/models.dart';

class PostRepository {
  PostRepository() {
    initializeCallables();
  }

  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  late HttpsCallable _createPostCallable;
  late HttpsCallable _getPostCallable;
  late HttpsCallable _getPostsCallable;
  late HttpsCallable _deletePostCallable;
  late HttpsCallable _reactToPostCallable;

  Future<PagedPostsResponse> getPosts() async {
    final postResponse = await getPost();
    final httpsCallableResult = await _getPostsCallable<Object>();
    return PagedPostsResponse.fromMap(const <String, dynamic>{});
  }

  Future<PagedPostsResponse> getPost() async {
    final httpsCallableResult = await _getPostCallable<String>(
        <String, dynamic>{"postId": "OI53IxXPdydKZjluqhME"});
    return PagedPostsResponse.fromMap(const <String, dynamic>{});
  }

  void initializeCallables() {
    _createPostCallable = _functions.httpsCallable('reatePost');
    _getPostCallable = _functions.httpsCallable('getPost');
    _getPostsCallable = _functions.httpsCallable('getPosts');
    _deletePostCallable = _functions.httpsCallable('deletePost');
    _reactToPostCallable = _functions.httpsCallable('reactToPost');
  }
}
