accessing
addPackage: aRowncelloPackage condition: aCondition
	(self packages at: aCondition ifAbsentPut: [ Set new ])
		add: aRowncelloPackage name