// lib/services/account_service_mock.dart

// ===============================
// MOCK SERVICE: ACCOUNT
// ===============================

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '/models/account_model.dart';
import '/data/account_data_mock.dart';
import 'account_service.dart';

// ===============================
// ACCOUNT SERVICE (MOCK)
// ===============================

/// AccountServiceMock
/// - Implements AccountService
/// - Mock login, signup, logout
/// - Uses FlutterSecureStorage for session (uid, token)
class AccountServiceMock extends GetxService implements AccountService {
  final _secure = const FlutterSecureStorage();

  static const _keyUid = 'uid';
  static const _keyToken = 'token';

  Account? _currentUser;

  // ===============================
  // GETTER: CURRENT USER
  // ===============================

  Account? get currentUser => _currentUser;

  // ===============================
  // LOGIN
  // ===============================

  @override
  Future<void> logIn(String username, String password) async {
    await 1.delay();

    final account = mockAccounts.firstWhereOrNull(
      (a) => a.username == username && a.password == password && a.status == AccountStatus.active,
    );

    if (account == null) throw 'Invalid username or password';

    _currentUser = account;

    await saveSession(uid: account.uid, token: 'mock_token');
  }

  // ===============================
  // SIGN UP
  // ===============================

  @override
  Future<void> signUp(String uid, String username, String password, String? avatar) async {
    await 1.delay();

    final exists = mockAccounts.any((a) => a.username == username);
    if (exists) throw 'Username already exists';

    final now = DateTime.now();

    final newAccount = Account(
      uid: uid,
      username: username,
      password: password,
      email: '',
      mobile: '',
      avatar: avatar ?? 'assets/mock_avatars/default.jpg',
      fullname: username,
      birthday: DateTime(2000, 1, 1),
      gender: Gender.other,
      status: AccountStatus.active,
      created: now,
      updated: now,
    );

    mockAccounts.add(newAccount);

    _currentUser = newAccount;

    await saveSession(uid: uid, token: 'mock_token');
  }

  // ===============================
  // SAVE SESSION
  // ===============================

  @override
  Future<void> saveSession({required String uid, required String token}) async {
    await _secure.write(key: _keyUid, value: uid);
    await _secure.write(key: _keyToken, value: token);
  }

  // ===============================
  // CHECK LOGIN STATUS
  // ===============================

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secure.read(key: _keyToken);
    return token != null;
  }

  // ===============================
  // LOGOUT
  // ===============================

  @override
  Future<void> logOut() async {
    await _secure.delete(key: _keyUid);
    await _secure.delete(key: _keyToken);
    _currentUser = null;
  }

  // ===============================
  // GET CURRENT ACCOUNT
  // ===============================

  @override
  Future<CurrentAccount?> getCurrentAccount() async {
    final uid = await _secure.read(key: _keyUid);
    final account = mockAccounts.firstWhereOrNull((a) => a.uid == uid);
    _currentUser = account;
    return account != null ? CurrentAccount.fromAccount(account) : null;
  }

  // ===============================
  // FIND ACCOUNT BY USERNAME
  // ===============================

  @override
  Future<Account?> findAccountByUsername(String username) async {
    return mockAccounts.firstWhereOrNull((a) => a.username == username);
  }
}
