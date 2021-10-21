%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn, assert_not_zero
from starkware.starknet.common.messages import send_message_to_l1
from starkware.starknet.common.storage import Storage, storage_read, storage_write

# # Constants

const MESSAGE_UPDATE_COUNT = %[ 0 %]

# # Storage

# Address of the L1 contract
@storage_var
func _l1_counter_address() -> (address : felt):
end

# Current count
@storage_var
func _counter() -> (count : felt):
end

# # Public API

@external
func initialize{storage_ptr : Storage*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        l1_counter_address : felt):
    _l1_counter_address.write(l1_counter_address)
    return ()
end

@view
func get_l1_counter_address{storage_ptr : Storage*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        ) -> (address : felt):
    let (address) = _l1_counter_address.read()
    return (address=address)
end

@external
func increment_counter{
        syscall_ptr : felt*, storage_ptr : Storage*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        ):
    alloc_locals

    let (count) = _counter.read()
    let new_count = count + 1
    _counter.write(new_count)
    return ()
end

@external
func update_l1_counter{
        syscall_ptr : felt*, storage_ptr : Storage*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        ):
    alloc_locals

    let (count) = _counter.read()

    let (local l1_counter) = _l1_counter_address.read()

    let (message_payload : felt*) = alloc()
    assert message_payload[0] = MESSAGE_UPDATE_COUNT
    assert message_payload[1] = count

    send_message_to_l1(to_address=l1_counter, payload_size=2, payload=message_payload)

    return ()
end
