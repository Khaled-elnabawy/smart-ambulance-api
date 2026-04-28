class ApiConstants {
  static const String baseUrl =
      "https://shanell-unejaculated-rebecca.ngrok-free.dev/api/";
  static const String login = "v1/login";
  static const String register = "v1/register";
  static const String sendCode = "v1/forgot-password";
  static const String verifyCode = "v1/verify-reset-code";
  static const String resetPassword = "v1/reset-password";
  static const String logout = "v1/logout";
  static const String createEmergency = "v1/requests";
  static const String createScheduled = "v1/requests";
  static const String getRequests = "v1/my-requests";
  static const String cancelRequest = "v1/requests/cancel";
  static const String acceptRequest = "v1/requests/accept";
  static const String rejectRequest = "v1/requests/reject";
  static const String trackRequest = "v1/requests/{id}";
  static const String updateLocation = "v1/driver/location";
  static const String arrivedRequest = "v1/requests/arrived";
  static const String completedRequest = "v1/requests/completed";
  static const String rateDriver = "v1/requests/rate";
  static const String editProfile = "v1/profile/update";
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
