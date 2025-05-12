api callbacks
setBaseline: aString
    | spec projectSpec |
    projectSpec := self project baselineOfProjectSpec
        name: aString;
        className: 'BaselineOf' , aString;
        yourself.
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
	currentAttributeList: self currentAttributeList;
        yourself.
    self commonVersionSpec packages merge: spec.
    ^ projectSpec