class Url {
  static const String baseUrl = "https://devvehcheck.k99x.com/servlet/api";

  static const String sendOtp = "$baseUrl/auth/otp/send";
  static const String verifyOtp = "$baseUrl/auth/otp/verify";
  static const String availableLeads =
      "$baseUrl//VEHICLE-CHECK/servlet/api/valuator/leads/available";
  static const String pendingLeads = "$baseUrl/pending";
  static const String completedLeads = "$baseUrl/completed";
}
