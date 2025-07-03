import 'package:formz/formz.dart';

enum ValidationError { empty, invalid, notMatch }

class StringNonEmpty extends FormzInput<String, ValidationError> {
  const StringNonEmpty.pure({String value = ''}) : super.pure(value);

  const StringNonEmpty.dirty({String value = ''}) : super.dirty(value);

  @override
  ValidationError? validator(String value) {
    if (value.trim().isEmpty) return ValidationError.empty;
    return null;
  }
}
