resolving
resolvePackageNamesInSubcluster: subclusterName using: resolutionContext
	"resolve the list of package names for the given subcluster using the given resolutionConext"

	| packageNames processedPackages |
	processedPackages := Set new.
	packageNames := ((self
		subclusterNamed: subclusterName
		ifAbsent: [ self error: 'Cluster named ' , subclusterName printString , ' not found' ])
		resolvePackageNamesUsing: resolutionContext
		in: self) asSet.
	[ packageNames = processedPackages ]
		whileFalse: [ 
			packageNames copy
				do: [ :packageName | 
					"access the package and follow the referenced chain to complete list of packages"
					(processedPackages includes: packageName)
						ifFalse: [ 
							| referenceDictionary |
							processedPackages add: packageName.	"record that we have processed packageName"
							referenceDictionary := (self packages at: packageName) referenced.
							referenceDictionary
								keysAndValuesDo: [ :expression :packageNameList | 
									| ast evaluator |
									ast := RwCAQParser new parse: expression.
									evaluator := RwCAQEvaluator context: resolutionContext ast: ast.
									evaluator evaluate
										ifTrue: [ 
											packageNameList
												do: [ :pName | 
													(self packages at: pName ifAbsent: [  ])
														ifNil: [ self packages at: pName put: (RowancelloPackageProperties new name: pName) ] ].
											packageNames addAll: packageNameList ] ] ] ] ].
	^ packageNames