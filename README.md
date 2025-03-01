# Private Compliance module 

## Architecture

This repository uses OnchainIDs claim topics to address KYC and AML checks and has trusted issuers who can issue these topics


Refer OnchainID - https://github.com/onchain-id/claim-topics/blob/master/src/claim_topics.json


## Usecase

This module can be imported to different compliant protocols like tokens and check for correctness or eligibility of users 

## Just a prototype

While this is just a prototype , we can scale this to follow a more structured Onchain Identity system and compliance system alreasy establishes in ethereum
But ZK...

## How to run 
Deploy on leo playground and run following commands



Register user 
```bash
leo run register_trusted_issuer aleo1w9waxl5u84vxn2ftuk3cs3vjrphg47a0s67xykx0mqzzatx9jvqqrp2ld4 --private-key YOUR_PRIVATE_KEY
```
Create user create_user_data
```
leo run create_user_data 25u8 840u16 720u16 --private-key YOUR_PRIVATE_KEY
```
Check eligibility
```bash
leo run verify_eligibility_public 25u8 840u16 720u16
```
Issue a Claim if true 

```
leo run issue_claim aleo1w9waxl5u84vxn2ftuk3cs3vjrphg47a0s67xykx0mqzzatx9jvqqrp2ld4 1u8 500u64 1000000u32 --private-key YOUR_PRIVATE_KEY
```

