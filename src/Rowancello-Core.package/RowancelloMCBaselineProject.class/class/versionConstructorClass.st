accessing
versionConstructorClass
	false
		ifTrue: [ 
			"out-of-date ... do not use"
			^ RowancelloVersionConstructor ]
		ifFalse: [ 
			"full set of attributes is NOW traversed, so we generate results for all attributes; HOWEVER,  spec copyFrom:with: is not able to copy the repostories correctly .... although this seems to be the correct route and is the current working version..."
			^ RowancelloBaselineConstructor ]