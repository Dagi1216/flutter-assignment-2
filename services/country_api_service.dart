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
      final url = Uri.parse(
          'https://restcountries.com/v3.1/all?fields=name,capital,region,population,flags');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Country.fromJson(item)).toList();
      } else {
        throw ApiException('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiException('No internet connection. Please retry.');
    }
  }}