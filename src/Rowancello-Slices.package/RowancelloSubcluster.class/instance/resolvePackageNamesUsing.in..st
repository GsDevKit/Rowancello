resolving
resolvePackageNamesUsing: resolutionContext in: project
	| packageNames |
	packageNames := Set new.
	self packages
		keysAndValuesDo: [ :expression :names | 
			| ast evaluator |
			ast := RwCAQParser new parse: expression.
			evaluator := RwCAQEvaluator context: resolutionContext ast: ast.
			evaluator evaluate
				ifTrue: [ packageNames addAll: names ] ].
	self halt.
	self subclusters
		keysAndValuesDo: [ :expression :names | 
			| ast evaluator |
			ast := RwCAQParser new parse: expression.
			evaluator := RwCAQEvaluator context: resolutionContext ast: ast.
			evaluator evaluate
				ifTrue: [ 
					| targetSubclusters |
					targetSubclusters := IdentitySet new.
					names
						do: [ :subclusterName | 
							targetSubclusters
								add:
									(project subclusterNamed: subclusterName ifAbsent: [ self error: 'oops' ]) ].
					targetSubclusters
						do: [ :aSubcluster | 
							packageNames
								addAll:
									(aSubcluster resolvePackageNamesUsing: resolutionContext in: project) ] ] ].
	^ packageNames