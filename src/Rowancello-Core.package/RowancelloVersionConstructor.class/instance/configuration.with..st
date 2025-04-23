api
configuration: aString with: aBlockOrString
	true
		ifTrue: [ 
			GsFile
				gciLogServer:
					'RowancelloVersionConstructor>>configuration:with: skipping '
						, aString , ' for now'.
			^ self ].
    self root configuration: aString with: aBlockOrString constructor: self