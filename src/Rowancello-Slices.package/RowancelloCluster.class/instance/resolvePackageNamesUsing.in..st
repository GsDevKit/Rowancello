resolving
resolvePackageNamesUsing: resolutionContext in: project
	| packageNames |
	packageNames := Set new.
	self subclusters
		do: [ :subclusterName | 
			| subcluster |
			subcluster := project subclusterNamed: subclusterName.
			packageNames
				addAll: (subcluster resolvePackageNamesUsing: resolutionContext in: project) ].
	^ packageNames