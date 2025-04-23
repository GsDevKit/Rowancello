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
			| project configuration packageDict detailsDict packageSpec requires answers includes file repositories goferPackage preLoadDoIt postLoadDoIt categoryDict |
			project := package project.
			configuration := project configuration.
			projectName := project label.
			categoryDict := dict at: projectName ifAbsentPut: [ Dictionary new ].
			
			packageSpec := package spec.
			packageDict := categoryDict at: packageSpec  rowancelloCategory ifAbsentPut: [ Dictionary new ].
			detailsDict := packageDict at: package name ifAbsentPut: [ Dictionary new ].
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
			repositories
				ifNotNil: [ :repositoriesSpec | 
					| val |
					val := repositoriesSpec list.
					val isEmpty
						ifFalse: [ detailsDict at: 'repositories' put: val ] ].
			goferPackage := packageSpec goferPackage.
			goferPackage
				ifNotNil: [ :val | detailsDict at: 'goferPackage' put: val ].
			preLoadDoIt := packageSpec preLoadDoIt.
			preLoadDoIt ifNotNil: [ :valueHolder | detailsDict at: 'preLoadDoIt' put: valueHolder value  ].
			postLoadDoIt := packageSpec postLoadDoIt.
			postLoadDoIt
				ifNotNil: [ :valueHolder | detailsDict at: 'postLoadDoIt' put: valueHolder value  ] ].
	('/bosch1/users/dhenrich/_stones/git/Rowancello/generated/' , projectName
		, '.ston') asFileReference
		writeStreamDo: [ :stream | 
			| writer |
			stream truncate.
			writer := STONWriter new
				"referencePolicy: #ignore;"
				 on: stream;
				prettyPrint: true; 
				nextPut: dict;
				yourself.
			(writer instVarAt: 7) halt]