	| sysUser filetreeReaderClass projectName packageName rowanProject directory baselineClassDir |

	projectName := 'GLASS1'.	packageName := 'BaselineOf', projectName.	directory := ('$ROWAN_PROJECTS_HOME/glass/repository/', packageName , '.package') asFileReference.	projectName := 'Metacello'.	packageName := 'BaselineOf', projectName.	directory := ('/bosch1/users/dhenrich/_stones/git/metacello-work/repository/', packageName , '.package') asFileReference.	sysUser := AllUsers detect: [:x | x userId = 'SystemUser'] .
	filetreeReaderClass := (sysUser resolveSymbol: #'RwRepositoryResolvedProjectFiletreeReaderVisitorV2') value.


	baselineClassDir := directory childNames detect: [:childName | (childName asFileReference extension = 'class') ].	"expect only one"
		
	rowanProject := filetreeReaderClass
		readClassDirectories: { directory / baselineClassDir } 
		projectName: projectName
		 packageName: packageName.
	rowanProject gemstoneSetDefaultSymbolDictNameTo: 'Smalltalk'.
	rowanProject load.

