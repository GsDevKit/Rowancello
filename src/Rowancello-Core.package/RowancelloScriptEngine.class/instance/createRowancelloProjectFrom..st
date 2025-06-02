rowan project creation
createRowancelloProjectFrom: aVersionSpec
	"Write the Rowancello slices to dosk"

	| ar dict metadataDict projectName subClusters cluster slice packagesMap |
	ar := self createMetadataForRowanProjectFrom: aVersionSpec.
	dict := ar at: 1.
	projectName := ar at: 2.
	packagesMap := Dictionary new.
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
	(metadataDict at: 'Groups' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :groupName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :packagesDict | 
					| subCluster packages packageProperties |
					packages := (packagesDict at: 'includes' ifAbsent: [ {} ]) copy.
					packages addAll: (packagesDict at: 'requires' ifAbsent: [ {} ]).
					packageProperties := {}.
					packages
						do: [ :packageName | 
							| thePackageProperty |
							thePackageProperty := packagesMap
								at: packageName
								ifAbsentPut: [ 
									RowancelloPackageProperties new
										name: packageName;
										yourself ].
							packageProperties add: thePackageProperty ].
					subCluster := RowancelloSubcluster new
						name: groupName;
						condition: conditionArray;
						packages: packageProperties;
						comment:
								'The list of "packages" may  both package names and subCluster names (groups)';
						yourself.
					subClusters at: groupName put: subCluster ] ].
	(metadataDict at: 'Packages' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :thePackageName :conDict | 
			conDict
				keysAndValuesDo: [ :conditionArray :packageDict | 
					| packageProperties |
					packagesMap
						at: thePackageName
						ifPresent: [ :val | val condition ifNotNil: [ System waitForDebug ] ].
					packageProperties := (packagesMap
						at: thePackageName
						ifAbsentPut: [ 
							RowancelloPackageProperties new
								name: thePackageName;
								youself ])
						condition: conditionArray;
						comment:
								'additional package properties that need to be used to supplement the "includes" and "required" packages';
						yourself.
					packageDict
						at: 'file'
						ifPresent: [ :fileProperty | packageProperties properties at: 'file' put: fileProperty ] ] ].
	(metadataDict at: 'ProjectReferences' ifAbsent: [ Dictionary new ])
		keysAndValuesDo: [ :theProjectName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :projectDict | 
					| subCluster |
					subCluster := RowancelloSubcluster new
						name: theProjectName;
						condition: conditionArray;
						projects: (projectDict at: 'repositories' ifAbsent: [ {} ]);
						comment:
								'The list of "projects" is a list of repository URLs for the project';
						yourself.
					subClusters at: theProjectName put: subCluster ] ].
	^ {slice.
	(projectName , '_rowan')}