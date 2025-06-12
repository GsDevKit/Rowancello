accessing
addReferenceNamed: referenceName condition: aCondition
	(self referenced at: aCondition ifAbsentPut: [ Set new ]) add: referenceName