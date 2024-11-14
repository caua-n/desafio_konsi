import 'package:desafio_konsi/app/core/types/types.dart';

abstract class UseCase<Type extends Object, Params> {
  Future<Output<Type>> call(Params params);
}
