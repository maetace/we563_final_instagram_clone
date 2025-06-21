// lib/data/comment_data_mock.dart

import '../models/comment_item_model.dart';
import '/utils.dart';

final List<CommentItem> mockComments = [
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'I love it',
    createdDate: DateTime.now().subtract(Duration(days: 7)),
  ),
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'It\'s OK',
    createdDate: DateTime.now().subtract(Duration(days: 6)),
  ),
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'Hahaha',
    createdDate: DateTime.now().subtract(Duration(days: 5)),
  ),
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'Wow',
    createdDate: DateTime.now().subtract(Duration(days: 4)),
  ),
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'Hello',
    createdDate: DateTime.now().subtract(Duration(days: 3)),
  ),
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'That\'s right',
    createdDate: DateTime.now().subtract(Duration(days: 2)),
  ),
  CommentItem(
    id: 'comment.${randomString(30)}',
    postId: 'post.demo',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    message: 'Hehehe',
    createdDate: DateTime.now().subtract(Duration(days: 1)),
  ),
];
