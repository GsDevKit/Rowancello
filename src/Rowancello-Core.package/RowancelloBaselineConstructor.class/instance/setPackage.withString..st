api callbacks
setPackage: aString withString: aFile

	| spec |
	spec := 
		(self project packageSpec)
			name: aString;
			file: aFile;
			yourself.
	spec currentAttributeList: self currentAttributeList.
	self commonVersionSpec packages merge: spec.