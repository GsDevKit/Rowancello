rowan project creation
createRowanProjectFrom: aVersionSpec
	|  rowanProject |
	rowanProject := Rowan newV4ProjectNamed: projectSpec name.
	rowanProject halt.