api callbacks
setConfiguration: aString withBlock: aBlock
    | spec projectSpec |
    projectSpec := self project configurationOfProjectSpec
        name: aString;
        yourself.
self currentAttributeList ifNil: [self halt ].
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
	currentAttributeList: self currentAttributeList;
        yourself.
    self root packages merge: spec.
    self with: projectSpec during: aBlock