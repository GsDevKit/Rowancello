clusters
clusterNamed: clusterName ifAbsent: absentBlock
	^ self clusters at: clusterName ifAbsent: [ ^ absentBlock value ]