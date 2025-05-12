api spec callbacks
removeProjectForVersion: aString
    | spec |
    spec := self project projectReferenceSpec
        name: aString;
	currentAttributeList: self currentAttributeList;
         yourself.
    self commonVersionSpec packages remove: spec