import 'package:dartz/dartz.dart';

import '../user_firebase.dart';


abstract class UserFirebaseDataSources {
  Future<Tuple2<bool, String>> login(String email, String password);

  Future<Tuple2<bool, String>> signUp(String email, String password);
}

class UserFirebaseDataSourcesImpl extends UserFirebaseDataSources {
  final UserFirebase _userFirebase;

  UserFirebaseDataSourcesImpl(this._userFirebase);

  @override
  Future<Tuple2<bool, String>> login(String email, String password) async {
    return await _userFirebase.login(email, password);
  }

  @override
  Future<Tuple2<bool, String>> signUp(String email, String password) async {
    return await _userFirebase.signUp(email, password);
  }
}
