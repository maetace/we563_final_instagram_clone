// lib/services/comment_service.dart

// ===============================
// COMMENT SERVICE (ABSTRACT)
// ===============================

import '/models/comment_item_model.dart';

/// CommentService
/// - Abstract interface for comment service
/// - Implemented by: CommentServiceMock
abstract class CommentService {
  /// Get comments by postId
  /// - Supports pagination
  /// - Default pageSize = 3
  Future<List<CommentItem>> getComments(String postId, {int pageIndex = 1, int pageSize = 3});

  /// Create new comment item
  Future<CommentItem> createCommentItem({required String postId, required String message});
}
