// lib/services/account_service.dart

import '../models/account_model.dart';

abstract class AccountService {
  Future<void> logIn(String username, String password);
  Future<void> signUp(String uid, String username, String password, String? avatar);
  Future<void> saveSession({required String uid, required String token});
  Future<bool> isLoggedIn();
  Future<void> logOut();
  Future<CurrentAccount?> getCurrentAccount();
  Future<Account?> findAccountByUsername(String username);
}
