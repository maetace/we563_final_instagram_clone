// lib/services/post_service.dart

// ===============================
// POST SERVICE (ABSTRACT)
// ===============================

import '/models/post_item_model.dart';

/// PostService
/// - Abstract interface for post service
/// - Implemented by: PostServiceMock
abstract class PostService {
  /// Get posts
  /// - Supports pagination
  /// - Default pageSize = 3
  Future<List<PostItem>> getPostItems({int pageIndex = 1, int pageSize = 3});

  /// Create new post item
  Future<PostItem> createPostItem({required String description, required List<String> images});
}
