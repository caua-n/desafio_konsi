import 'package:desafio_konsi/app/core/errors/base_exception.dart';
import 'package:desafio_konsi/app/core/services/interfaces/client/rest_client_http_message.dart';
import 'package:desafio_konsi/app/core/services/interfaces/client/rest_client_response.dart';

class RestClientException extends BaseException
    implements RestClientHttpMessage {
  dynamic error;
  RestClientResponse? response;

  RestClientException({
    required super.message,
    super.statusCode,
    super.data,
    required this.error,
    this.response,
    super.stackTracing,
  });

  factory RestClientException.fromBaseException(BaseException exception) {
    return RestClientException(message: exception.message, error: exception);
  }
}
