api callbacks
setPackage: aString withBlock: aBlock

	| spec |
	spec := 
		(self project packageSpec)
			name: aString;
			yourself.
	spec currentAttributeList: self currentAttributeList.
	self root packages merge: spec.
	self with: spec during: aBlock