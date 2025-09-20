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
    if isinstance(data, str):
        data = data.encode()
    digest = hashes.Hash(hashes.SHA3_256())
    digest.update(data)
    return digest.finalize().hex()

def generate_key_pair():
    """Generate ECDSA key pair (SECP256K1)"""
    private_key = ec.generate_private_key(ec.SECP256K1())
    public_key = private_key.public_key()
    return private_key, public_key

def sign_message(private_key, message):
    """Sign message with private key"""
    if isinstance(message, str):
        message = message.encode()
    signature = private_key.sign(message, ec.ECDSA(hashes.SHA256()))
    return signature.hex()

def serialize_public_key(public_key):
    """Serialize public key to bytes"""
    return public_key.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    )

# Test function
if __name__ == "__main__":
    # Test cryptography functions
    print("Testing Blockora Cryptography Module...")
    
    # Test hash
    hash_result = generate_hash("Hello Blockora")
    print(f"SHA-3 Hash: {hash_result}")
    print(f"Hash length: {len(hash_result)} characters")
    
    # Test keys and signing
    priv_key, pub_key = generate_key_pair()
    signature = sign_message(priv_key, "Test message for Blockora")
    print(f"Signature: {signature[:50]}...")
    
    # Test public key serialization
    pub_key_serialized = serialize_public_key(pub_key)
    print(f"Public key (first 100 chars): {str(pub_key_serialized[:100])}...")
    
    print("All cryptography tests completed successfully! ✅")
