rowan project creation
createRowancelloProjectFrom: aVersionSpec
	"Write the Rowancello slices to disk"

	| ar dict metadataDict projectName cluster slice packagesMap subclusterNames project |
	ar := self createMetadataForRowanProjectFrom: aVersionSpec.
	dict := ar at: 1.
	projectName := ar at: 2.
	packagesMap := Dictionary new.
	metadataDict := dict at: projectName.
	project := RowancelloProject new
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
							| subCluster packages includes requires referenced condition |
							condition := self createConditionExpressionFrom: conditionArray.
							subCluster := project
								subclusterNamed: subclusterName
								ifAbsent: [ 
									project
										addSubcluster: (
											RowancelloSubcluster new
												name: subclusterName;
												yourself ) ].
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
													subCluster addSubcluster: thePackageProperty condition: condition.
													project addSubcluster: thePackageProperty.
													referenced remove: packageName ifAbsent: [  ] ]
												ifFalse: [ 
													thePackageProperty := RowancelloPackageProperties new
														name: packageName;
														yourself.
													subCluster addPackage: thePackageProperty condition: condition.
													project addPackage: thePackageProperty.
													referenced remove: packageName ifAbsent: [  ] ] ] ].
							referenced isEmpty
								ifFalse: [ referenced do: [ :unrefName | subCluster addSubclusterNamed: unrefName ] ].
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
	^ {project.
	(projectName , '_rowan')}