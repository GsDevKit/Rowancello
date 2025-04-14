*base-metacello-core
classNamed: aString

| sym |
sym := aString asSymbol.
^ self 
	at: sym
	ifAbsent: [ nil ]
