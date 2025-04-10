querying
registrationForProjectSpec: aProjectSpec ifAbsent: absentBlock ifPresent: presentBlock
	"the target of the current work is to extract meta data from the baseline ... so creating a new instance is kosher"

	^ aProjectSpec asProjectRegistration