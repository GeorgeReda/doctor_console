import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRemoteDataSource {
  Future<Unit> deleteOldSession();
  Future<User> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Account account;

  LoginRemoteDataSourceImpl({required this.account});

  @override
  Future<User> login(String email, String password) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );

      final User user = await account.get();

      return user;
    } on AppwriteException {
      rethrow;
    }
  }

  @override
  Future<Unit> deleteOldSession() async {
    try {
      await account.get();
      final sessions = await account.listSessions();
      await account.deleteSession(
        sessionId: sessions.sessions.first.$id,
      );
      return unit;
    } catch (e) {
      return unit;
    }
  }
}
