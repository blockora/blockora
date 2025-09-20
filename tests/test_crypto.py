"""
Test cases for cryptography functions
"""
from core.cryptography import generate_hash, generate_key_pair, sign_message

def test_hash_generation():
    """Test SHA-3 hash generation"""
    test_data = b"Hello Blockora"
    result = generate_hash(test_data)
    assert len(result) == 64  # 256-bit hex = 64 characters
    print("✓ Hash generation test passed")

def test_key_generation():
    """Test key pair generation"""
    private_key, public_key = generate_key_pair()
    assert private_key is not None
    assert public_key is not None
    print("✓ Key generation test passed")

def test_signature():
    """Test message signing"""
    private_key, public_key = generate_key_pair()
    signature = sign_message(private_key, "Test message")
    assert len(signature) > 0
    print("✓ Signature test passed")

if __name__ == "__main__":
    test_hash_generation()
    test_key_generation()
    test_signature()
    print("All cryptography tests passed! 🎉")
