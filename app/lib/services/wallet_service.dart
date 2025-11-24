import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  final _storage = const FlutterSecureStorage();

  Future<Credentials> loadOrCreate() async {
    var pk = await _storage.read(key: "pk");
    if (pk == null) {
      final EthPrivateKey newKey = EthPrivateKey.createRandom();
      pk = bytesToHex(newKey.privateKey, include0x: true);
      await _storage.write(key: "pk", value: pk);
    }
    return EthPrivateKey.fromHex(pk);
  }

  Future<String?> getAddress() async {
    final pk = await _storage.read(key: "pk");
    if (pk == null) return null;
    final c = EthPrivateKey.fromHex(pk);
    final a = await c.extractAddress();
    return a.hex;
  }
}
