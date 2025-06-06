accessing
addSubcluster: aRowancelloSubcluster condition: aCondition
	(self subclusters at: aCondition ifAbsentPut: [ Set new ])
		add: aRowancelloSubcluster name