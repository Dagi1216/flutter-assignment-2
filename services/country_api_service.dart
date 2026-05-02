import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/country.dart';
import 'api_exception.dart';

class CountryApiService {
  static const String _baseUrl = 'restcountries.com';

  Future<List<Country>> fetchAllCountries() async {
    try {
      // We add a timestamp parameter to the URL.
      // This forces the browser to treat every request as unique,
      // completely bypassing the cache and fixing the "WiFi Toggle" bug.
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final url = Uri.https(_baseUrl, '/v3.1/all', {'t': '$timestamp'});

      final response = await http.get(
        url,
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Country.fromJson(item)).toList();
      } else {
        throw ApiException('Server Error: ${response.statusCode}');
      }
    } on SocketException {
      throw ApiException('No internet connection.');
    } on TimeoutException {
      throw ApiException('Connection timed out.');
    } catch (e) {
      // In Web, the browser might block the request if Wi-Fi is off.
      throw ApiException('Network Error: Check your connection');
    }
  }
}