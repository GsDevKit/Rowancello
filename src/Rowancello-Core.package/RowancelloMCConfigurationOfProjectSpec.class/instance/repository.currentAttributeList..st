construction
repository: aStringOrMetacelloRepositorySpec currentAttributeList: attributeList
	| theSpec |
(UserGlobals at: #rowancellDebug ifAbsent: []) ifNotNil: [ self halt: self class name, '>>repository:currentAttributeList:' ].
	self repositories repository: aStringOrMetacelloRepositorySpec.
	self projectPackage: nil.
	theSpec := self repositories repositoryNamed: aStringOrMetacelloRepositorySpec.
	theSpec currentAttributeList: attributeList.