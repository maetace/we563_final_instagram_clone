// lib/data/post_data_mock.dart

import '/models/post_item_model.dart';
import '/utils.dart';
import '/data/account_data_mock.dart';

final List<PostItem> mockPosts = List.generate(12, (index) {
  final user = mockAccounts[index % mockAccounts.length];

  final descriptions = [
    'What is your fav app? 🤔',
    'My 2 fav apps from META 🚀',
    'Who loved this app like me! 😍',
    'Threads or X? 🤷‍♂️',
    'Taking a break today 🏖️',
    'Coffee and code ☕👨‍💻',
    'Weekend vibes 🌞',
    'Productivity mode on 💻',
    'Learning Flutter 🚀',
    'Throwback 📸',
    'Sharing some memories 💕',
    'Feeling good today ✨',
  ];

  final images = [
    ['assets/images/001.webp', 'assets/images/002.webp', 'assets/images/003.webp', 'assets/images/004.webp'],
    ['assets/images/005.webp', 'assets/images/006.webp'],
    ['assets/images/002.webp'],
    ['assets/images/003.webp', 'assets/images/004.webp', 'assets/images/005.webp'],
    ['assets/images/006.webp'],
  ];

  return PostItem(
    id: 'post.${randomString(30)}',
    ownerName: user.username,
    ownerImage: user.avatar,
    images: images[index % images.length],
    likes: 50 + (index * 37) % 500,
    comments: 10 + (index * 13) % 40,
    description: descriptions[index % descriptions.length],
    createdDate: DateTime.now().subtract(Duration(days: index * 2, hours: index * 3)),
  );
});
