"""
Cryptography functions for Blockora
- SHA-3 Hashing
- ECDSA Signatures
- Key Management
"""
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import ec
from cryptography.hazmat.primitives import serialization

def generate_hash(data):
    """Generate SHA-3 256-bit hash"""
    digest = hashes.Hash(hashes.SHA3_256())
    digest.update(data)
    return digest.finalize().hex()

def generate_key_pair():
    """Generate ECDSA key pair"""
    private_key = ec.generate_private_key(ec.SECP256K1())
    public_key = private_key.public_key()
    return private_key, public_key

def sign_message(private_key, message):
    """Sign message with private key"""
    signature = private_key.sign(
        message.encode(),
        ec.ECDSA(hashes.SHA256())
    )
    return signature.hex()

# Test function
if __name__ == "__main__":
    # Test hash
    print("SHA-3 Hash:", generate_hash(b"Hello Blockora"))
    
    # Test keys and signing
    priv_key, pub_key = generate_key_pair()
    signature = sign_message(priv_key, "Test message")
    print("Signature:", signature[:50] + "...")
