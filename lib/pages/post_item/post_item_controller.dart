// lib/pages/post_item/post_item_controller.dart

// ===============================
// CONTROLLER: POST ITEM PAGE
// ===============================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/comment_item_model.dart';
import '/models/post_item_model.dart';
import '/services/comment_service.dart';
import '/services/account_service.dart';
import '/services/account_service_mock.dart'; // ⭐️ ใช้ currentUser

// ===============================
// POST ITEM CONTROLLER
// ===============================

class PostItemController extends GetxController {
  PostItemController({required PostItem postItem}) {
    _postItem = postItem;
  }

  // ===============================
  // STATE: POST ITEM
  // ===============================

  late final PostItem _postItem;
  PostItem get postItem => _postItem;

  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;

  // ===============================
  // SERVICE
  // ===============================

  late final AccountService _account;
  late final CommentService _commentService;

  // ===============================
  // STATE: COMMENTS
  // ===============================

  final _commentItems = <CommentItem>[].obs;
  List<CommentItem> get commentItems => _commentItems;

  final _pageIndex = 1.obs;
  int get pageIndex => _pageIndex.value;
  final _pageSize = 5;
  var _hasMoreItems = false;
  final _loading = false.obs;
  bool get loading => _loading.value;

  final scrollController = ScrollController();

  // ===============================
  // STATE: COMMENT BOX
  // ===============================

  final _canComment = false.obs;
  bool get canComment => _canComment.value;
  final commentTextEditingController = TextEditingController();

  var _isCommentCreating = false;

  // ===============================
  // INIT / CLOSE
  // ===============================

  @override
  void onInit() {
    _account = Get.find<AccountService>();
    _commentService = Get.find<CommentService>();

    scrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void onReady() {
    _loadCommentItems();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    commentTextEditingController.dispose();
    super.onClose();
  }

  // ===============================
  // CAROUSEL
  // ===============================

  void onPageChanged(int index) {
    _currentPage.value = index;
  }

  // ===============================
  // LOAD COMMENTS
  // ===============================

  Future<void> _loadCommentItems() async {
    if (_loading.value) return;

    _loading.value = true;
    try {
      if (_pageIndex.value == 1) {
        _commentItems.clear();
      }

      final newItems = await _commentService.getComments(
        _postItem.id,
        pageIndex: _pageIndex.value,
        pageSize: _pageSize,
      );

      if (newItems.isNotEmpty) {
        _commentItems.addAll(newItems);
      }

      _hasMoreItems = newItems.length >= _pageSize;
    } finally {
      _loading.value = false;
    }
  }

  void _onScroll() {
    final isAtBottom = scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100;

    if (isAtBottom && _hasMoreItems && !_loading.value) {
      _pageIndex.value++;
      _loadCommentItems();
    }
  }

  // ===============================
  // COMMENT BOX
  // ===============================

  void onCommentTextChanged(String text) {
    _validateComment();
  }

  void _validateComment() {
    _canComment.value = commentTextEditingController.text.trim().isNotEmpty && !_isCommentCreating;
  }

  Future<void> createComment() async {
    final text = commentTextEditingController.text.trim();
    if (text.isEmpty || _isCommentCreating) return;

    // Scroll to top
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);

    commentTextEditingController.clear();
    _isCommentCreating = true;
    _validateComment();

    try {
      final currentUser = (_account as AccountServiceMock).currentUser!;

      final newComment = CommentItem(
        id: 'comment.${DateTime.now().millisecondsSinceEpoch}',
        postId: _postItem.id,
        ownerName: currentUser.username,
        ownerImage: currentUser.avatar,
        message: text,
        createdDate: DateTime.now(),
      );

      _commentItems.insert(0, newComment);

      _postItem.comments++;
      update(); // ถ้ามี GetBuilder() จะ trigger
    } finally {
      _isCommentCreating = false;
      _validateComment();
    }
  }
}
