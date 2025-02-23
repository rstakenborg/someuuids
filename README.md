# someuuids

Reserves a pool of UUIDs for a local user to then author content without conflicts

## Usage

Opening the project in VSCode, you now have a Task called "Generate New Entity". To use it:

- CTRL+P to bring up the _palette_
- Select "Run Task"
  ![Run Task from Palette](/screenshots/runtask.png?raw=true "Running a 'Task'")
- Select "Generate New Entity"
  ![Select Generate New Entity](/screenshots/generatenewentity.png?raw=true "Select the Task")
- Follow the prompts to get a new entity
  ![Name your entity](/screenshots/nameentity.png?raw=true "Name the entity using the prompt")
  ![Select the snippet to prefill](/screenshots/selectsnippet.png?raw=true "Select Entity Snippet")
- Review your new file
  ![Review and continue to edit the Entity](/screenshots/reviewchange.png?raw=true "Review the results")

### UUID generation

The getuuid script provided stores preallocated IDs in localid.json. When you run out, it automatically replenishes, and updates the remoteid file so that other users will not preallocate the same IDs

## Extending

Snippets have a ton of functionality, including UUIDs, date/timestampe etc.

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

## Future Considerations

- VSCode allows for keybindings which could make for a really quick option. Given the team technical skills, keyboard shortcuts may be appreciated
- A prettify/format would go a long way with more complex snippets
- Really complex snippets can be added as separate files instead of inline as currently done
- insertSnippet command used to take a dict of arguments to allow a specific snippet to be provided, but this seems to have changed. We may be able to reduce the prompts for the user
