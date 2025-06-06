accessing
addSubclusterNamed: aSubclusterName condition: aCondition
	(self subclusters at: aCondition ifAbsentPut: [ Set new ]) add: aSubclusterName