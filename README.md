## Test

Rari Capital testing tool to get more detailed debugging logs.

Contract to simulate interactions with:

https://etherscan.io/address/0xe33928b720799127a052b65498b322a206351441

All tests
```
forge test --fork-url $mainnetHTTPS_InfuraAPIKey 
```
Exact test to tune by input amounts
```
forge test --fork-url $mainnetHTTPS_InfuraAPIKey --match-test testRedeemUnderlyingExactAmount
```