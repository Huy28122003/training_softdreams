import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/upload_repository.dart';
import '../usecase.dart';

class UploadFile implements UseCase<String, File> {
  UploadFile(this.uploadRepository);

  final UploadRepository uploadRepository;

  @override
  Future<Either<Failure, String>> call(File file) async {
    try {
      final url = await uploadRepository.uploadFile(file);
      return Right(url);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
