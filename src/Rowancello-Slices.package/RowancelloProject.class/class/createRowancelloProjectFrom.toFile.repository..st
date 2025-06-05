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
					(self convertForConditions: conditionArray)
						ifTrue: [ 
							| subCluster packages includes requires referenced |
							subCluster := RowancelloSubcluster new
								name: subclusterName;
								condition: (self createConditionExpressionFrom: conditionArray);
								yourself.
							packages := (includes := packagesDict at: 'includes' ifAbsent: [ {} ])
								copy.
							packages
								addAll: (requires := packagesDict at: 'requires' ifAbsent: [ {} ]).
							referenced := includes copy.
							referenced addAll: requires.
							packages
								do: [ :packageName | 
									| thePackageProperty |
									thePackageProperty := packagesMap
										at: packageName
										ifAbsentPut: [ 
											(subclusterNames includes: packageName)
												ifTrue: [ 
													thePackageProperty := RowancelloSubclusterProperties new
														name: packageName;
														yourself.
													subCluster addSubcluster: thePackageProperty.
													referenced remove: packageName ifAbsent: [  ].
													subCluster addSubcluster: thePackageProperty ]
												ifFalse: [ 
													thePackageProperty := RowancelloPackageProperties new
														name: packageName;
														yourself.
													subCluster addPackage: thePackageProperty.
													project addPackage: thePackageProperty.
													referenced remove: packageName ifAbsent: [  ] ] ] ].
							referenced isEmpty
								ifFalse: [ referenced do: [ :unrefName | subCluster addSubclusterNamed: unrefName ] ].
							project addSubcluster: subCluster.
							cluster addSubcluster: subCluster ] ] ].
	(metadataDict at: 'Packages' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :thePackageName :condDict | 
			(self
				convertForConditions:
					(condDict keys asArray
						collect: [ :each | 
							(each isKindOf: Symbol)
								ifTrue: [ each asString ]
								ifFalse: [ each ] ]))
				ifTrue: [ 
					condDict
						keysAndValuesDo: [ :conditionArray :packageDict | 
							| packageProperties theConditionArray |
							theConditionArray := conditionArray copy.
							packagesMap
								at: thePackageName
								ifPresent: [ :val | 
									val condition
										ifNotNil: [ :suplementalCondArray | (theConditionArray addAll: suplementalCondArray) asSet asArray ] ].
							packageProperties := (packagesMap
								at: thePackageName
								ifAbsentPut: [ 
									RowancelloPackageProperties new
										name: thePackageName;
										yourself ])
								condition: (self createConditionExpressionFrom: conditionArray);
								comment:
										'additional package properties that need to be used to supplement the "includes" and "required" packages';
								yourself.
							packageDict
								at: 'file'
								ifPresent: [ :fileProperty | packageProperties properties at: 'file' put: fileProperty ] ] ] ].
	(metadataDict at: 'ProjectReferences' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :theProjectName :condDict | 
			(self
				convertForConditions:
					(condDict keys asArray collect: [ :each | each asString ]))
				ifTrue: [ 
					condDict
						keysAndValuesDo: [ :conditionArray :projectDict | 
							| subCluster |
							self
								halt:
									'not implemented/converted/tested -- presumably used for http projects'.
							subCluster := RowancelloSubcluster new
								name: theProjectName;
								condition: (self createConditionExpressionFrom: conditionArray);
								projects: (projectDict at: 'repositories' ifAbsent: [ {} ]);
								comment:
										'The list of "projects" is a list of repository URLs for the project';
								yourself.
							project addSubcluster: subCluster.
							cluster addSubcluster: subCluster ] ] ].
	self
		writeObjectToDisk: project
		filename: repository asFileReference / destinationMetadata