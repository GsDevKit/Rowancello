resolving
resolvePackageNamesInSubclusters: subclusterNames using: resolutionContext
	"resolve the list of package names for the given list ofsubclusters using the given resolutionConext"

	| packageNames |
	packageNames := Set new.
	subclusterNames
		do: [ :subclusterName | 
			packageNames
				addAll:
					(self resolvePackageNamesInSubcluster: subclusterName using: resolutionContext) ].
	^ packageNames