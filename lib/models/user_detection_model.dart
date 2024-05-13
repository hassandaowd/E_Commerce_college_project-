// To parse this JSON data, do
//
//     final userDetectedModel = userDetectedModelFromJson(jsonString);

import 'dart:convert';

Map<String, String> userDetectedModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));

String userDetectedModelToJson(Map<String, String> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
