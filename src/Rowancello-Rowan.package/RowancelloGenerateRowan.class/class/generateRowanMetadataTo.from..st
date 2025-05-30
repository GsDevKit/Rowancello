generating
generateRowanMetadataTo: aStringOrFileRef from: baselineStonFilePath
	^ self new
		baselineMetadata:
				(STON fromStream: baselineStonFilePath asFileReference readStream contents);
		projectDir: aStringOrFileRef;
		generate;
		yourself