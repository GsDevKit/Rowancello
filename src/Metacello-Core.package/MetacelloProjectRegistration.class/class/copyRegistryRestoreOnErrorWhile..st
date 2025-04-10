mutability
copyRegistryRestoreOnErrorWhile: aBlock
  "install copy of registry for duration of <aBlock> execution."

  "registrations will be copied on write during <aBlock> execution."

  "if <aBlock> does not return control to this context, revert to the original
	version of the registry. Otherwise leave the new copy installed."

  aBlock value "no current plans to emulate registry behavior"

