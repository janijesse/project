program project.aleo {

    record Bid {
        owner: address,
        bidder: address,
        amount: u64,
        is_winner: bool,
    }

    record Prize {
        owner: address,
        amount: u64
    }

    transition place_bid(bidder: address, amount: u64) -> Bid {
        // Ensure the caller is the bidder
        assert_eq(self.caller, bidder);
        
        return Bid {
            owner: aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py,
            bidder: bidder,
            amount: amount,
            is_winner: false,
        };
    }

    transition resolve(first: Bid, second: Bid) -> Bid {
        // Ensure the caller is the auction owner
        assert_eq(self.caller, aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py);
       
        if (first.amount >= second.amount) {
            return first;
        } else {
            return second;
        }
    }

    transition finish(bid: Bid) -> Bid {
        // Ensure the caller is the auction owner
        assert_eq(self.caller, aleo1emd7uh393af4a4wqdzm5jck0wj039h7ta5c06nxz0khpx8qegvqsj4x8py);
        
        return Bid {
            owner: bid.bidder,
            bidder: bid.bidder,
            amount: bid.amount,
            is_winner: true,
        };
    }

    transition claim(bid: Bid) -> Prize {
        // Ensure the bid is the winning bid
        assert_eq(bid.is_winner, true);

        // Ensure the caller is the winning bidder
        assert_eq(self.caller, bid.bidder);

        // Create and return the Prize
        // Note: In a real auction, this would transfer the auctioned item
        return Prize {
            owner: bid.owner, // The prize owner is the original auction owner
            amount: bid.amount // The amount is the winning bid amount
        };
    }
}