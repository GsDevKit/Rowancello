rowan project creation
createRowanProjectFrom: aVersionSpec
	" 
	OVERVIEW:
		| stream |
		stream := String new writeStreamPortable.
		aVersionSpec printOn: stream.
		(stream contents replaceAll: Character cr with: Character lf) halt
	"

	| ar |
	ar := self createMetadataForRowanProjectFrom: aVersionSpec.
	self writeObjectToDisk: (ar at: 1) filename: (ar at: 2)