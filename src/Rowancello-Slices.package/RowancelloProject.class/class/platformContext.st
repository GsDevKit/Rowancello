conditions
platformContext
	| context |
	context := RwCAQContext new.
	context set: 'common'.
	context set: 'gemstone'.
	context set: 'gemstone.version' to: '3.7.5' asRwGemStoneVersionNumber.
	^ context