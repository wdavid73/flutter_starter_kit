import 'package:flutter_test/flutter_test.dart';
import 'package:platform_session/platform_session.dart';

void main() {
  const json = {'id': '1', 'email': 'a@b.co', 'fullName': 'Ada Lovelace'};

  test('userJsonToModel builds a UserModel from JSON', () {
    final user = UserMapper.userJsonToModel(json);

    expect(user.id, '1');
    expect(user.email, 'a@b.co');
    expect(user.fullName, 'Ada Lovelace');
  });

  test('toJson is the inverse of userJsonToModel', () {
    expect(UserMapper.toJson(UserMapper.userJsonToModel(json)), json);
  });

  test('UserModel is a User entity', () {
    expect(UserModel.fromJson(json), isA<User>());
  });
}
