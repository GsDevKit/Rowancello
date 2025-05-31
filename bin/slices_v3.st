| slices |
slices := {
	RowancelloPackageSlice new
		name: 'Simple-Slice';
		packages: {
			'Project-Core' .
			'Project-Public-Core'  .
			'Project-Utility'
		};
		comment: 'No frills slice. No clusters involved, no conditions, and no properties';
		yourself.
	RowancelloSlice new
		name: 'Production-Slice';
		clusters: {
			RowancelloCluster new
				name: 'CoreCluster';
				subClusters: {
					RowancelloSubcluster new
						name: 'Core';
						condition: 'common';
						packages: {
							'Project-Core'.
							'Project-Public-Core'
							} ;
						addPackagePropertyFor: 'Project-Core' 
							at: 'gemstoneSymbolDictName' 
							put: 'ProjectGlobals';
						addPackagePropertyFor: 'Project-Public-Core' 
							at: 'gemstoneSymbolDictName' 
							put: 'Globals';
						yourself.
					RowancelloSubcluster new
						name: 'Tests';
						condition: 'tests';
						packages: {
							'Projects-Core-Tests'
							}; 
						yourself .
					}.
				};
		comment: 'Production slice . Tests conditionally loaded (tests attribute). Custom package property: gemstoneSymbolDictName, used by GemStone';
		yourself.
	RowancelloSlice new
		name: 'Utility-Slice';
		clusters: {
			RowancelloCluster new
				name: 'CoreCluster';
				subClusters: {
					RowancelloSubcluster new
						name: 'Core';
						condition: 'common';
						packages: {
							'Project-Utility'
						} ;
					yourself.
					RowancelloSubcluster new
						name: 'Tests';
						condition: 'tests';
						packages: {
							'Projects-Utility-Tests' .
							}; 
						yourself .
				}.
			};
		comment: 'Utility slice ... code that can be used by other projects independent of Core functionality';
		yourself.}.
'/bosch1/users/dhenrich/_stones/git/Rowancello/generated/slices_v3.ston'  asFileReference
	writeStreamDo: [ :stream |
		| writer |
		stream truncate.
		writer := STON writer
			referencePolicy: #'ignore';
			yourself.
		(writer on: stream)
			prettyPrint: true;
			nextPut: slices	"STON put: slices onStreamPretty: stream"  ]
