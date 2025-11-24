import 'package:flutter/material.dart';

class MiningScreen extends StatefulWidget { const MiningScreen({super.key}); @override State<MiningScreen> createState()=>_MiningScreenState(); }
class _MiningScreenState extends State<MiningScreen> {
  bool mining = false;
  double sessionReward = 0.0;

  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: AppBar(title: const Text("Mining")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(mining ? "Mining: ON" : "Mining: OFF"),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (){
                setState(()=> mining = !mining);
                // TODO (Hindi): Yahan PoA pings validators ko bhejna (signed)
              },
              child: Text(mining ? "Stop" : "Start"),
            ),
            const SizedBox(height: 12),
            Text("Estimated: ${sessionReward.toStringAsFixed(4)} BORA"),
          ],
        ),
      ),
    );
  }
}
