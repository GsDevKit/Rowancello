loading
explicitLoadUsing: mcLoader
	"fetch and explicitly load/read the BaselineOf using Rowan"

	| sysUser projectName packageName rowanProject directory baselineClassDir |
	projectName := self name.
	sysUser := AllUsers detect: [ :x | x userId = 'SystemUser' ].

	packageName := projectName.

	packageName = 'BaselineOfMagritte'
		ifTrue: [ 
			| classReaderClass classFile repoDir |
			classReaderClass := (sysUser
				resolveSymbol: #'RwRepositoryResolvedProjectTonelReaderVisitorV2') value.
			repoDir := self repositories list first name asFileReference.
			classFile := repoDir parent / 'tonel' / packageName / packageName
				, 'class.st'.
			rowanProject := classReaderClass readClassFile: classFile ]
		ifFalse: [ 
			| packageReaderClass |
			packageReaderClass := (sysUser
				resolveSymbol: #'RwRepositoryResolvedProjectFiletreeReaderVisitorV2') value.
			directory := (self repositories list first name , '/' , packageName
				, '.package') asFileReference.
			baselineClassDir := directory childNames
				detect: [ :childName | childName asFileReference extension = 'class' ].	"expect only one"

			rowanProject := packageReaderClass
				readClassDirectories: {(directory / baselineClassDir)}
				projectName: projectName
				packageName: packageName ].
	rowanProject gemstoneSetDefaultSymbolDictNameTo: 'Smalltalk'.
	rowanProject load