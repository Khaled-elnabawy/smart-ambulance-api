import 'package:dio/dio.dart';
import 'package:mobile/features/forgot_password/data/models/send_code_models/send_code_response.dart';
import 'package:mobile/features/home/data/models/emergency_models/emergency_request_model.dart';
import 'package:mobile/features/home/data/models/emergency_models/emergency_response_model.dart';
import 'package:mobile/features/home/data/models/scheduled_models/scheduled_request_model.dart';
import 'package:mobile/features/profile/data/models/edit_profile/edit_profile_request_model.dart';
import 'package:mobile/features/profile/data/models/edit_profile/edit_profile_response_model.dart';
import 'package:mobile/features/profile/data/models/logout/logout_response_model.dart';
import 'package:mobile/features/requests/data/models/cancel/cancel_response.dart';
import 'package:mobile/features/requests/data/models/confirm/confirm_request_body.dart';
import 'package:mobile/features/requests/data/models/confirm/confirm_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../features/forgot_password/data/models/reset_password_models/reset_password_request_body.dart';
import '../../features/forgot_password/data/models/reset_password_models/reset_password_response.dart';
import '../../features/forgot_password/data/models/send_code_models/send_code_request_body.dart';
import '../../features/forgot_password/data/models/verify_code_models/verify_code_request_body.dart';
import '../../features/forgot_password/data/models/verify_code_models/verify_code_response.dart';
import '../../features/home/data/models/scheduled_models/scheduled_response_model.dart';
import '../../features/login/data/models/login_request_body.dart';
import '../../features/login/data/models/login_response.dart';
import '../../features/register/data/models/register_request_body.dart';
import '../../features/register/data/models/register_response.dart';
import '../../features/requests/data/models/cancel/cancel_request_body.dart';
import '../../features/requests/data/models/confirm/confirm_response_model.dart';
import '../../features/requests/data/models/requests/requests_request_model.dart';
import '../../features/requests/data/models/requests/requests_response_model.dart';
import '../../features/tracking/data/models/action_request/action_request_body.dart';
import '../../features/tracking/data/models/action_request/action_request_response.dart';
import '../../features/tracking/data/models/rate_driver/rate_driver_body.dart';
import '../../features/tracking/data/models/rate_driver/rate_driver_response.dart';
import '../../features/tracking/data/models/track_request/track_request_response.dart';
import '../../features/tracking/data/models/update_location/update_location_body.dart';
import '../../features/tracking/data/models/update_location/update_location_response.dart';
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
  Future<SendCodeResponse> sendCode(
    @Body() SendCodeRequestBody sendCodeRequestBody,
  );

  @POST(ApiConstants.verifyCode)
  Future<VerifyCodeResponse> verifyCode(
    @Body() VerifyCodeRequestBody verifyCodeRequestBody,
  );

  @POST(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequestBody resetPasswordRequestBody,
  );

  @POST(ApiConstants.createEmergency)
  Future<EmergencyResponseModel> createEmergency(
    @Header('Authorization') String token,
    @Body() EmergencyRequestModel emergencyRequestModel,
  );

  @POST(ApiConstants.createScheduled)
  Future<ScheduledResponseModel> createScheduled(
    @Header('Authorization') String token,
    @Body() ScheduledRequestModel scheduledRequestModel,
  );

  @GET(ApiConstants.getRequests)
  Future<RequestsResponseModel> getRequests(
    @Header('Authorization') String token,
    @Body() RequestsRequestModel requestsRequestModel,
  );

  @POST(ApiConstants.cancelRequest)
  Future<CancelResponse> cancelRequest(
    @Header('Authorization') String token,
    @Body() CancelRequestBody cancelRequestBody,
  );

  @POST(ApiConstants.acceptRequest)
  Future<ConfirmResponseModel> acceptRequest(
    @Header('Authorization') String token,
    @Body() ConfirmRequestBody confirmRequestBody,
  );

  @POST(ApiConstants.rejectRequest)
  Future<CancelResponse> rejectRequest(
    @Header('Authorization') String token,
    @Body() CancelRequestBody cancelRequestBody,
  );

  @GET(ApiConstants.trackRequest)
  Future<TrackRequestResponse> trackRequest(
    @Header('Authorization') String token,
    @Path("id") int id,
  );

  @POST(ApiConstants.updateLocation)
  Future<UpdateLocationResponse> updateLocation(
    @Header('Authorization') String token,
    @Body() UpdateLocationBody updateLocationBody,
  );

  @POST(ApiConstants.arrivedRequest)
  Future<ActionRequestResponse> arrivedRequest(
    @Header('Authorization') String token,
    @Body() ActionRequestBody actionRequestBody,
  );

  @POST(ApiConstants.completedRequest)
  Future<ActionRequestResponse> completeRequest(
    @Header('Authorization') String token,
    @Body() ActionRequestBody actionRequestBody,
  );

  @POST(ApiConstants.rateDriver)
  Future<RateDriverResponse> rateDriver(
    @Header('Authorization') String token,
    @Body() RateDriverBody rateDriverBody,
  );
  @POST(ApiConstants.logout)
  Future<LogoutResponseModel> logout(@Header('Authorization') String token);

  @POST(ApiConstants.editProfile)
  Future<EditProfileResponseModel> editProfile(
    @Header('Authorization') String token,
    @Body() EditProfileRequestModel editProfileRequestModel,
  );
}
