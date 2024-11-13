import 'package:desafio_konsi/features/errors/base_exception.dart';

abstract class BaseState {}

class InitialState implements BaseState {}

class LoadingState implements BaseState {}

class SuccessState<R> implements BaseState {
  const SuccessState(
    this.data,
  );

  final R data;
}

class ErrorState<T extends BaseException> implements BaseState {
  const ErrorState(
    this.exception,
  );

  final T exception;
}
