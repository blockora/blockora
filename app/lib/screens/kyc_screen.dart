import 'package:flutter/material.dart';
import '../services/api_client.dart';

class KYCScreen extends StatefulWidget { const KYCScreen({super.key}); @override State<KYCScreen> createState()=>_KYCScreenState(); }
class _KYCScreenState extends State<KYCScreen> {
  final _api = ApiClient();
  String _status = "Status: KYC start nahi hua";

  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: AppBar(title: const Text("KYC Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(_status),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                // TODO (Hindi): userId me wallet address use karo production me
                final res = await _api.startKyc("user-123");
                setState(()=> _status = "KYC start: ${res['uploadToken']}");
              },
              child: const Text("KYC Start"),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await _api.issueAttestation("user-123");
                setState(()=> _status = "VC issue: ${res['ok']}");
              },
              child: const Text("VC Issue (demo)"),
            ),
          ],
        ),
      ),
    );
  }
}
