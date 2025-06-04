resolving
resolveLoadList: loadList
	(loadList collect: [ :clusterName | self slice clusterNamed: clusterName ])
		do: [ :cluster | cluster halt ]