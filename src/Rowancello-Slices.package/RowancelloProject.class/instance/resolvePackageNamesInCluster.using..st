resolving
resolvePackageNamesInCluster: clusterName using: resolutionContext
	"resolve the list of package names for the given cluster using the given resolutionConext"

	^ (self
		clusterNamed: clusterName
		ifAbsent: [ self error: 'Cluster named ' , clusterName printString , ' not found' ])
		resolvePackageNamesUsing: resolutionContext
		in: self