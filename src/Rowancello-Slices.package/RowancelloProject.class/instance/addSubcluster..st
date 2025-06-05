subclusters
addSubcluster: aRowncelloSubcluster
	aRowncelloSubcluster class == RowancelloSubclusterProperties
		ifTrue: [ 
			"noop for now"
			self halt:  aRowncelloSubcluster name, ' -> RowancelloSubclusterProperties'].
	aRowncelloSubcluster class == RowancelloSubcluster
		ifTrue: [ 
			"self halt: aRowncelloSubcluster name, ' -> RowancelloSubcluster'"
			 ].

	self subclusters at: aRowncelloSubcluster name ifPresent: [ :v | self halt ].
	self subclusters at: aRowncelloSubcluster name put: aRowncelloSubcluster.
	^ aRowncelloSubcluster