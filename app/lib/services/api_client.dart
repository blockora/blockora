import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';

class ApiClient {
  final http.Client _c = http.Client();

  Future<Map<String,dynamic>> startKyc(String userId) async {
    final r = await _c.post(Uri.parse("${Env.apiBase}/kyc/start"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"userId": userId}));
    return jsonDecode(r.body);
  }

  Future<Map<String,dynamic>> issueAttestation(String userId) async {
    final r = await _c.post(Uri.parse("${Env.apiBase}/attestation/issue"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({"userId": userId, "passed": true})); // demo
    return jsonDecode(r.body);
  }
}
