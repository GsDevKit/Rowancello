rowan project creation
createMetadataForRowanProjectFrom: aVersionSpec
	| dict projectName repositoriesList repositoriesMap |
	dict := Dictionary new.
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
			(theSpec respondsTo: #'projectReference')
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
					| val "THIS IS NOT THE RIGHT SPOT ... KEEPING IT AROUND FOR FUN" |
					val := repositoriesSpec
						map;
						list.
					val isEmpty
						ifTrue: [  ]
						ifFalse: [ detailsDict at: 'repositories' put: (val collect: [ :each | each name ]) asArray ] ].
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
				ifNotNil: [ :valueHolder | detailsDict at: 'postLoadDoIt' put: valueHolder value ] ].	"
	extract  the projects from the package list, and add them to the repositories list (in front of existing entries) so that the projects are available for copying"
	repositoriesList := aVersionSpec repositories list.
	aVersionSpec packages list
		reverseDo: [ :memberSpec | 
			memberSpec spec class name = #'RowancelloProjectReferenceSpec'
				ifTrue: [ 
					GsFile gciLogServer: memberSpec spec name , ' ' , memberSpec class name.
					repositoriesList addFirst: memberSpec ] ].
	repositoriesMap := aVersionSpec repositories map.
	repositoriesMap
		keysAndValuesDo: [ :projectSpecName :theSpec | 
			| repositoriesDict repositoryDict detailsDict descriptions categoryDict |
			categoryDict := dict at: projectName ifAbsentPut: [ Dictionary new ].
			repositoriesDict := categoryDict
				at: theSpec rowancelloCategory
				ifAbsentPut: [ Dictionary new ].
			repositoryDict := repositoriesDict
				at: projectSpecName
				ifAbsentPut: [ Dictionary new ].
			detailsDict := repositoryDict
				at: theSpec currentAttributeList
				ifAbsentPut: [ Dictionary new ].
			descriptions := theSpec repositories list
				collect: [ :memberSpec | memberSpec spec description ].
			(detailsDict at: 'repositories' ifAbsentPut: [ Array new ])
				addAll: descriptions ].
	^ {dict . projectName}