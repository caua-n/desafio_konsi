import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:result_dart/result_dart.dart';

typedef Output<T extends Object> = Result<T, BaseException>;
