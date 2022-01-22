import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'models.dart';

@immutable
class PagedPostsResponse extends Equatable {
  const PagedPostsResponse({
    required this.numberOfItems,
    required this.fetchNextPage,
    required this.items,
  });

  factory PagedPostsResponse.fromMap(Map<String, dynamic> map) {
    return PagedPostsResponse(
      numberOfItems: map['numberOfItems'] as int,
      fetchNextPage: map['fetchNextPage'] as bool,
      items: (map['items'] as List<Map<String, dynamic>>) 
          .map((e) => Post.fromMap(e))
          .toList(),
    );
  }

  final int numberOfItems;
  final bool fetchNextPage;
  final List<Post> items;

  @override
  List<Object?> get props => [
        numberOfItems,
        fetchNextPage,
        items,
      ];
}
