import 'dart:convert';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import '../env.dart';

class ChainClient {
  late final Web3Client web3;
  ChainClient() { web3 = Web3Client(Env.rpcUrl, Client()); }

  // TODO (Hindi): Deploy ke baad addresses paste karo
  final EthereumAddress boraAddress       = EthereumAddress.fromHex("0xBORA_TOKEN_ADDRESS");   // <-- EDIT
  final EthereumAddress lockupAddress     = EthereumAddress.fromHex("0xLOCKUP_CONTRACT");      // <-- EDIT
  final EthereumAddress kycAddress        = EthereumAddress.fromHex("0xKYC_CONTRACT");         // <-- EDIT
  final EthereumAddress rewardAddress     = EthereumAddress.fromHex("0xREWARD_DISTRIBUTOR");   // <-- EDIT

  DeployedContract? _bora;
  DeployedContract? _lock;
  DeployedContract? _kyc;
  DeployedContract? _reward;

  Future<void> _ensure() async {
    if (_bora != null) return;
    final boraAbi = jsonDecode(await rootBundle.loadString('lib/abi/BORA.json'));
    final lockAbi = jsonDecode(await rootBundle.loadString('lib/abi/LockupStaking.json'));
    final kycAbi  = jsonDecode(await rootBundle.loadString('lib/abi/KYCAttestor.json'));
    final rewAbi  = jsonDecode(await rootBundle.loadString('lib/abi/RewardDistributor.json'));

    _bora = DeployedContract(ContractAbi.fromJson(jsonEncode(boraAbi), "BORA"), boraAddress);
    _lock = DeployedContract(ContractAbi.fromJson(jsonEncode(lockAbi), "LockupStaking"), lockupAddress);
    _kyc  = DeployedContract(ContractAbi.fromJson(jsonEncode(kycAbi), "KYCAttestor"), kycAddress);
    _reward=DeployedContract(ContractAbi.fromJson(jsonEncode(rewAbi), "RewardDistributor"), rewardAddress);
  }

  Future<BigInt> boraBalance(EthereumAddress addr) async {
    await _ensure();
    final f = _bora!.function("balanceOf");
    final r = await web3.call(contract: _bora!, function: f, params: [addr]);
    return r.first as BigInt;
  }

  Future<dynamic> viewStake(EthereumAddress user) async {
    await _ensure();
    final f = _lock!.function("viewStake");
    final r = await web3.call(contract: _lock!, function: f, params: [user]);
    return r.first;
  }

  Future<bool> canUnlock(EthereumAddress user) async {
    await _ensure();
    final f = _lock!.function("canUnlock");
    final r = await web3.call(contract: _lock!, function: f, params: [user]);
    return r.first as bool;
  }

  Future<String> lock(Credentials creds, BigInt amount, int daysLocked) async {
    await _ensure();
    final f = _lock!.function("lock");
    final tx = Transaction.callContract(
      contract: _lock!, function: f, parameters: [amount, BigInt.from(daysLocked)]
    );
    return web3.sendTransaction(creds, tx, chainId: null);
  }

  Future<String> unlock(Credentials creds) async {
    await _ensure();
    final f = _lock!.function("unlock");
    final tx = Transaction.callContract(contract: _lock!, function: f, parameters: []);
    return web3.sendTransaction(creds, tx, chainId: null);
    }

  Future<BigInt> pendingReward(EthereumAddress user) async {
    await _ensure();
    final f = _reward!.function("pending");
    final r = await web3.call(contract: _reward!, function: f, params: [user]);
    return r.first as BigInt;
  }

  Future<String> claim(Credentials creds) async {
    await _ensure();
    final f = _reward!.function("claim");
    final tx = Transaction.callContract(contract: _reward!, function: f, parameters: []);
    return web3.sendTransaction(creds, tx, chainId: null);
  }
}
