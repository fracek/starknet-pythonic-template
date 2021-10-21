from __future__ import annotations

import asyncio
from pathlib import Path
from typing import List, Protocol, Tuple

import pytest
from starkware.starknet.compiler.compile import compile_starknet_files
from starkware.starknet.testing.state import StarknetState


class StarknetFactory(Protocol):
    def __call__(self) -> Tuple[StarknetState, List[int]]:
        ...


@pytest.fixture(scope="session")
def event_loop():
    return asyncio.new_event_loop()


_root_dir = Path(__file__).parent.parent


def compile_contract(contract_name):
    filename = contract_path(contract_name)
    return compile_starknet_files(
        [filename], debug_info=True, cairo_path=[str(_root_dir / "src" / "starknet")]
    )


def contract_path(contract_name):
    return str(_root_dir / "src" / "starknet" / contract_name)
