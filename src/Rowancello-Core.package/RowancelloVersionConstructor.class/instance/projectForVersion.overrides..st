api spec callbacks
projectForVersion: aString overrides: aBlock
    | spec projectSpec |
    projectSpec := self project projectSpec
        name: aString;
        yourself.
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
	currentAttributeList: self currentAttributeList;
         yourself.
    self root packages add: spec.
    self with: projectSpec during: aBlock