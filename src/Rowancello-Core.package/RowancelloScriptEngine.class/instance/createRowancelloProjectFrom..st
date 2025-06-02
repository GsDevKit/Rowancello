rowan project creation
createRowancelloProjectFrom: aVersionSpec
	"Write the Rowancello slices to dosk"

	| ar dict metadataDict projectName subClusters cluster |
	ar := self createMetadataForRowanProjectFrom: aVersionSpec.
	dict := ar at: 1.
	projectName := ar at: 2.
	metadataDict := dict at: projectName.
	subClusters := Dictionary new.
	cluster := RowancelloCluster new
		name: 'CoreCluster';
		subClusters: subClusters;
		yourself.
	(metadataDict at: 'Groups')
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
						comment: 'The list of "packages" includes both package names and subCluster names (groups)'; 
						yourself.
					subClusters at: groupName put: subCluster ] ].
	^ {cluster.
	(projectName , '_cluster')}