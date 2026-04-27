import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:visitor_pass_v2/config/config.dart';
import 'package:xml/xml.dart' as xml;

class ApiService {
  // Future<List<T>> apiCall<T>({
  //   required String url,
  //   required Map<String, dynamic> body,
  //   required T Function(Map<String, dynamic>) fromJson,
  // }) async {
  //   try {
  //     final response = await Constant.dio.post(url, data: body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = response.data;
  //
  //       // Case 1: API returns List directly
  //       if (data is List) {
  //         return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  //       }
  //
  //       // Case 2: API returns Map with list inside
  //       if (data is Map<String, dynamic>) {
  //         print("Case 2");
  //         final raw = data['d'];
  //
  //         print(raw);
  //         if (raw is String) {
  //           final decoded = jsonDecode(raw);
  //           if (decoded is List) {
  //             return decoded
  //                 .map((e) => fromJson(e as Map<String, dynamic>))
  //                 .toList();
  //           }
  //         }
  //         return [];
  //       }
  //     }
  //     print("Case 3");
  //     debugPrint("Response Code: ${response.statusCode}");
  //     debugPrint("Response Data: ${response.data}");
  //     return [];
  //   } on DioException catch (e) {
  //     debugPrint("POST Dio error: ${e.message}");
  //     return [];
  //   } catch (e) {
  //     debugPrint("POST Unknown error: $e");
  //     return [];
  //   }
  // }

  Future<List<T>> apiCall<T>({
    required String url,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.baseUrl}/$url"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body.map((k, v) => MapEntry(k, v.toString())),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        debugPrint("API ERROR CODE => ${response.statusCode}");
        return [];
      }

      final rawData = response.body.trim();

      /// 🔹 Step 1: XML (.asmx) response
      if (rawData.startsWith('<')) {
        final document = xml.XmlDocument.parse(rawData);

        final stringNode = document.findAllElements('string');
        if (stringNode.isEmpty) return [];

        final jsonText = stringNode.first.text.trim();
        final decoded = jsonDecode(jsonText);

        if (decoded is List && decoded.isNotEmpty) {
          return decoded
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }

      /// 🔹 Step 2: JSON response
      final decoded = jsonDecode(rawData);

      /// Case: List directly
      if (decoded is List) {
        return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      }

      /// Case: Map with 'd'
      if (decoded is Map<String, dynamic>) {
        final d = decoded['d'];
        if (d is String) {
          final list = jsonDecode(d);
          if (list is List) {
            return list
                .map((e) => fromJson(e as Map<String, dynamic>))
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      debugPrint("HTTP API ERROR => $e");
      return [];
    }
  }


  // With Token

  Future<List<T>> apiCallWithToken<T>({
    required String url,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.baseUrl}/$url"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded','Authorization': 'Bearer $token'},
        body: body.map((k, v) => MapEntry(k, v.toString())),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        debugPrint("API ERROR CODE => ${response.statusCode}");
        return [];
      }

      final rawData = response.body.trim();

      /// 🔹 Step 1: XML (.asmx) response
      if (rawData.startsWith('<')) {
        final document = xml.XmlDocument.parse(rawData);

        final stringNode = document.findAllElements('string');
        if (stringNode.isEmpty) return [];

        final jsonText = stringNode.first.text.trim();
        final decoded = jsonDecode(jsonText);

        if (decoded is List && decoded.isNotEmpty) {
          return decoded
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }

      /// 🔹 Step 2: JSON response
      final decoded = jsonDecode(rawData);

      /// Case: List directly
      if (decoded is List) {
        return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      }

      /// Case: Map with 'd'
      if (decoded is Map<String, dynamic>) {
        final d = decoded['d'];
        if (d is String) {
          final list = jsonDecode(d);
          if (list is List) {
            return list
                .map((e) => fromJson(e as Map<String, dynamic>))
                .toList();
          }
        }
      }

      return [];
    } catch (e) {
      debugPrint("HTTP API ERROR => $e");
      return [];
    }
  }

  // Future<String> apiCallString({
  //   required String url,
  //   required Map<String, dynamic>? body,
  // }) async {
  //   try {
  //     final response = await Constant.dio.post(url, data: body);
  //
  //     if (response.statusCode != 200) {
  //       throw Exception("Server error : ${response.statusCode}");
  //     }
  //     final resData = response.data;
  //     if (resData is Map && resData.containsKey('d')) {
  //       final String dString = resData['d'];
  //       final dynamic decoded = jsonDecode(dString);
  //       if (decoded is List &&
  //           decoded.isNotEmpty &&
  //           decoded.first is Map &&
  //           decoded.first.containsKey('status')) {
  //         return decoded.first['status'].toString();
  //       }
  //       return dString;
  //     }
  //     return resData.toString();
  //   } catch (e) {
  //     throw Exception("Dio error: $e");
  //   }
  // }

  Future<String> apiCallString({
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.baseUrl}/$url"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body?.map((k, v) => MapEntry(k, v.toString())),
      );

      if (response.statusCode != 200) {
        throw Exception("Server error : ${response.statusCode}");
      }

      final rawData = response.body.trim();

      /// 🔹 Case 1: .asmx XML response
      if (rawData.startsWith('<')) {
        final document = xml.XmlDocument.parse(rawData);

        final nodes = document.findAllElements('string');
        if (nodes.isEmpty) return '';

        final jsonText = nodes.first.text.trim();
        final decoded = jsonDecode(jsonText);

        if (decoded is List &&
            decoded.isNotEmpty &&
            decoded.first is Map &&
            decoded.first.containsKey('status')) {
          return decoded.first['status'].toString();
        }

        if (decoded is List &&
            decoded.isNotEmpty &&
            decoded.first is Map &&
            decoded.first.containsKey('result')) {
          return decoded.first['result'].toString();
        }
        if (decoded is List &&
            decoded.isNotEmpty &&
            decoded.first is Map &&
            decoded.first.containsKey('userid')) {
          return decoded.first['userid'].toString();
        }
        if (decoded is List &&
            decoded.isNotEmpty &&
            decoded.first is Map &&
            decoded.first.containsKey('usertype')) {
          return decoded.first['usertype'].toString();
        }

        return jsonText;
      }

      /// 🔹 Case 2: JSON response
      final decoded = jsonDecode(rawData);

      if (decoded is Map && decoded.containsKey('d')) {
        final dString = decoded['d'];

        if (dString is String) {
          final inner = jsonDecode(dString);

          if (inner is List &&
              inner.isNotEmpty &&
              inner.first is Map &&
              inner.first.containsKey('status')) {
            return inner.first['status'].toString();
          }

          if (inner is List &&
              inner.isNotEmpty &&
              inner.first is Map &&
              inner.first.containsKey('result')) {
            return inner.first['result'].toString();
          }

          if (inner is List &&
              inner.isNotEmpty &&
              inner.first is Map &&
              inner.first.containsKey('userid')) {
            return inner.first['userid'].toString();
          }

          if (inner is List &&
              inner.isNotEmpty &&
              inner.first is Map &&
              inner.first.containsKey('usertype')) {
            return inner.first['usertype'].toString();
          }


          return dString;
        }
      }

      return rawData;
    } catch (e) {
      throw Exception("HTTP error: $e");
    }
  }

  Future<List<T>> apiCallNotList<T>({
    required String url,
    required Map<String, dynamic> body,
    required T Function(Map<String, dynamic>) fromJson,
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${Config.baseUrl}/$url"),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: body.map((k, v) => MapEntry(k, v.toString())),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        debugPrint("API ERROR CODE => ${response.statusCode}");
        return [];
      }

      final rawData = response.body.trim();

      /// 🔹 Step 1: XML (.asmx) response
      if (rawData.startsWith('<')) {
        final document = xml.XmlDocument.parse(rawData);
        final stringNode = document.findAllElements('string');

        if (stringNode.isEmpty) return [];

        final jsonText = stringNode.first.text.trim();
        final decoded = jsonDecode(jsonText);

        /// XML returning List
        if (decoded is List) {
          return decoded
              .map((e) => fromJson(e as Map<String, dynamic>))
              .toList();
        }

        /// XML returning Single Object
        if (decoded is Map<String, dynamic>) {
          return [fromJson(decoded)];
        }

        return [];
      }

      /// 🔹 Step 2: Normal JSON response
      final decoded = jsonDecode(rawData);

      /// Case 1: Direct List
      if (decoded is List) {
        return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      }

      /// Case 2: Single Object (🔥 Your Login Case)
      if (decoded is Map<String, dynamic>) {
        /// Case 2A: If wrapped inside 'd'
        if (decoded.containsKey('d')) {
          final d = decoded['d'];

          if (d is String) {
            final innerDecoded = jsonDecode(d);

            if (innerDecoded is List) {
              return innerDecoded
                  .map((e) => fromJson(e as Map<String, dynamic>))
                  .toList();
            }

            if (innerDecoded is Map<String, dynamic>) {
              return [fromJson(innerDecoded)];
            }
          }
        }

        /// Case 2B: Direct Single Object
        return [fromJson(decoded)];
      }

      return [];
    } catch (e) {
      debugPrint("HTTP API ERROR => $e");
      return [];
    }
  }

  Future<String?> getToken({required String url}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        debugPrint("GET TOKEN ERROR CODE => ${response.statusCode}");
        return null;
      }

      final rawData = response.body.trim();

      /// 🔹 STEP 1: XML (.asmx) Response
      if (rawData.startsWith('<')) {
        final document = xml.XmlDocument.parse(rawData);
        final stringNode = document.findAllElements('string');

        if (stringNode.isEmpty) return null;

        final jsonText = stringNode.first.text.trim();
        final decoded = jsonDecode(jsonText);

        if (decoded is Map<String, dynamic>) {
          final tokenList = decoded['TokenListName'];
          if (tokenList is List && tokenList.isNotEmpty) {
            return tokenList.first['Token'];
          }
        }

        return null;
      }

      /// 🔹 STEP 2: Direct JSON Response
      final decoded = jsonDecode(rawData);

      if (decoded is Map<String, dynamic>) {
        final tokenList = decoded['TokenListName'];

        if (tokenList is List && tokenList.isNotEmpty) {
          return tokenList.first['Token'];
        }
      }

      return null;
    } catch (e) {
      debugPrint("GET TOKEN ERROR => $e");
      return null;
    }
  }
}
