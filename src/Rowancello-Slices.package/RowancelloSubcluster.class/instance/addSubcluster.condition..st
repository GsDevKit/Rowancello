accessing
addSubcluster: aRowancelloSubcluster condition: aConditionExpression
	(self packages at: aConditionExpression ifAbsentPut: [ Set new ])
		add: aRowancelloSubcluster name