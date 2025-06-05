accessing
addPackage: aRowncelloPackage condition: aConditionExpression
	(self packages at: aConditionExpression ifAbsentPut: [ Set new ])
		add: aRowncelloPackage name