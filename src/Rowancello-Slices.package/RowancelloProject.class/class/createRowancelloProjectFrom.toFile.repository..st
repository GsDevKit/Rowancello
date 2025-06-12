conversion
createRowancelloProjectFrom: sourceMetadataFile toFile: destinationMetadata repository: repository
	| dict projectName packagesMap metadataDict slice cluster project subclusterNames |
	dict := ((STON reader allowComplexMapKeys: true)
		on: (repository asFileReference / sourceMetadataFile) readStream) next.
	projectName := dict keys any.
	packagesMap := Dictionary new.
	metadataDict := dict at: projectName.
	project := self new
		name: projectName;
		yourself.
	slice := RowancelloSlice new
		name: projectName;
		yourself.
	cluster := RowancelloCluster new
		name: 'CoreCluster';
		yourself.
	project
		addCluster: cluster;
		addSlice: slice;
		yourself.
	slice addCluster: cluster.
	subclusterNames := (metadataDict at: 'Groups' ifAbsent: [ Dictionary new ])
		keys.
	(metadataDict at: 'Groups' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :subclusterName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :packagesDict | 
					| subCluster packageOrSubclusters includes requires referenced condition |
					condition := self createConditionExpressionFrom: conditionArray.
					subCluster := project
						subclusterNamed: subclusterName
						ifAbsent: [ 
							project
								addSubcluster:
									(RowancelloSubcluster new
										name: subclusterName;
										yourself) ].
					packageOrSubclusters := (includes := packagesDict
						at: 'includes'
						ifAbsent: [ {} ]) copy.
					packageOrSubclusters
						addAll: (requires := packagesDict at: 'requires' ifAbsent: [ {} ]).
					referenced := includes copy.
					referenced addAll: requires.
					packageOrSubclusters
						do: [ :packageOrSubclusterName | 
							| thePackageOrSubcluster |
							thePackageOrSubcluster := packagesMap
								at: packageOrSubclusterName
								ifAbsentPut: [ 
									(subclusterNames includes: packageOrSubclusterName)
										ifTrue: [ 
											thePackageOrSubcluster := project
												subclusterNamed: packageOrSubclusterName
												ifAbsent: [ 
													project
														addSubcluster:
															(RowancelloSubcluster new
																name: packageOrSubclusterName;
																yourself) ].
											subCluster addSubcluster: thePackageOrSubcluster condition: condition.
											referenced remove: packageOrSubclusterName ifAbsent: [  ].
											thePackageOrSubcluster ]
										ifFalse: [ 
											thePackageOrSubcluster := RowancelloPackageProperties new
												name: packageOrSubclusterName;
												yourself.
											subCluster addPackage: thePackageOrSubcluster condition: condition.
											referenced
												do: [ :referenceName | 
													referenceName = packageOrSubclusterName
														ifFalse: [ thePackageOrSubcluster addReferenceNamed: referenceName condition: condition ] ].
											referenced := Set new.
											project addPackage: thePackageOrSubcluster.
											thePackageOrSubcluster ] ].
							referenced remove: packageOrSubclusterName ifAbsent: [  ] ].
					referenced isEmpty
						ifFalse: [ 
							referenced
								do: [ :unrefName | subCluster addSubclusterNamed: unrefName condition: condition ] ].
					project addSubcluster: subCluster.
					cluster addSubcluster: subCluster ] ].
	(metadataDict at: 'Packages' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :thePackageName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :packageDict | 
					| packageProperties theConditionArray includes requires referenced |
					theConditionArray := conditionArray copy.

					includes := packageDict at: 'includes' ifAbsent: [ {} ].
					requires := packageDict at: 'requires' ifAbsent: [ {} ].
					referenced := includes copy.
					referenced addAll: requires.
					packagesMap
						at: thePackageName
						ifPresent: [ :val | 
							val condition
								ifNotNil: [ :suplementalCondArray | (theConditionArray addAll: suplementalCondArray) asSet asArray ] ].
					packageProperties := packagesMap
						at: thePackageName
						ifAbsentPut: [ 
							RowancelloPackageProperties new
								name: thePackageName;
								yourself ].
					packageDict
						at: 'file'
						ifPresent: [ :fileProperty | packageProperties properties at: 'file' put: fileProperty ].
					packageProperties
						comment:
							'additional package properties that need to be used to supplement the "includes" and "required" packages'.
					referenced isEmpty
						ifFalse: [ 
							| condition |
							condition := self createConditionExpressionFrom: conditionArray.
							referenced
								do: [ :ref | packageProperties addReferenceNamed: ref condition: condition ] ] ] ].
	(metadataDict at: 'ProjectReferences' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :theProjectName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :projectDict | 
					| subCluster |
					false ifTrue: [ self halt: 'not implemented/converted/tested' ].
					subCluster := RowancelloSubcluster new
						name: theProjectName;
						projects: (projectDict at: 'repositories' ifAbsent: [ {} ]);
						comment:
								'The list of "projects" is a list of repository URLs for the project';
						yourself.	"	
				condition: (self createConditionExpressionFrom: conditionArray); "
					project addSubcluster: subCluster.
					cluster addSubcluster: subCluster ] ].
	self
		writeObjectToDisk: project
		filename: repository asFileReference / destinationMetadata