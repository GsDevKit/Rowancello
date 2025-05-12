accessing
repository: anObject currentAttributeList:ignored
true ifTrue: [ self halt: self class name, '>>repository:currentAttributeList:' ].
self repository: anObject