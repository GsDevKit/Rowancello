api spec callbacks
projectForVersion: aString copyFrom: oldSpecName with: aBlock
    | spec projectSpec |
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