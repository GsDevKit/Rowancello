accessing
versionConstructorClass
	true
		ifTrue: [ 
			"full set of attributes is traversed, so we generate results for all attributes; picking up loads and versionString args!!! HOWEVER,  spec copyFrom:with: is not able to copy the repostories correctly"
			^ RowancelloVersionConstructor ]
		ifFalse: [ 
			"only attributes that apply to current platform are traversed, so we generate  INCOMPLETEresults for all attributes!!! HOWEVER,  spec copyFrom:with: is not able to copy the repostories correctly .... although this seems to be the correct route and is the current working version ... 
				-- review the logic in RowancelloVersionConstructor to pick up the platform coverage
				-- I think the secret is in getting the member processing correct ... compare DEBUGGIG with tode image"
			^ RowancelloBaselineConstructor ]