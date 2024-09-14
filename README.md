

```markdown
First Bidder Private Key:  
APrivateKey1zkpAUnFiPtiFoRQjzWAmNYaMsLbeHndsSKPGfTfaC46FG6n
First Bidder Address: 
aleo16efqerpvs8a3t86075ea204k2sjyv3r6jp4y4q3x4u2vqcdh9ypsher9tc

Second Bidder Private Key:
APrivateKey1zkpGynsJcEhdjsEXfsqDCHMqicFgLLnJZt2bbFzNTyXgdEA
Second Bidder Address:
aleo1u8ec47fkx4u7w7xg30er975kqwlnhvqalkrsm4x52cxwdk4uav8szt8w4n

Auctioneer Private Key:
APrivateKey1zkpDFALspUfpyhAEK1QyZZaS6xb2VYr5WScp4gqFsKAyLUi
Auctioneer Address:
aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py
```
## <a id="step1"></a> Step 1: The First Bid

Have the first bidder place a bid of 10. 

Swap in the private key and address of the first bidder to `.env`.

```bash
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkpAUnFiPtiFoRQjzWAmNYaMsLbeHndsSKPGfTfaC46FG6n
ENDPOINT=https://api.explorer.aleo.org/v1" > .env
```

Call the `place_bid` program function with the first bidder and `10u64` arguments.

```bash
leo run place_bid aleo16efqerpvs8a3t86075ea204k2sjyv3r6jp4y4q3x4u2vqcdh9ypsher9tc 10u64
```

## <a id="step2"></a> Step 2: The Second Bid

Have the second bidder place a bid of 90.

Swap in the private key of the second bidder to `.env`.

```bash
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkpGynsJcEhdjsEXfsqDCHMqicFgLLnJZt2bbFzNTyXgdEA
ENDPOINT=https://api.explorer.aleo.org/v1" > .env
```

Call the `place_bid` program function with the second bidder and `90u64` arguments.

```bash
leo run place_bid aleo1u8ec47fkx4u7w7xg30er975kqwlnhvqalkrsm4x52cxwdk4uav8szt8w4n 90u64
```

## <a id="step3"></a> Step 3: Select the Winner

Have the auctioneer select the winning bid.

Swap in the private key of the auctioneer to `.env`.

```bash
echo "
NETWORK=testnet
PRIVATE_KEY=APrivateKey1zkpDFALspUfpyhAEK1QyZZaS6xb2VYr5WScp4gqFsKAyLUi
ENDPOINT=https://api.explorer.aleo.org/v1" > .env
```

Provide the two `Bid` records as input to the `resolve` transition function.

```bash 
leo run resolve "{
    owner: aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py.private,
    bidder: aleo16efqerpvs8a3t86075ea204k2sjyv3r6jp4y4q3x4u2vqcdh9ypsher9tc.private,
    amount: 10u64.private,
    is_winner: false.private,
    _nonce: 4668394794828730542675887906815309351994017139223602571716627453741502624516group.public
}" "{
    owner: aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py.private,
    bidder: aleo1u8ec47fkx4u7w7xg30er975kqwlnhvqalkrsm4x52cxwdk4uav8szt8w4n.private,
    amount: 90u64.private,
    is_winner: false.private,
    _nonce: 5952811863753971450641238938606857357746712138665944763541786901326522216736group.public
}"
```

## <a id="step4"></a> Step 4: Finish the Auction

Call the `finish` transition function with the winning `Bid` record.

```bash 
leo run finish "{
    owner: aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py.private,
    bidder: aleo1u8ec47fkx4u7w7xg30er975kqwlnhvqalkrsm4x52cxwdk4uav8szt8w4n.private,
    amount: 90u64.private,
    is_winner: false.private,
    _nonce: 0group.public
}"
   
```


## <a id="step5"></a> Step 5: Claim the prize.



