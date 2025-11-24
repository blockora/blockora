import 'package:flutter/material.dart';

class SwapScreen extends StatelessWidget {
  const SwapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO (Hindi): AMM contract se connect karke swap implement karo
    return Scaffold(
      appBar: AppBar(title: const Text("DEX Swap")),
      body: const Center(child: Text("Swap UI (AMM + FeeManager)")),
    );
  }
}
