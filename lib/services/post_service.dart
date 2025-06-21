// lib/services/post_service.dart

import '/models/post_item_model.dart';

abstract class PostService {
  Future<List<PostItem>> getPostItems({int pageIndex = 1, int pageSize = 3});

  Future<PostItem> createPostItem({required String description, required List<String> images});
}
