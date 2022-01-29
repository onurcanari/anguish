import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:post_repository/post_repository.dart';

class PostWidget extends StatelessWidget {
  PostWidget(this._post, {Key? key}) : super(key: key);

  final Post _post;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final List<String> _items = ['Depression', 'Death', 'Chaos', 'Pain', 'Hate'];

  @override
  Widget build(BuildContext context) {
    _items.shuffle();
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Row(
            children: [
              Image.network(
                'https://picsum.photos/50?${DateTime.now().millisecondsSinceEpoch.toString()}',
              ),
              Text("User Name")
            ],
          ),
          createTags(_items.sublist(0, Random().nextInt(_items.length))),
          Text(_post.content),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(_post.createdAt.toString()),
          )
        ],
      ),
    );
  }

  Widget createTags(List<String> items) {
    return Tags(
      key: _tagStateKey,
      itemCount: items.length,
      horizontalScroll: true,
      itemBuilder: (int index) {
        final item = items[index];
        return ItemTags(
          pressEnabled: false,
          key: Key(index.toString()),
          index: index,
          title: item,
          customData: item,
          textStyle: const TextStyle(
            fontSize: 12,
          ),
          combine: ItemTagsCombine.onlyText,
        );
      },
    );
  }
}
