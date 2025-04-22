rowan project creation
createRowanProjectFrom: aVersionSpec
	"validation for now"

	| stream |
	stream := String new writeStreamPortable.
	aVersionSpec printOn: stream.
	(stream contents replaceAll: Character cr with: Character lf) halt