api spec callbacks
projectForVersion: aString copyFrom: oldSpecName with: aBlock
    | spec projectSpec |
(UserGlobals at: #rowancellDebug ifAbsent: []) ifNotNil: [ self halt: self class name,  ' (', aString, ' <-- ', oldSpecName, ' >> projectForVersion:copyFrom:with: '].
    projectSpec := self project projectSpec
        name: aString;
        yourself.
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
	currentAttributeList: self currentAttributeList;
        yourself.
    self root packages copy: oldSpecName to: spec.
    self with: projectSpec during: aBlock