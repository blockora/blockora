from setuptools import setup, find_packages

setup(
    name="blockora",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "cryptography>=3.4.7",
        "scikit-learn>=0.24.2",
        "web3>=5.17.0",
        "numpy>=1.21.0"
    ],
    author="Blockora Team",
    description="Blockora Blockchain Implementation",
    keywords="blockchain, cryptocurrency, consensus",
    python_requires=">=3.8",
)
