api callbacks
setProject: aString withString: versionString

	| spec projectSpec |
	projectSpec := 
		(self project projectSpec)
			name: aString;
			versionString: versionString;
			yourself.
	spec := 
		(self project projectReferenceSpec)
			name: aString;
			projectReference: projectSpec;
			currentAttributeList: self currentAttributeList;
 			yourself.
	self commonVersionSpec packages merge: spec.