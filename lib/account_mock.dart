import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

// === Models ===

enum Gender { male, female, other }

enum UserStatus { active, inactive, pending, deleted, banned }

class User {
  final String uid;
  final String username;
  final String password;
  final String email;
  final String mobile;
  final String avatar;
  final String fullname;
  final DateTime birthday;
  final Gender gender;
  final DateTime created;
  final DateTime updated;
  final UserStatus status;

  const User({
    required this.uid,
    required this.username,
    required this.password,
    required this.email,
    required this.mobile,
    required this.avatar,
    required this.fullname,
    required this.birthday,
    required this.gender,
    required this.created,
    required this.updated,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json['uid'],
    username: json['username'],
    password: json['password'],
    email: json['email'],
    mobile: json['mobile'],
    avatar: json['avatar'],
    fullname: json['fullname'],
    birthday: DateTime.parse(json['birthday']),
    gender: Gender.values.firstWhere((e) => e.name == json['gender']),
    created: DateTime.parse(json['created']),
    updated: DateTime.parse(json['updated']),
    status: UserStatus.values.firstWhere((e) => e.name == json['status']),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'password': password,
    'email': email,
    'mobile': mobile,
    'avatar': avatar,
    'fullname': fullname,
    'birthday': birthday.toIso8601String(),
    'gender': gender.name,
    'created': created.toIso8601String(),
    'updated': updated.toIso8601String(),
    'status': status.name,
  };
}

class CurrentUser {
  final String uid;
  final String username;
  final String fullname;
  final String avatar;

  const CurrentUser({required this.uid, required this.username, required this.fullname, required this.avatar});

  factory CurrentUser.fromUser(User user) =>
      CurrentUser(uid: user.uid, username: user.username, fullname: user.fullname, avatar: user.avatar);

  Map<String, dynamic> toJson() => {'uid': uid, 'username': username, 'fullname': fullname, 'avatar': avatar};
}

// === Data ===

final List<User> users = [
  User(
    uid: 'U001',
    username: 'yelena',
    password: 'P@ssw0rd',
    email: 'yelena.b@thunderbolts.org',
    mobile: '061-565-6501',
    avatar: 'assets/mock_avatars/yelena.jpg',
    fullname: 'Yelena Belova',
    birthday: DateTime(1989, 6, 15),
    gender: Gender.female,
    created: DateTime(2025, 5, 25, 10),
    updated: DateTime(2025, 5, 25, 10),
    status: UserStatus.active,
  ),
  User(
    uid: 'U002',
    username: 'buckybarnes',
    password: 'P@ssw0rd',
    email: 'james.b@thunderbolts.org',
    mobile: '061-565-6502',
    avatar: 'assets/mock_avatars/buckybarnes.jpg',
    fullname: 'James Barnes',
    birthday: DateTime(1917, 3, 10),
    gender: Gender.male,
    created: DateTime(2025, 5, 25, 10),
    updated: DateTime(2025, 5, 25, 10),
    status: UserStatus.active,
  ),
];

// === Service Interface ===

abstract class AccountService {
  Future<void> logIn(String username, String password);
  Future<void> signUp(String uid, String username, String password, String? avatar);
  Future<void> saveSession({required String uid, required String token});
  Future<bool> isLoggedIn();
  Future<void> logOut();
  Future<CurrentUser?> getCurrentUser();
  Future<User?> findUserByUsername(String username);
}

// === Service Implementation ===

class AccountServiceMock extends GetxService implements AccountService {
  final _secure = const FlutterSecureStorage();

  static const _keyUid = 'uid';
  static const _keyToken = 'token';

  @override
  Future<void> logIn(String username, String password) async {
    await 1.delay();

    final user = users.firstWhereOrNull(
      (u) => u.username == username && u.password == password && u.status == UserStatus.active,
    );
    if (user == null) throw 'Invalid username or password';

    await saveSession(uid: user.uid, token: 'mock_token');
  }

  @override
  Future<void> signUp(String uid, String username, String password, String? avatar) async {
    await 1.delay();

    final exists = users.any((u) => u.username == username);
    if (exists) throw 'Username already exists';

    final now = DateTime.now();

    final newUser = User(
      uid: uid,
      username: username,
      password: password,
      email: '',
      mobile: '',
      avatar: avatar ?? 'assets/mock_avatars/default.jpg',
      fullname: username,
      birthday: DateTime(2000, 1, 1),
      gender: Gender.other,
      created: now,
      updated: now,
      status: UserStatus.active,
    );

    users.add(newUser);

    await saveSession(uid: uid, token: 'mock_token');
  }

  @override
  Future<void> saveSession({required String uid, required String token}) async {
    await _secure.write(key: _keyUid, value: uid);
    await _secure.write(key: _keyToken, value: token);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _secure.read(key: _keyToken);
    return token != null;
  }

  @override
  Future<void> logOut() async {
    await _secure.delete(key: _keyUid);
    await _secure.delete(key: _keyToken);
  }

  @override
  Future<CurrentUser?> getCurrentUser() async {
    final uid = await _secure.read(key: _keyUid);
    final user = users.firstWhereOrNull((u) => u.uid == uid);
    return user != null ? CurrentUser.fromUser(user) : null;
  }

  @override
  Future<User?> findUserByUsername(String username) async {
    return users.firstWhereOrNull((u) => u.username == username);
  }
}
