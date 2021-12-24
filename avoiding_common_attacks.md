# Contract security measures

## SWC-103 (Floating pragma)

Specific compiler pragma `0.8.0` used in contracts to avoid accidental bug inclusion through outdated compiler versions.

## SWC-100 (Function Default Visibility)

The `updateUniqueTokensStaked()` function in the contract has been given a visiblity of `internal` to avoid being set as `public` as default.
