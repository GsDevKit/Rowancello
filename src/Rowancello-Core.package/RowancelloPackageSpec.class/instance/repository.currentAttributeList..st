accessing
repository: anObject currentAttributeList: ignored
(UserGlobals at: #rowancellDebug ifAbsent: []) ifNotNil: [ self halt: self class name, '>>repository:currentAttributeList:'].
	self repository: anObject