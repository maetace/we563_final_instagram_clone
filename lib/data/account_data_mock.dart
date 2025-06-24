// lib/data/account_data_mock.dart

// ===============================
// MOCK DATA: ACCOUNTS
// ===============================

import '/models/account_model.dart';

// ===============================
// LIST OF MOCK ACCOUNTS
// ===============================

final List<Account> mockAccounts = [
  // ===== Yelena Belova =====
  Account(
    uid: 'U001',
    username: 'yelena',
    password: 'P@ssw0rd',
    email: 'yelena.b@thunderbolts.org',
    mobile: '+66123456001',
    avatar: 'assets/avatars_mock/yelena.jpg',
    fullname: 'Yelena Belova',
    birthday: DateTime(1989, 6, 15),
    gender: Gender.female,
    status: AccountStatus.active,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Bucky Barnes =====
  Account(
    uid: 'U002',
    username: 'buckybarnes',
    password: 'P@ssw0rd',
    email: 'james.b@thunderbolts.org',
    mobile: '+66123456002',
    avatar: 'assets/avatars_mock/buckybarnes.jpg',
    fullname: 'James Barnes',
    birthday: DateTime(1917, 3, 10),
    gender: Gender.male,
    status: AccountStatus.active,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Red Guardian =====
  Account(
    uid: 'U003',
    username: 'redguardian',
    password: 'P@ssw0rd',
    email: 'alexei.s@thunderbolts.org',
    mobile: '+66123456003',
    avatar: 'assets/avatars_mock/redguardian.jpg',
    fullname: 'Alexei Shostakov',
    birthday: DateTime(1967, 11, 22),
    gender: Gender.male,
    status: AccountStatus.active,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== US Agent =====
  Account(
    uid: 'U004',
    username: 'usagent',
    password: 'P@ssw0rd',
    email: 'john.w@thunderbolts.org',
    mobile: '+66123456004',
    avatar: 'assets/avatars_mock/usagent.jpg',
    fullname: 'John Walker',
    birthday: DateTime(1986, 7, 10),
    gender: Gender.male,
    status: AccountStatus.active,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Ghost =====
  Account(
    uid: 'U005',
    username: 'ghost',
    password: 'P@ssw0rd',
    email: 'ava.s@thunderbolts.org',
    mobile: '+66123456005',
    avatar: 'assets/avatars_mock/ghost.jpg',
    fullname: 'Ava Starr',
    birthday: DateTime(1988, 8, 24),
    gender: Gender.female,
    status: AccountStatus.active,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Taskmaster =====
  Account(
    uid: 'U006',
    username: 'taskmaster',
    password: 'P@ssw0rd',
    email: 'antonia.d@thunderbolts.org',
    mobile: '+66123456006',
    avatar: 'assets/avatars_mock/taskmaster.jpg',
    fullname: 'Antonia Dreykov',
    birthday: DateTime(1996, 5, 19),
    gender: Gender.female,
    status: AccountStatus.deleted,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Just Bob =====
  Account(
    uid: 'U007',
    username: 'justbob',
    password: 'P@ssw0rd',
    email: 'bob.r@thunderbolts.org',
    mobile: '+66123456007',
    avatar: 'assets/avatars_mock/justbob.jpg',
    fullname: 'Bob Reynolds',
    birthday: DateTime(1987, 4, 10),
    gender: Gender.male,
    status: AccountStatus.pending,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Valentina =====
  Account(
    uid: 'U008',
    username: 'valentina',
    password: 'P@ssw0rd',
    email: 'valentina.a@thunderbolts.org',
    mobile: '+66123456008',
    avatar: 'assets/avatars_mock/valentina.jpg',
    fullname: 'Valentina Allegra de Fontaine',
    birthday: DateTime(1971, 12, 19),
    gender: Gender.female,
    status: AccountStatus.active,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Melissa Gold =====
  Account(
    uid: 'U009',
    username: 'melgold',
    password: 'P@ssw0rd',
    email: 'melissa.g@thunderbolts.org',
    mobile: '+66123456009',
    avatar: 'assets/avatars_mock/melgold.jpg',
    fullname: 'Melissa Gold',
    birthday: DateTime(1994, 10, 28),
    gender: Gender.female,
    status: AccountStatus.inactive,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),

  // ===== Baron Zemo =====
  Account(
    uid: 'U010',
    username: 'baronzemo',
    password: 'P@ssw0rd',
    email: 'helmut.z@thunderbolts.org',
    mobile: '+66123456010',
    avatar: 'assets/avatars_mock/baronzemo.jpg',
    fullname: 'Helmut Zemo',
    birthday: DateTime(1978, 9, 3),
    gender: Gender.male,
    status: AccountStatus.banned,
    created: DateTime(2025, 5, 25),
    updated: DateTime(2025, 5, 25),
  ),
];
