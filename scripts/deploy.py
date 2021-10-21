from brownie import accounts, Counter


STARKNET_CORE = "0x5e6229F2D4d977d20A50219E521dE6Dd694d45cc"


def main():
    deployer = accounts.load("deployer")
    Counter.deploy(STARKNET_CORE, {"from": deployer})
