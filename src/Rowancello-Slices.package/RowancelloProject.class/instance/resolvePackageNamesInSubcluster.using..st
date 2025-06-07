resolving
resolvePackageNamesInSubcluster: subclusterName using: resolutionContext
	"resolve the list of package names for the given subcluster using the given resolutionConext"
self halt.
	^ (self
		subclusterNamed: subclusterName
		ifAbsent: [ self error: 'Cluster named ' , subclusterName printString , ' not found' ])
		resolvePackageNamesUsing: resolutionContext
		in: self