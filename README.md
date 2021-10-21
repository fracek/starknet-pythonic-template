# StarkNet Project Template

This is an opinionated StarkNet project template. It is based around 
the Python's ecosystem and best practices.

 * `tox` to manage project tasks
 * `brownie` to build and test L1 contracts
 * `cairo-lang` to build and test StarkNet contracts
 * `black` for formatting Python files
 * `isort` for sorting imports in Python and Cairo files

## Getting Started

 * Create a new virtual environment with `python -m venv venv`
 * Activate the virtual environment with `source venv/bin/activate`
 * Install the project and it's dependencies with `python -m pip install -e .[testing]`.
   This will make the Cairo contracts available to other Cairo projects on your
   machine (as long as they share the same virtual environment).

## Configuration

Configure brownie using `.env`, for example:

```
export WEB3_INFURA_PROJECT_ID=<your-project-id>
export ETHERSCAN_TOKEN=<your-etherscan-token>
```

## Commands

 * `tox -av`: list available commands
 * `tox`: run tests
 * `tox -e build`: build smart contracts
 * `tox -e lint`: lint files
 * `tox -e format`: automatically format files

## Alternatives

I prefer dapptools to brownie for layer-1 development. In the future I will explore
a template where I mix dapptools with [nile](https://github.com/martriay/nile).
