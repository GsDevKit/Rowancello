private
with: metacelloSpec attributes: attributeList during: aBlock
	| previousRoot |
	previousRoot := self root.
	self root: metacelloSpec.
	self currentAttributeList: attributeList.
	aBlock
		ensure: [ 
			self
				root: previousRoot ]