"""
Security Module for Blockora
- AI-Powered Anomaly Detection
- Fraud Prevention
"""
import numpy as np
from sklearn.ensemble import IsolationForest

class SecuritySystem:
    def __init__(self):
        self.model = IsolationForest(contamination=0.1, random_state=42)
        self.is_trained = False
    
    def train_model(self, normal_transactions):
        """
        Train the anomaly detection model with normal transaction data
        """
        if len(normal_transactions) < 10:
            print("Need more data to train model")
            return False
        
        self.model.fit(normal_transactions)
        self.is_trained = True
        return True
    
    def detect_anomaly(self, transaction_features):
        """
        Detect if a transaction is anomalous
        Returns: -1 for anomaly, 1 for normal
        """
        if not self.is_trained:
            print("Model not trained yet")
            return 0
        
        prediction = self.model.predict([transaction_features])
        return prediction[0]
    
    def check_transaction_risk(self, transaction_data):
        """
        Comprehensive transaction risk check
        """
        # Extract features for AI model (simplified)
        features = [
            transaction_data.get('amount', 0),
            transaction_data.get('frequency', 0),
            transaction_data.get('time_since_last', 0)
        ]
        
        # AI anomaly detection
        anomaly_score = self.detect_anomaly(features)
        
        # Additional security checks
        is_high_amount = transaction_data.get('amount', 0) > 10000
        is_frequent = transaction_data.get('frequency', 0) > 10
        
        risk_factors = []
        if anomaly_score == -1:
            risk_factors.append("AI anomaly detection")
        if is_high_amount:
            risk_factors.append("High amount")
        if is_frequent:
            risk_factors.append("High frequency")
        
        return {
            'is_risky': len(risk_factors) > 0,
            'risk_factors': risk_factors,
            'anomaly_score': anomaly_score
        }

# Test function
if __name__ == "__main__":
    print("Testing Blockora Security Module...")
    
    # Create security system
    security = SecuritySystem()
    
    # Train with normal transactions (simulated data)
    normal_data = np.array([
        [100, 1, 60],    # amount, frequency, time_since_last
        [500, 2, 30],
        [200, 1, 120],
        [50, 1, 90],
        [1000, 3, 15],
        [300, 2, 45],
        [150, 1, 75],
        [250, 2, 35],
        [75, 1, 85],
        [400, 2, 25]
    ])
    
    print("Training AI model with normal transactions...")
    security.train_model(normal_data)
    
    # Test transactions
    test_transactions = [
        {'amount': 150, 'frequency': 1, 'time_since_last': 70},  # Normal
        {'amount': 50000, 'frequency': 15, 'time_since_last': 2}  # Anomalous
    ]
    
    for i, tx in enumerate(test_transactions):
        result = security.check_transaction_risk(tx)
        print(f"Transaction {i+1}: {result}")
    
    print("Security module test completed! ✅")
