rowan project creation
createRowanProjectFrom: aVersionSpec
	" 
	OVERVIEW:
		| stream |
		stream := String new writeStreamPortable.
		aVersionSpec printOn: stream.
		(stream contents replaceAll: Character cr with: Character lf) halt
	"

	| dict |
	dict := Dictionary new.
	aVersionSpec packages list
		do: [ :package | 
			| project configuration projectName packageDict detailsDict packageSpec requires answers includes file repositories goferPackage preLoadDoIt postLoadDoIt |
			project := package project.
			configuration := project configuration.
			projectName := project label.
			packageDict := dict at: projectName ifAbsentPut: [ Dictionary new ].
			detailsDict := packageDict at: package name ifAbsentPut: [ Dictionary new ].
			packageSpec := package spec.
			detailsDict at: 'attributes' put: packageSpec currentAttributeList.
			requires := packageSpec requires.
			requires
				ifNotNil: [ :ar | 
					ar isEmpty
						ifFalse: [ detailsDict at: 'requires' put: ar ] ].
			includes := packageSpec includes.
			includes
				ifNotNil: [ :ar | 
					ar isEmpty
						ifFalse: [ detailsDict at: 'includes' put: ar ] ].
			answers := packageSpec answers.
			answers
				ifNotNil: [ :ar | 
					ar isEmpty
						ifFalse: [ detailsDict at: 'answers' put: ar ] ].
			file := packageSpec file.
			file ifNotNil: [ :val | detailsDict at: 'file' put: val ].
			repositories := packageSpec repositories.
			repositories ifNotNil: [ :val | detailsDict at: 'repositories' put: val ].
			goferPackage := packageSpec goferPackage.
			goferPackage ifNotNil: [ :val | detailsDict at: 'goferPackage' put: val ].
			preLoadDoIt := packageSpec preLoadDoIt.
			preLoadDoIt ifNotNil: [ :val | detailsDict at: 'preLoadDoIt' put: val ].
			postLoadDoIt := packageSpec postLoadDoIt.
			postLoadDoIt ifNotNil: [ :val | detailsDict at: 'postLoadDoIt' put: val ] ].
	dict halt