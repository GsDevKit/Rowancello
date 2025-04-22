api spec callbacks
groupForVersion: aString with: aStringOrCollection
	| spec |
	spec := self project groupSpec
		name: aString;
		includes: aStringOrCollection;
		currentAttributeList: self currentAttributeList;
		yourself.
	self root packages merge: spec