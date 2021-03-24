class Endpoints {
  static String baseURL = "https://60585b2ec3f49200173adcec.mockapi.io";

  static String apiURL = "$baseURL/api/v1";

// auth
  static String login = "/login";

  // blog
  static String blogs = "/blogs";
  static String blog(String blogId) => "/blogs/$blogId";
}
