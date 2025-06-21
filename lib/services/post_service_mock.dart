// lib/services/post_service_mock.dart

import 'package:get/get.dart';
import '/utils.dart';
import '/models/post_item_model.dart';
import '/data/post_data_mock.dart';
import 'post_service.dart';

class PostServiceMock extends GetxService implements PostService {
  late List<PostItem> _items;

  @override
  void onInit() {
    _items = List<PostItem>.from(mockPosts);
    super.onInit();
  }

  @override
  Future<List<PostItem>> getPostItems({int pageIndex = 1, int pageSize = 3}) async {
    await 3.delay();
    var items = <PostItem>[];
    var index = (pageIndex - 1) * pageSize;
    while (index < _items.length) {
      items.add(_items[index]);
      if (items.length == pageSize) {
        break;
      }
      index++;
    }
    return items;
  }

  @override
  Future<PostItem> createPostItem({required String description, required List<String> images}) async {
    await 3.delay();
    var item = PostItem(
      id: 'post.${randomString(30)}',
      ownerName: 'demouser',
      ownerImage: 'assets/images/avatar.webp',
      images: images,
      likes: 0,
      comments: 0,
      description: description,
      createdDate: DateTime.now(),
    );
    _items.insert(0, item);
    return item;
  }
}
