api spec callbacks
configurationForVersion: aString with: aBlock
	true
		ifTrue: [ 
			GsFile
				gciLogServer:
					'RowancelloVersionConstructor>>configurationForVersion:with: skipping '
						, aString , ' for now'.
			^ self ].
	aBlock setConfiguration: aString withInMetacelloConfig: self