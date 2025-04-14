	| sysUser filetreeReaderClass projectName packageName rowanProject directory baselineClassDir |

	projectName := 'GLASS1'.
	sysUser := AllUsers detect: [:x | x userId = 'SystemUser'] .
	filetreeReaderClass := (sysUser resolveSymbol: #'RwRepositoryResolvedProjectFiletreeReaderVisitorV2') value.

	packageName := 'BaselineOf', projectName.

	directory := ('/bosch1/users/dhenrich/_stones/git/glass/repository/', packageName , '.package') asFileReference.
	baselineClassDir := directory childNames detect: [:childName | (childName asFileReference extension = 'class') ].	"expect only one"
		
	rowanProject := filetreeReaderClass
		readClassDirectories: { directory / baselineClassDir } 
		projectName: projectName
		 packageName: packageName.
