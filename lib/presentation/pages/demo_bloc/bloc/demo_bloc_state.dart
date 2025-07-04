part of 'demo_bloc_bloc.dart';

class DemoBlocState extends Equatable {
  final FormzSubmissionStatus status;
  final int count;
  final String? errorMessage;

  const DemoBlocState({
    this.status = FormzSubmissionStatus.initial,
    this.count = 0,
    this.errorMessage,
  });

  DemoBlocState copyWith({
    FormzSubmissionStatus? status,
    int? count,
    String? errorMessage,
  }) {
    return DemoBlocState(
      status: status ?? this.status,
      count: count ?? this.count,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        count,
      ];
}
