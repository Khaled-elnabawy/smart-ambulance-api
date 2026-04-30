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
  static const String badRequestError = "Bad request, please try again.";
  static const String noContent = "No content found.";
  static const String forbiddenError = "Forbidden access.";
  static const String unauthorizedError = "Unauthorized access. Please login again.";
  static const String notFoundError = "Resource not found.";
  static const String conflictError = "Conflict occurred.";
  static const String internalServerError = "Server error, please try again later.";
  static const String unknownError = "An unknown error occurred.";
  static const String timeoutError = "Connection timeout. Please check your internet or server status.";
  static const String defaultError = "Something went wrong. Please try again.";
  static const String cacheError = "Cache error.";
  static const String noInternetError = "No internet connection.";
  static const String loadingMessage = "Loading...";
  static const String retryAgainMessage = "Please try again.";
  static const String ok = "Ok";
}
