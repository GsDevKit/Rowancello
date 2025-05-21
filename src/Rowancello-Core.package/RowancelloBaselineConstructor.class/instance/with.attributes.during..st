private
with: metacelloSpec attributes: attributeList during: aBlock
	| previousRoot previousCommon src |
	src := aBlock _sourceString.
	previousRoot := self root.
	self root: metacelloSpec.
	previousCommon := self commonVersionSpec.
	self commonVersionSpec: metacelloSpec.
	self currentAttributeList: attributeList.
	aBlock
		ensure: [ 
			self
				root: previousRoot.
			self  commonVersionSpec:  previousCommon.
			previousCommon == previousRoot ifFalse: [ self halt: 'OOPS - common/root mismiatch' ]]