api callbacks
setBaseline: aString
    | spec projectSpec |
    projectSpec := self project baselineOfProjectSpec
        name: aString;
        className: 'BaselineOf' , aString;
        yourself.
self currentAttributeList ifNil: [self halt ].
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
	currentAttributeList: self currentAttributeList;
        yourself.
    self root packages merge: spec.
    ^ projectSpec