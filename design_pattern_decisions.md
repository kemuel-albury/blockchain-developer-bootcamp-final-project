# Design patterns used

## Access Control Design Patterns

- `Ownable` design pattern used in three functions:  `function setPriceFeedContract(address _token, address _priceFeed)
`, `issueTokens()` and `addAllowedTokens(address _token)`. The functions listed shouldn't be used by non-contract creators.

## Inheritance and Interfaces

- `TokenFarm` contract inherits the OpenZeppelin `Ownable` contract to enable ownership within the contract.
