// lib/data/comment_data_mock.dart

// ===============================
// MOCK DATA: COMMENTS
// ===============================

import '/models/comment_item_model.dart';
import '/utils.dart';
import '/data/account_data_mock.dart';
import '/data/post_data_mock.dart';

// ===============================
// LIST OF MOCK COMMENTS
// ===============================

final List<CommentItem> mockComments = List.generate(60, (index) {
  // Assign user and post in round-robin fashion
  final user = mockAccounts[index % mockAccounts.length];
  final post = mockPosts[index % mockPosts.length];

  // Comment message pool
  final messages = [
    'Wow this is amazing! 😍',
    'I love this!',
    'Hahaha, this made my day 🤣',
    'Great idea 💡',
    '🔥🔥🔥',
    'Can’t wait to try this!',
    'Looks interesting 👀',
    'This app is awesome!',
    'So cool 😎',
    'Totally agree! 👍',
    '👏👏👏',
    'LOL 😂',
    'Yessss!',
    'Well said 👏',
    'Where can I get this?',
    'Just what I needed!',
    'Amazing work 👏',
    'Thanks for sharing 🙏',
    'Nice!',
    'Wow!',
  ];

  return CommentItem(
    id: 'comment.${randomString(30)}',
    postId: post.id,
    ownerName: user.username,
    ownerImage: user.avatar,
    message: messages[index % messages.length],
    createdDate: DateTime.now().subtract(Duration(days: index % 7, hours: index % 12, minutes: index % 60)),
  );
});
