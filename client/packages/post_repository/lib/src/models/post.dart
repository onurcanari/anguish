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
        createdAt = DateTime.parse(map['createdAt'] as String),
        anonymous = map['anonymous'] as bool,
        givenReactionId = map['givenReactionId'] as int?,
        reactions = Map<String, int?>.from(map['reactions'] as Map);

  final String id;
  final String content;
  final List<int> tags;
  final DateTime createdAt;
  final bool anonymous;
  final int? givenReactionId;
  final Map<String, int?>? reactions;

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
