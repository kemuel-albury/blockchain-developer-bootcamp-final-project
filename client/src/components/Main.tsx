/* eslint-disable spaced-comment */
/// <reference types="react-scripts" />
import React, { useEffect, useState } from "react"
import { useEthers } from "@usedapp/core"
import helperConfig from "../helper-config.json"
import { constants } from "ethers"
import networkMapping from "../chain-info/deployments/map.json"
import brownieConfig from "../brownie-config.json"
import { Snackbar, Typography, makeStyles } from "@material-ui/core"
import { TokenFarmContract } from "../components/tokenFarmContract.tsx"
import Alert from "@material-ui/lab/Alert"
import swift from "../swift.png"
import eth from "../eth.png"
import dai from "../dai.png"
import { MyWallet } from "./myWallet"

export type Token = {
    image: string
    address: string
    name: string
}

const useStyles = makeStyles((theme) => ({
    title: {
      color: theme.palette.common.white,
      textAlign: "center",
      padding: theme.spacing(2),
    },
  }))

export const Main = () => {
    //Show token values from the wallet
    //Get address of the supported tokens
    //Get the balance of the user's wallet

    //send brownie-config to src folder
    //send build folder
    const classes = useStyles()
    const { chainId, error } = useEthers()
    const networkName = chainId ? helperConfig[chainId] : "dev"
    let stringChainId = String(chainId)
    console.log(chainId)
    console.log(networkName)
    const swiftTokenAddress = chainId ? networkMapping[stringChainId]["SwiftToken"][0] : constants.AddressZero
    const wethTokenAddress = chainId ? brownieConfig["networks"][networkName]["weth_token"] : constants.AddressZero
    const fauTokenAddress = chainId ? brownieConfig["networks"][networkName]["fau_token"] : constants.AddressZero

    const supportedTokens: Array<Token> = [
        {
            image: swift,
            address: swiftTokenAddress,
            name: "SWIFT"
        },
        {
            image: eth,
            address: wethTokenAddress,
            name: "WETH"
        },
        {

            image: dai,
            address: fauTokenAddress,
            name: "DAI"
        }


    ]

    const [showNetworkError, setShowNetworkError] = useState(false)

    const handleCloseNetworkError = (
      event: React.SyntheticEvent | React.MouseEvent,
      reason?: string
    ) => {
      if (reason === "clickaway") {
        return
      }
  
      showNetworkError && setShowNetworkError(false)
    }
  
    /**
     * useEthers will return a populated 'error' field when something has gone wrong.
     * We can inspect the name of this error and conditionally show a notification
     * that the user is connected to the wrong network.
     */
    useEffect(() => {
      if (error && error.name === "UnsupportedChainIdError") {
        !showNetworkError && setShowNetworkError(true)
      } else {
        showNetworkError && setShowNetworkError(false)
      }
    }, [error, showNetworkError])

    return (
        <>
          <Typography
            variant="h2"
            component="h1"
            classes={{
              root: classes.title,
            }}
          >
            Swift Token Farm
          </Typography>
          <MyWallet supportedTokens={supportedTokens} />
          <TokenFarmContract supportedTokens={supportedTokens} />
          <Snackbar
            open={showNetworkError}
            autoHideDuration={5000}
            onClose={handleCloseNetworkError}
          >
            <Alert onClose={handleCloseNetworkError} severity="warning">
              You gotta connect to the Rinkeby network!
            </Alert>
          </Snackbar>
        </>
      )
    }