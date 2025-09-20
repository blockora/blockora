"""
Test cases for consensus functions
"""
from core.consensus import calculate_contribution_score, calculate_reward

def test_contribution_score():
    """Test contribution score calculation"""
    score = calculate_contribution_score(
        V=100,    # 100 transactions
        U=0.95,   # 95% uptime
        D=50,     # Development score
        G=3,      # Governance participation
        C=25      # Community contributions
    )
    
    expected_score = 0.4*100 + 0.3*0.95 + 0.1*50 + 0.15*3 + 0.05*25
    assert abs(score - expected_score) < 0.001
    print("✓ Contribution score test passed")

def test_reward_calculation():
    """Test reward calculation"""
    contribution_score = 45.5
    total_network_score = 1000
    block_reward = 10
    
    reward = calculate_reward(contribution_score, total_network_score, block_reward)
    expected_reward = (45.5 / 1000) * 10
    
    assert abs(reward - expected_reward) < 0.001
    print("✓ Reward calculation test passed")

def test_zero_network_score():
    """Test reward calculation when network score is zero"""
    reward = calculate_reward(100, 0, 10)
    assert reward == 0
    print("✓ Zero network score test passed")

def run_all_tests():
    """Run all consensus tests"""
    print("Running Consensus Tests...")
    test_contribution_score()
    test_reward_calculation()
    test_zero_network_score()
    print("All consensus tests passed! 🎉")

if __name__ == "__main__":
    run_all_tests()
