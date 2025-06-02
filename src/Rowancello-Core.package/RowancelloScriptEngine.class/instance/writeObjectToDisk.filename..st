rowan project creation
writeObjectToDisk: anObject filename: filename
	('/bosch1/users/dhenrich/_stones/git/Rowancello/generated/' , filename
		, '.ston') asFileReference
		writeStreamDo: [ :stream | 
			| writer |
			stream truncate.
			writer := STON writer
				referencePolicy: #'ignore';
				yourself.
			(writer on: stream)
				prettyPrint: true;
				nextPut: anObject ]