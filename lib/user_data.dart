import 'dart:convert';

import 'package:upang_eat/models/user_model.dart';
import 'package:http/http.dart' as http;

UserModel? globalUserData;

double globalEthBalance = 0;
String globalWalletEthAddress = '';

String globalPrivateKey = '';

// Global token prices
double globalEthPrice = 0.0;
double globalBtcPrice = 0.0;
double globalLtcPrice = 0.0;
double globalXrpPrice = 0.0;
double globalAxsPrice = 0.0;

// Global 24hr price changes
double globalEthPriceChange = 0.0;
double globalBtcPriceChange = 0.0;
double globalLtcPriceChange = 0.0;
double globalXrpPriceChange = 0.0;
double globalAxsPriceChange = 0.0;

Future<void> fetchTokenPrices() async {
  const String apiUrl =
      "https://api.coingecko.com/api/v3/simple/price?ids=ethereum,bitcoin,litecoin,ripple,axie-infinity&vs_currencies=php&include_24hr_change=true"; // Include 24hr change

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Set global variables with the fetched data
      globalEthPrice = data['ethereum']['php'] != null
          ? (data['ethereum']['php'] is int
              ? (data['ethereum']['php'] as int).toDouble()
              : data['ethereum']['php'])
          : 0.0;
      globalBtcPrice = data['bitcoin']['php'] != null
          ? (data['bitcoin']['php'] is int
              ? (data['bitcoin']['php'] as int).toDouble()
              : data['bitcoin']['php'])
          : 0.0;
      globalLtcPrice = data['litecoin']['php'] != null
          ? (data['litecoin']['php'] is int
              ? (data['litecoin']['php'] as int).toDouble()
              : data['litecoin']['php'])
          : 0.0;
      globalXrpPrice = data['ripple']['php'] != null
          ? (data['ripple']['php'] is int
              ? (data['ripple']['php'] as int).toDouble()
              : data['ripple']['php'])
          : 0.0;
      globalAxsPrice = data['axie-infinity']['php'] != null
          ? (data['axie-infinity']['php'] is int
              ? (data['axie-infinity']['php'] as int).toDouble()
              : data['axie-infinity']['php'])
          : 0.0;

      // Set global 24-hour price changes
      globalEthPriceChange = data['ethereum']['php_24h_change'] ?? 0.0;
      globalBtcPriceChange = data['bitcoin']['php_24h_change'] ?? 0.0;
      globalLtcPriceChange = data['litecoin']['php_24h_change'] ?? 0.0;
      globalXrpPriceChange = data['ripple']['php_24h_change'] ?? 0.0;
      globalAxsPriceChange = data['axie-infinity']['php_24h_change'] ?? 0.0;
      print(".....\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n ....");
    } else {
      print("Failed to load token prices.");
    }
  } catch (error) {
    print("Error fetching token prices: $error");
  }
}
