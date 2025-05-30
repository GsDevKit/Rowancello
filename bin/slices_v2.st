| slices corePackage testCorePackage utilityPackage testUtilityPackage coreCluster 
	utilityCluster productionSlice utilitySlice coreSubCluster conditionalPackageMap |
corePackage := Dictionary new 
	at: 'class' put: 'PACKAGE';
	at: 'name' put: 'Project-Core';
	at: 'condition' put: 'common';
	yourself.

testCorePackage := Dictionary new
	at: 'class' put: 'PACKAGE';
	at: 'name' put: 'Project-Core-Tests';
	at: 'condition' put: 'tests';
	yourself .

utilityPackage := Dictionary new
	at: 'class' put: 'PACKAGE';
	at: 'name' put: 'Project-Utility';
	at: 'condition' put: 'common';
	yourself.
testUtilityPackage := Dictionary new 
	at: 'class' put: 'PACKAGE';
	at: 'name' put: 'Project-Utility-Tests';
	at: 'condition' put: 'tests';
	yourself.
conditionalPackageMap := Dictionary new.
	at: 'class' put: 'SUBCLUSTER';
	at:  'condition' put: 'gemstone';
	at: 'name' put: 'CoreSubCluster';
	at: 'packagess' put: { corePackage . testCorePackage  };
	at: 'projectNamess' put: { 'ExternalProject'  };

coreSubCluster := Dictionary new	yourself.

coreCluster := Dictionary new
	at: 'class' put: 'CLUSTER';
	at: 'name' put: 'CoreCluster';
	at: 'subclusters' put: { coreSubCluster  };
	yourself.

utilityCluster := Dictionary new
	at: 'class' put: 'CLUSTER';
	at:  'condition' put: 'common';
	at: 'name' put: 'UtilityCluster';
	at: 'packages' put: { utilityPackage . testUtilityPackage  };
	yourself.

productionSlice := Dictionary new
	at: 'class' put: 'SLICE';
	at: 'name' put: 'Production Slice';
	at: 'clusters' put: {coreCluster .  utilityCluster};
	yourself.
utilitySlice := Dictionary new
	at: 'class' put: 'SLICE';
	at: 'name' put: 'Utility Slice';
	at: 'clusters' put: {utilityCluster };
	yourself.
slices := Dictionary new
	at: 'name' put: 'Slices';
	at: 'Production Slice' put: productionSlice;
	at: 'Utility Slice' put: utilitySlice;
	yourself.
'/bosch1/users/dhenrich/_stones/git/Rowancello/generated/slices_v1.ston'  asFileReference
	writeStreamDo: [ :stream |
		| writer |
		stream truncate.
		writer := STON writer
			referencePolicy: #'ignore';
			yourself.
		(writer on: stream)
			prettyPrint: true;
			nextPut: slices	"STON put: slices onStreamPretty: stream"  ]
