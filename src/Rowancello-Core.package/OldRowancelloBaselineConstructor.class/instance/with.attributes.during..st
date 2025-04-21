private
with: metacelloSpec attributes: attributeList during: aBlock
	| previousRoot |
	previousRoot := self root.
	self root: metacelloSpec.
	aBlock
		ensure: [ 
			self
				root: previousRoot ]