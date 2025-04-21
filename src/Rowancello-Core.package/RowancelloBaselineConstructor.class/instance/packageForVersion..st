api spec callbacks
packageForVersion: aString
	| spec |
	spec := self project packageSpec
		name: aString;
		yourself.
	spec currentAttributeList: self currentAttributeList.
	self root packages add: spec