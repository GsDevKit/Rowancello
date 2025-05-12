api callbacks
setPackage: aString withBlock: aBlock

	| spec |
	spec := 
		(self project packageSpec)
			name: aString;
			yourself.
	spec currentAttributeList: self currentAttributeList.
	self commonVersionSpec packages merge: spec.
	self with: spec during: aBlock