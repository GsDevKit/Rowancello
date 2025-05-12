accessing
map
	
	| map |
"	GsFile gciLogServer: self class name , ' BEGIN'. "
	memberMap ~~ nil ifTrue: [ ^memberMap ].
	map := Dictionary new.
	self list do: [:member | 
		GsFile gciLogServer: 'repository member spec ', member name.
		member
			applyAdd: [:memberSpec | "GsFile gciLogServer: 'ADD'."  self mapAdd: memberSpec into: map ] 
			copy: [:memberSpec | GsFile gciLogServer: 'COPY'.  self mapCopy: memberSpec into: map ]
			merge: [:memberSpec | "GsFile gciLogServer: 'MERGE'.  "self mapMerge: memberSpec into: map ] 
			remove: [:memberSpec | "GsFile gciLogServer: 'REMOVE'. " self mapRemove: memberSpec into: map ]].
	memberMap := map.
"	GsFile gciLogServer:  self class name , ' END'. "
	^memberMap