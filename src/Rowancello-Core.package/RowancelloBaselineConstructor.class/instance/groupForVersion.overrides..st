api spec callbacks
groupForVersion: aString overrides: aStringOrCollection
    | spec |
    spec := self project groupSpec
        name: aString;
        includes: aStringOrCollection;
	currentAttributeList: self currentAttributeList;
        yourself.
    self commonVersionSpec packages add: spec