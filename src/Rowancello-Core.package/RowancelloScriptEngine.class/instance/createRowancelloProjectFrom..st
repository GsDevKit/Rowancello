rowan project creation
createRowancelloProjectFrom: aVersionSpec
	"Write the Rowancello slices to dosk"

	| ar dict metadataDict projectName subClusters cluster slice packagesMap groupNames |
	ar := self createMetadataForRowanProjectFrom: aVersionSpec.
	dict := ar at: 1.
	projectName := ar at: 2.
	packagesMap := Dictionary new.
	groupNames := Dictionary new.
	metadataDict := dict at: projectName.
	subClusters := Dictionary new.
	cluster := RowancelloCluster new
		name: 'CoreCluster';
		subClusters: subClusters;
		yourself.
	slice := RowancelloSlice new
		name: projectName;
		clusters: {cluster};
		yourself.
	groupNames := (metadataDict at: 'Groups' ifAbsent: [ Dictionary new ]) keys.
	(metadataDict at: 'Groups' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :groupName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :packagesDict | 
					| subCluster packages packageProperties groupProperties |
					(self convertForConditions: conditionArray)
						ifTrue: [ 
							packages := (packagesDict at: 'includes' ifAbsent: [ {} ]) copy.
							packages addAll: (packagesDict at: 'requires' ifAbsent: [ {} ]).
							packageProperties := {}.
							groupProperties := {}.
							packages
								do: [ :packageName | 
									| thePackageProperty |
									thePackageProperty := packagesMap
										at: packageName
										ifAbsentPut: [ 
											(groupNames includes: packageName)
												ifTrue: [ 
													thePackageProperty := RowancelloGroupProperties new
														name: packageName;
														yourself .
													groupProperties add: thePackageProperty]
												ifFalse: [ 
													thePackageProperty := RowancelloPackageProperties new
														name: packageName;
														yourself .
													packageProperties add: thePackageProperty ] ].
									subCluster := RowancelloSubcluster new
										name: groupName;
										condition: (self createConditionExpressionFrom: conditionArray);
										groups: groupProperties;
										packages: packageProperties;
										yourself ].
							subClusters at: groupName put: subCluster ] ] ].
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
							subCluster := RowancelloSubcluster new
								name: theProjectName;
								condition: (self createConditionExpressionFrom: conditionArray);
								projects: (projectDict at: 'repositories' ifAbsent: [ {} ]);
								comment:
										'The list of "projects" is a list of repository URLs for the project';
								yourself.
							subClusters at: theProjectName put: subCluster ] ] ].
	^ {slice.
	(projectName , '_rowan')}