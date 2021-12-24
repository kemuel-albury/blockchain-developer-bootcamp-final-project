import { Token } from "../Main"
import React, { useState } from "react"
import { Box, Tab, makeStyles } from "@material-ui/core"
import { TabContext, TabList, TabPanel } from "@material-ui/lab"
import { WalletBalance } from "./WalletBalance"
import { StakeForm } from "./StakeForm"
import { ConnectionRequiredMsg } from "../ConnectionRequiredMsg"
import { useEthers } from "@usedapp/core"

interface MyWalletProps {
    supportedTokens: Array<Token>
}

const useStyles = makeStyles((theme) => ({
    tabContent: {
        display: "flex",
        flexDirection: "row",
        alignItems: "center",
        padding: theme.spacing(2)
    },
    box: {
        backgroundColor: "white",
        borderRadius: "25px",
    },
    header: {
        color: "white"
    }
}))

export const MyWallet = ({ supportedTokens }: MyWalletProps) => {
    const [selectedTokenIndex, setSelectedTokenIndex] = useState<number> (0)

    const handleChange = (event: React.ChangeEvent<{}>, newValue: string) => {
        setSelectedTokenIndex(parseInt(newValue))
    }

    const { account } = useEthers()
    const isConnected = account !== undefined

    const classes = useStyles()
    return (
        <Box>
          <h1 className={classes.header}>My Wallet</h1>
          <Box className={classes.box}>
            <div>
              {isConnected ? (
                <TabContext value={selectedTokenIndex.toString()}>
                  <TabList onChange={handleChange} aria-label="stake form tabs">
                    {supportedTokens.map((token, index) => {
                      return (
                        <Tab
                          label={token.name}
                          value={index.toString()}
                          key={index}
                        />
                      )
                    })}
                  </TabList>
                  {supportedTokens.map((token, index) => {
                    return (
                      <TabPanel value={index.toString()} key={index}>
                        <div className={classes.tabContent}>
                          <WalletBalance
                            token={supportedTokens[selectedTokenIndex]}
                          />
                          <StakeForm token={supportedTokens[selectedTokenIndex]} />
                        </div>
                      </TabPanel>
                    )
                  })}
                </TabContext>
              ) : (
                <ConnectionRequiredMsg />
              )}
            </div>
          </Box>
        </Box>
      )
    }