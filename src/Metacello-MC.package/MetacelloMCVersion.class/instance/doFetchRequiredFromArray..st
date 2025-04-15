private
doFetchRequiredFromArray: anArray

	| oldPolicy displayString |
	displayString := self versionNumber printString, ' of ', self spec projectLabel.
	Transcript cr; show: 'Fetching ', displayString, '...'.
	oldPolicy := loaderPolicy. 
	[ 	| ans |
		ans := self fetchRequiredFromArray: anArray.
		Transcript cr; show: '...finished ', self versionNumber printString.
		^ans ]
			ensure: [ loaderPolicy := oldPolicy ]
