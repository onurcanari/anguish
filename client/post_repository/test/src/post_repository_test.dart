// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:post_repository/post_repository.dart';

void main() {
  group('PostRepository', () {
    test('can be instantiated', () {
      expect(PostRepository(), isNotNull);
    });
  });
}
