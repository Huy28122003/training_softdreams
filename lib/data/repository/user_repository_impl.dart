import 'package:dartz/dartz.dart';
import '../../domain/repository/user_repository.dart';
import '../network/firebase/firebase_service.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this.firebase);

  final FirebaseService firebase;

  @override
  Future<Tuple2<bool, String>> login(String email, String password) {
    return firebase.login(email, password);
  }

  @override
  Future<Tuple2<bool, String>> signUp(String email, String password) {
    return firebase.signUp(email, password);
  }
}
