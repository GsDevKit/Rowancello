resolving
resolvePackageNamesInCluster: clusterName using: resolutionContext
	"resolve the list of package names for the given cluster using the given resolutionConext"

	| packageNames processedPackages |
	processedPackages := Set new.
	packageNames := ((self
		clusterNamed: clusterName
		ifAbsent: [ self error: 'Cluster named ' , clusterName printString , ' not found' ])
		resolvePackageNamesUsing: resolutionContext
		in: self) asSet.
	[ packageNames = processedPackages ]
		whileFalse: [ 
			packageNames copy
				do: [ :packageName | 
					"access the package and follow the referenced chain to complete list of packages"
					(processedPackages includes: packageName)
						ifFalse: [ 
							| referenced |
							referenced := (self packages at: packageName) referenced.
							packageNames addAll: referenced.
							processedPackages add: packageName ] ] ].
	^ packageNames