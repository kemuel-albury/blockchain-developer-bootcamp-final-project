# Design patterns used

## Access Control Design Patterns

- `Ownable` design pattern used in three functions:  `function setPriceFeedContract()
`, `issueTokens()` and `addAllowedTokens()`. The functions listed shouldn't be used by non-contract creators.

## Inheritance and Interfaces

- `TokenFarm` contract inherits the OpenZeppelin `Ownable` contract to enable ownership within the contract.
