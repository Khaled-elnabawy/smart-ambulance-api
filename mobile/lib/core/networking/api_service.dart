import 'package:dio/dio.dart';
import 'package:mobile/features/forget_password/data/models/send_reset_code_models/send_reset_code_request_body.dart';
import 'package:mobile/features/forget_password/data/models/send_reset_code_models/send_reset_code_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../features/login/data/models/login_request_body.dart';
import '../../features/login/data/models/login_response.dart';
import '../../features/register/data/models/register_request_body.dart';
import '../../features/register/data/models/register_response.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.register)
  Future<RegisterResponse> register(
    @Body() RegisterRequestBody registerRequestBody,
  );

  @POST(ApiConstants.sendCode)
  Future<SendResetCodeResponse> sendCode(
    @Body() SendResetCodeRequestBody sendResetCodeRequestBody,
  );
}
