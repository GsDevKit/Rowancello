private
doLoadRequiredFromArray: anArray

	| displayString oldPolicy |
	displayString := self versionNumber printString, ' of ', self spec projectLabel.
	Transcript cr; show: 'Loading ', displayString, '...'.
	oldPolicy := loaderPolicy. 
	[	| fetchLoader |
		fetchLoader := self fetchRequiredFromArray: (self defaultPackageNamesToLoad: anArray).
		MetacelloPlatform current
			do:  [  fetchLoader doLoad ]
			displaying: 'Loading ', displayString.
		Transcript cr; show: '...finished ', self versionNumber printString.
		^fetchLoader ]
		ensure: [ loaderPolicy := oldPolicy ]
