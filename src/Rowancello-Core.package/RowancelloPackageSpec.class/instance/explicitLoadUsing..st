loading
explicitLoadUsing: mcLoader
	"fetch and explicitly load/read the BaselineOf using Rowan"
	| sysUser filetreeReaderClass projectName packageName rowanProject directory baselineClassDir |
	projectName := self name.
	sysUser := AllUsers detect: [:x | x userId = 'SystemUser'] .
	filetreeReaderClass := (sysUser resolveSymbol: #'RwRepositoryResolvedProjectFiletreeReaderVisitorV2') value.

	packageName := projectName.

	directory := ((self repositories list first name), '/', packageName , '.package') asFileReference.
	baselineClassDir := directory childNames detect: [:childName | (childName asFileReference extension = 'class') ].	"expect only one"
		
	rowanProject := filetreeReaderClass
		readClassDirectories: { directory / baselineClassDir } 
		projectName: projectName
		 packageName: packageName.
	rowanProject gemstoneSetDefaultSymbolDictNameTo: 'Smalltalk'.
	rowanProject load.