rowan project creation
createRowancelloProjectFrom: aVersionSpec
	"Write the Rowancello slices to dosk"

	| ar dict metadataDict projectName subClusters cluster slice |
	ar := self createMetadataForRowanProjectFrom: aVersionSpec.
	dict := ar at: 1.
	projectName := ar at: 2.
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
	(metadataDict at: 'Groups' ifAbsent: [Dictionary new])
		keysAndValuesDo: [ :groupName :condDict | 
			condDict
				keysAndValuesDo: [ :conditionArray :packagesDict | 
					| subCluster packages |
					packages := (packagesDict at: 'includes' ifAbsent: [ {} ]) copy.
					packages addAll: (packagesDict at: 'requires' ifAbsent: [ {} ]).
					subCluster := RowancelloSubcluster new
						name: groupName;
						condition: conditionArray;
						packages: packages;
						comment:
								'The list of "packages" includes both package names and subCluster names (groups)';
						yourself.
					subClusters at: groupName put: subCluster ] ].
	(metadataDict at: 'ProjectReferences' ifAbsent: [Dictionary new])
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