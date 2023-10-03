import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRemoteDataSource {
  Future<Unit> deleteOldSession();
  Future<Unit> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Client client;
  final Account account;

  LoginRemoteDataSourceImpl({required this.client, required this.account});

  @override
  Future<Unit> login(String email, String password) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );

      return unit;
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
