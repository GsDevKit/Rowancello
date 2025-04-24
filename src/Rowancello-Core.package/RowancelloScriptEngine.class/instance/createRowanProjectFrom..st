rowan project creation
createRowanProjectFrom: aVersionSpec
	" 
	OVERVIEW:
		| stream |
		stream := String new writeStreamPortable.
		aVersionSpec printOn: stream.
		(stream contents replaceAll: Character cr with: Character lf) halt
	"

	| dict projectName |
	dict := Dictionary new.
	aVersionSpec packages list
		do: [ :package | 
			| project configuration packageDict detailsDict theSpec requires answers includes file repositories goferPackage preLoadDoIt postLoadDoIt categoryDict |
			project := package project.
			configuration := project configuration.
			projectName := project label.
			categoryDict := dict at: projectName ifAbsentPut: [ Dictionary new ].	
			theSpec := package spec.
			packageDict := categoryDict at: theSpec  rowancelloCategory ifAbsentPut: [ Dictionary new ].
			detailsDict := packageDict at: package name ifAbsentPut: [ Dictionary new ].
false ifTrue: [ (detailsDict isEmpty not and: [theSpec  rowancelloCategory = 'Package']) ifTrue: [ package name halt ] ].
			detailsDict at: 'attributes' put: theSpec currentAttributeList.
			requires := theSpec requires.
			requires
				ifNotNil: [ :ar | 
					ar isEmpty
						ifFalse: [ detailsDict at: 'requires' put: ar ] ].
			includes := theSpec includes.
			includes
				ifNotNil: [ :ar | 
					ar isEmpty
						ifFalse: [ detailsDict at: 'includes' put: ar ] ].
			answers := theSpec answers.
			answers
				ifNotNil: [ :ar | 
					ar isEmpty
						ifFalse: [ detailsDict at: 'answers' put: ar ] ].
			file := theSpec file.
			file ifNotNil: [ :val | detailsDict at: 'file' put: val ].
			repositories := theSpec repositories.
			repositories
				ifNotNil: [ :repositoriesSpec | 
					| val |
					val := repositoriesSpec list.
					val isEmpty
						ifFalse: [ detailsDict at: 'repositories' put: (val collect: [:each | each name ]) ] ].
			goferPackage := theSpec goferPackage.
			goferPackage
				ifNotNil: [ :val | detailsDict at: 'goferPackage' put: val ].
			preLoadDoIt := theSpec preLoadDoIt.
			preLoadDoIt ifNotNil: [ :valueHolder | detailsDict at: 'preLoadDoIt' put: valueHolder value  ].
			postLoadDoIt := theSpec postLoadDoIt.
			postLoadDoIt
				ifNotNil: [ :valueHolder | detailsDict at: 'postLoadDoIt' put: valueHolder value  ] ].
	('/bosch1/users/dhenrich/_stones/git/Rowancello/generated/' , projectName
		, '.ston') asFileReference
		writeStreamDo: [ :stream | 
			stream truncate.
			STON put: dict onStreamPretty: stream ]