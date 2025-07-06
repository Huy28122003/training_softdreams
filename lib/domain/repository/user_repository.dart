import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Tuple2<bool, String>> login(String email, String password);
  Future<Tuple2<bool, String>> signUp(String email, String password);
}
