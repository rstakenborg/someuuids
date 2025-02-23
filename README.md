# someuuids

Reserves a pool of UUIDs for a local user to then author content without conflicts

[Snippet syntax](https://manual.macromates.com/en/snippets)

### remoteid

Tracking the highest ID used on the project. If editing this must be checked-in

### nextid

Pre-allocated ID for your next asset. Decrement this by 1 as you use the IDs. Call getuuid.ps1 to replenish if this drops to 0

## Decisions

### Using a pool of IDs

Allocating a local pool simplifies how often the source of truth (in this case a shared, version-controlled file) may be modified, which reduces the potential for conflicts. This also reduces the complexity of the more common task of using the IDs, in particular reducing the time it takes to reserve one when the artist is focused on creating an asset, and does not want to context-switch.

#### Limitations

For single-project use this UUID method should be fine, but over many projects it may make sense to reset, reserve or pre-allocate certain ranges.

### Using A file to track

This system could mature into a UUID service at some point, but the risk of adding infrastructure and additional tribal knowledge of that system is currently outweighed by getting something in

#### Limitations

There is technically an artificial restriction in that VCS must be avaialble at the time of pool allocation, but this also means that Sean can work offline so long as he does not run through the pool before reconnecting.

### Linear UUIDs

Code snippets actually support UUID A Version 4 UUID, so if we do not actually need to track burnt UUIDs this could be a great option. In lieu of that, chunking UUIDs based on a 64 bit int is fine.

### behavior

We work backwards from the preallocated chunk highest ID to the lowest, it just makes the code flow a bit nicer
