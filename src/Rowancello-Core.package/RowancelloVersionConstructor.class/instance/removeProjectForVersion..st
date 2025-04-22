api spec callbacks
removeProjectForVersion: aString
    | spec |
    spec := self project projectReferenceSpec
        name: aString;
	currentAttributeList: self currentAttributeList;
         yourself.
    self root packages remove: spec