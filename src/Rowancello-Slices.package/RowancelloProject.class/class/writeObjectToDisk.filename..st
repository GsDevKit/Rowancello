writing
writeObjectToDisk: anObject filename: filepath
	(filepath asFileReference , 'ston')
		writeStreamDo: [ :stream | 
			| writer |
			stream truncate.
			writer := STON writer
				referencePolicy: #'ignore';
				yourself.
			(writer on: stream)
				prettyPrint: true;
				nextPut: anObject ]