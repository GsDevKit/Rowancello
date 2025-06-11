accessing
addReferenceNamed: referenceName condition: aCondition
	(self references at: aCondition ifAbsentPut: [ Set new ]) add: referenceName