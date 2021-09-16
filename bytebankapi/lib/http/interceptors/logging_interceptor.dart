import 'package:http_interceptor/http_interceptor.dart';

//interceptor fica de olho em todas as requisições, mostra todos os detalhe do request e response

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    //deixando mais print pra por vizualizar melhor
    print('Request');
    print('url: ${data.url}');
    print('body: ${data.body}');
    print('headers: ${data.headers}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Reponse');
    print('body: ${data.body}');
    print('headers: ${data.headers}');
    print('status: ${data.statusCode}');
    return data;
  }
}