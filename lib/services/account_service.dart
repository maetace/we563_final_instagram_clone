// lib/services/account_service.dart

// ===============================
// ACCOUNT SERVICE (ABSTRACT)
// ===============================

import '../models/account_model.dart';

/// AccountService
/// - Abstract interface for account service
/// - Implemented by: AccountServiceMock
abstract class AccountService {
  /// Login user
  Future<void> logIn(String username, String password);

  /// Sign up new user
  Future<void> signUp(String uid, String username, String password, String? avatar);

  /// Save session (uid + token)
  Future<void> saveSession({required String uid, required String token});

  /// Check if logged in
  Future<bool> isLoggedIn();

  /// Log out user
  Future<void> logOut();

  /// Get current account (session)
  Future<CurrentAccount?> getCurrentAccount();

  /// Find account by username
  Future<Account?> findAccountByUsername(String username);
}
