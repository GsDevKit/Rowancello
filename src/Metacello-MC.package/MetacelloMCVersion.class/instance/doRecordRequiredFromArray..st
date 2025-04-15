private
doRecordRequiredFromArray: anArray

	| originalLoader oldPolicy displayString |
	displayString := self versionNumber printString, ' of ', self spec projectLabel.
	Transcript cr; show: 'Recording ', displayString, '...'.
	originalLoader := self versionSpec loader.
	oldPolicy := loaderPolicy. 
	[	MetacelloPlatform current
			do:  [ | ans |
				self versionSpec loader: originalLoader recordingSpecLoader.
				ans := (self executeLoadFromArray: anArray) copy.
				Transcript cr; show: '...finished ', self versionNumber printString.
				^ans ]
			displaying: 'Recording ', displayString ]
				ensure: [
					self versionSpec loader: originalLoader.
					loaderPolicy := oldPolicy ]
