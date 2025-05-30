| slices |
slices := {
	RowancelloPackageSlice new
		name: 'Simple-Slice';
		packages: {
			'Project-Core'.
			'Project-Utility'
		};
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
							'Project-Core'
							} ;
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
