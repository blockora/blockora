"""
Test cases for cryptography functions
"""
from core.cryptography import generate_hash, generate_key_pair, sign_message

def test_hash_generation():
    """Test SHA-3 hash generation"""
    test_data = "Hello Blockora"
    result = generate_hash(test_data)
    assert len(result) == 64  # 256-bit hex = 64 characters
    assert result == "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a"
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
    test_message = "Test message for Blockora blockchain"
    signature = sign_message(private_key, test_message)
    assert len(signature) > 0
    assert isinstance(signature, str)
    print("✓ Signature test passed")

def run_all_tests():
    """Run all cryptography tests"""
    print("Running Cryptography Tests...")
    test_hash_generation()
    test_key_generation()
    test_signature()
    print("All cryptography tests passed! 🎉")

if __name__ == "__main__":
    run_all_tests()
