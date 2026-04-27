import 'package:dio/dio.dart';

class Config {

  // Dev
  // static final String baseUrl = "https://qa.aostasoftware.com/bbabha/";
  // static final String baseUrl2 = "https://qa.aostasoftware.com/";
  // static final String siteUrl = "https://qa.aostasoftware.com/visitorpassv2/";

  // Live
  static final String baseUrl = "https://mapps.aostasoftware.com/bb15se/";
  static final String baseUrl2 = "https://mapps.aostasoftware.com/";
  static final String siteUrl = "https://mapps.aostasoftware.com/visitorpassv2/";

  // Dio Connectivity
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}
