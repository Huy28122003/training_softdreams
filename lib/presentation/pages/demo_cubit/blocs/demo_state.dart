part of 'demo_cubit.dart';

class DemoState extends Equatable{
  final FormzSubmissionStatus status;
  final int count;
  final String? errorMessage;

  const DemoState({
    this.status = FormzSubmissionStatus.initial,
    this.count = 0,
    this.errorMessage,
  });

  DemoState copyWith({
    FormzSubmissionStatus? status,
    int? count,
    String? errorMessage,
  }) {
    return DemoState(
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

