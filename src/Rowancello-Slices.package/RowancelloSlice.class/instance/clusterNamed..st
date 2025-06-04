accessing
clusterNamed: clusterName
	^ self clusters
		detect: [ :cluster | cluster name = clusterName ]
		ifNone: [ 
			self
				error: 'No cluster named ' , clusterName printString , ' in slice ' , self name ]