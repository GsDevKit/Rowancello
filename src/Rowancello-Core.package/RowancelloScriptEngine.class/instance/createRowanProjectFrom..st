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
	self halt: 'createRowanProjectFrom:'.
	aVersionSpec packages list
		do: [ :package | 
			| project configuration packagesDict packageDict detailsDict theSpec requires answers includes file goferPackage preLoadDoIt postLoadDoIt categoryDict repositories |
			project := package project.
			configuration := project configuration.
			projectName := project label.
			categoryDict := dict at: projectName ifAbsentPut: [ Dictionary new ].
			theSpec := package spec.
			packagesDict := categoryDict
				at: theSpec rowancelloCategory
				ifAbsentPut: [ Dictionary new ].
			packageDict := packagesDict at: package name ifAbsentPut: [ Dictionary new ].
			detailsDict := packageDict
				at: theSpec currentAttributeList
				ifAbsentPut: [ Dictionary new ].
			(theSpec respondsTo: #projectReference)
				ifTrue: [ 
					theSpec projectReference loads
						ifNotNil: [ :val | detailsDict at: 'loads' put: val ].
					theSpec projectReference versionString
						ifNotNil: [ :versionString | detailsDict at: 'versionString' put: versionString ] ].
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
			repositories
				ifNotNil: [ :repositoriesSpec | 
					"THIS IS NOT THE RIGHT SPOT ... KEEPING IT AROUND FOR FUN"
					| val |
					val := repositoriesSpec
						map;
						list.
					val isEmpty
						ifTrue: [  ]
						ifFalse: [ detailsDict halt at: 'repositories' put: (val collect: [ :each | each name ]) asArray ] ].
			goferPackage := theSpec goferPackage.
			goferPackage
				ifNotNil: [ :val | 
					val class = Association
						ifTrue: [ 
							"goferPackage is only interesting if key and value are NOT the same"
							val key = val value
								ifFalse: [ detailsDict at: 'goferPackage' put: val ] ]
						ifFalse: [ detailsDict at: 'goferPackage' put: val ] ].
			preLoadDoIt := theSpec preLoadDoIt.
			preLoadDoIt
				ifNotNil: [ :valueHolder | detailsDict at: 'preLoadDoIt' put: valueHolder value ].
			postLoadDoIt := theSpec postLoadDoIt.
			postLoadDoIt
				ifNotNil: [ :valueHolder | detailsDict at: 'postLoadDoIt' put: valueHolder value ] ].
	aVersionSpec repositories map. "fails during lookup ... no addMembers present"
	aVersionSpec repositories list
		do: [ :repository | 
			| project configuration repositoriesDict repositoryDict detailsDict theSpec categoryDict |
			project := repository project.
			configuration := project configuration.
			projectName := project label.
			categoryDict := dict at: projectName ifAbsentPut: [ Dictionary new ].
			theSpec := repository spec.
			repositoriesDict := categoryDict
				at: theSpec rowancelloCategory
				ifAbsentPut: [ Dictionary new ].
			repositoryDict := repositoriesDict
				at: repository name
				ifAbsentPut: [ Dictionary new ].
			theSpec name = '/bosch1/users/dhenrich/_stones/git/Rowancello/src'
				ifFalse: [ 
					detailsDict := repositoryDict
						at: theSpec currentAttributeList
						ifAbsentPut: [ Dictionary new ].
					(detailsDict at: 'repositories' ifAbsentPut: [ OrderedCollection new ])
						add: theSpec name ]].

	('/bosch1/users/dhenrich/_stones/git/Rowancello/generated/' , projectName
		, '.ston') asFileReference
		writeStreamDo: [ :stream | 
			| writer |
			stream truncate.
			writer := STON writer
				referencePolicy: #'ignore';
				yourself.
			(writer on: stream)
				prettyPrint: true;
				nextPut: dict	"STON put: dict onStreamPretty: stream" ]