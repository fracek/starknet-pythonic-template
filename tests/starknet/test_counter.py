import pytest
from conftest import StarknetFactory, compile_contract
from starkware.starknet.testing.state import StarknetState


@pytest.fixture(scope="module")
async def starknet_factory():
    starknet = await StarknetState.empty()
    counter_def = compile_contract("counter.cairo")
    counter = await starknet.deploy(counter_def, constructor_calldata=[0])

    def _f():
        starknet_ = starknet.copy()
        return starknet_, [counter]

    return _f


@pytest.mark.asyncio
async def test_increment_counter(starknet_factory: StarknetFactory):
    starknet, [counter] = starknet_factory()

    await starknet.invoke_raw(
        contract_address=counter,
        selector="increment_counter",
        caller_address=1,
        calldata=[],
    )
