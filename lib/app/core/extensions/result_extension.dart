import 'package:desafio_konsi/app/core/controllers/controllers.dart';
import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:result_dart/result_dart.dart';

extension ResultStateExtension<S extends Object, F extends BaseException,
    C extends BaseController> on Result<S, F> {
  Result<S, F> updateState(
    C controller,
    BaseState Function(S) state,
  ) {
    final newState = fold(
      (value) => state(value),
      ErrorState.new,
    );

    controller.update(newState);

    return this;
  }
}

extension AsyncResultStateExtension<S extends Object, F extends BaseException,
    C extends BaseController> on AsyncResult<S, F> {
  AsyncResult<S, F> updateState(
    C controller,
    BaseState Function(S) state,
  ) {
    return then((result) => result.updateState(controller, state));
  }
}
