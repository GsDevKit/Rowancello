construction
repository: aStringOrMetacelloRepositorySpec currentAttributeList: attributeList
	| theSpec |
self halt: 'repository:currentAttributeList: '.
	self repositories repository: aStringOrMetacelloRepositorySpec.
	self projectPackage: nil.
	theSpec := self repositories repositoryNamed: aStringOrMetacelloRepositorySpec.
	theSpec currentAttributeList: attributeList.