import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.content,
    required this.tags,
    required this.createdAt,
    required this.anonymous,
    this.givenReactionId,
    this.reactions,
  });

  Post.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        content = map['content'] as String,
        tags = List<int>.from(map['tags'] as List),
        createdAt = map['createdAt'] as String,
        anonymous = map['anonymous'] as bool,
        givenReactionId = map['givenReactionId'] as int,
        reactions = map['reactions'] as Map<String, int>;

  final String id;
  final String content;
  final List<int> tags;
  final String createdAt;
  final bool anonymous;
  final int? givenReactionId;
  final Map<String, int>? reactions;

  @override
  List<Object?> get props => [
        id,
        content,
        tags,
        createdAt,
        anonymous,
        givenReactionId,
        reactions,
      ];
}
