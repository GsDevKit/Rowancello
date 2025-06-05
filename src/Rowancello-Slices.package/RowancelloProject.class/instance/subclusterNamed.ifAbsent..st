accessing
subclusterNamed: subclusterName ifAbsent: absentBlock
	^ self subclusters at: subclusterName ifAbsent: [ ^ absentBlock value ]