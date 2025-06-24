// lib/models/account_model.dart

// ===============================
// ACCOUNT MODEL
// ===============================

// ===============================
// ENUMS
// ===============================

/// Gender enum
enum Gender { male, female, other }

/// Account status enum
enum AccountStatus { active, inactive, pending, deleted, banned }

// ===============================
// ACCOUNT MODEL CLASS
// ===============================

/// Account model
/// - Used for user profile, auth, display in app
class Account {
  final String uid;
  final String username;
  final String password;
  final String email;
  final String mobile;
  final String avatar;
  final String fullname;
  final DateTime birthday;
  final Gender gender;
  final AccountStatus status;
  final DateTime created;
  final DateTime updated;

  const Account({
    required this.uid,
    required this.username,
    required this.password,
    required this.email,
    required this.mobile,
    required this.avatar,
    required this.fullname,
    required this.birthday,
    required this.gender,
    required this.status,
    required this.created,
    required this.updated,
  });

  /// From JSON
  factory Account.fromJson(Map<String, dynamic> json) => Account(
    uid: json['uid'],
    username: json['username'],
    password: json['password'],
    email: json['email'],
    mobile: json['mobile'],
    avatar: json['avatar'],
    fullname: json['fullname'],
    birthday: DateTime.parse(json['birthday']),
    gender: Gender.values.firstWhere((e) => e.name == json['gender']),
    status: AccountStatus.values.firstWhere((e) => e.name == json['status']),
    created: DateTime.parse(json['created']),
    updated: DateTime.parse(json['updated']),
  );

  /// To JSON
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
    'status': status.name,
    'created': created.toIso8601String(),
    'updated': updated.toIso8601String(),
  };
}

// ===============================
// CURRENT ACCOUNT CLASS
// ===============================

/// CurrentAccount (session profile)
/// - Used for logged-in user (lightweight)
class CurrentAccount {
  final String uid;
  final String username;
  final String fullname;
  final String avatar;

  const CurrentAccount({required this.uid, required this.username, required this.fullname, required this.avatar});

  /// Create from Account
  factory CurrentAccount.fromAccount(Account account) =>
      CurrentAccount(uid: account.uid, username: account.username, fullname: account.fullname, avatar: account.avatar);

  /// To JSON
  Map<String, dynamic> toJson() => {'uid': uid, 'username': username, 'fullname': fullname, 'avatar': avatar};
}
