class HttpStatusCodes {
  static const int ok = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int internalServerError = 500;

  static String getMessage(int code) {
    switch (code) {
      case ok:
        return "Success";
      case created:
        return "Resource created successfully";
      case badRequest:
        return "Bad request";
      case unauthorized:
        return "Unauthorized";
      case forbidden:
        return "Forbidden";
      case notFound:
        return "Not found";
      case internalServerError:
        return "Internal server error";
      default:
        return "Unknown error occurred";
    }
  }
}
