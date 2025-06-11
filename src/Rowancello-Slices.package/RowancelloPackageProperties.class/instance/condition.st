accessing
condition
	^ self properties at: 'condition' ifAbsent: [ 'common' ]