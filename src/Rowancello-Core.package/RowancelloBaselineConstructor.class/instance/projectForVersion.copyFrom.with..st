api spec callbacks
projectForVersion: aString copyFrom: oldSpecName with: aBlock
    | spec projectSpec |
"
self halt: self class name,  ' (', aString, ' <-- ', oldSpecName, ' >> projectForVersion:copyFrom:with: '.
"
    projectSpec := self project projectSpec
        name: aString;
        yourself.
    spec := self project projectReferenceSpec
        name: aString;
        projectReference: projectSpec;
	currentAttributeList: self currentAttributeList;
        yourself.
    self commonVersionSpec packages copy: oldSpecName to: spec.
    self commonVersionSpec repositories copy: oldSpecName to: spec.
    self with: projectSpec during: aBlock