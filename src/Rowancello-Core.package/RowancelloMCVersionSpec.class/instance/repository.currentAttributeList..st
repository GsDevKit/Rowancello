accessing
repository: aStringOrSpec currentAttributeList: attributeList

self halt: self class name, ' repository: ... THIS IS THE SPOT'.

	aStringOrSpec addToMetacelloRepositories: self currentAttributeList: attributeList