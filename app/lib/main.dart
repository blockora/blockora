import 'package:flutter/material.dart';
import 'screens/kyc_screen.dart';
import 'screens/mining_screen.dart';
import 'screens/swap_screen.dart';

void main() => runApp(const BlockoraApp());

class BlockoraApp extends StatelessWidget {
  const BlockoraApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blockora",
      theme: ThemeData(useMaterial3: true),
      home: const _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blockora")),
      body: ListView(
        children: [
          ListTile(title: const Text("KYC"), onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const KYCScreen()))),
          ListTile(title: const Text("Mining"), onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const MiningScreen()))),
          ListTile(title: const Text("DEX Swap"), onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const SwapScreen()))),
        ],
      ),
    );
  }
}
