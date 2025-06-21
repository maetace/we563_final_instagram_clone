// lib/services/comment_service.dart

import '/models/comment_item_model.dart';

abstract class CommentService {
  Future<List<CommentItem>> getComments(String postId, {int pageIndex = 1, int pageSize = 3});

  Future<CommentItem> createCommentItem({required String postId, required String message});
}
