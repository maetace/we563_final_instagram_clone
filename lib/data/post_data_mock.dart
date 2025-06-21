// lib/data/post_data_mock.dart

import '/models/post_item_model.dart';
import '/utils.dart';

final List<PostItem> mockPosts = [
  PostItem(
    id: 'post.${randomString(30)}',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    images: [
      'assets/images/facebook.webp',
      'assets/images/instagram.webp',
      'assets/images/tiktok.webp',
      'assets/images/x.webp',
      'assets/images/threads.webp',
    ],
    likes: 100,
    comments: 10,
    description: 'What is your fav app?',
    createdDate: DateTime.now().subtract(Duration(days: 150)),
  ),
  PostItem(
    id: 'post.${randomString(30)}',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    images: ['assets/images/instagram.webp', 'assets/images/facebook.webp'],
    likes: 100,
    comments: 10,
    description: 'My 2 fav apps from META',
    createdDate: DateTime.now().subtract(Duration(days: 100)),
  ),
  PostItem(
    id: 'post.${randomString(30)}',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    images: ['assets/images/tiktok.webp'],
    likes: 50,
    comments: 100,
    description: 'Who loved this app like me!',
    createdDate: DateTime.now().subtract(Duration(days: 50)),
  ),
  PostItem(
    id: 'post.${randomString(30)}',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    images: ['assets/images/threads.webp', 'assets/images/x.webp'],
    likes: 1010,
    comments: 101,
    description: 'Threads or X?',
    createdDate: DateTime.now().subtract(Duration(days: 10)),
  ),
  PostItem(
    id: 'post.${randomString(30)}',
    ownerName: 'demouser',
    ownerImage: 'assets/images/avatar.webp',
    images: ['assets/images/x.webp'],
    likes: 150,
    comments: 110,
    description: 'I away from this app now!',
    createdDate: DateTime.now(),
  ),
];
