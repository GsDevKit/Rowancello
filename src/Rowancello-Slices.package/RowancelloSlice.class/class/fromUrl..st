instance creation
fromUrl: specNameOrUrl
	"self fromUrl: 'file:/bosch1/users/dhenrich/_stones/git/Rowancello/generated/BaselineOfZodiac_rowan.ston'"

	| url |
	url := specNameOrUrl asRwUrl.
	url scheme isNil
		ifTrue: [ self error: 'scheme must be file: or https:' ].
	url scheme = 'file'
		ifTrue: [ ^ self fromFile: url pathForFile ].
	url scheme asString = 'https'
		ifTrue: [ 
			| downoadedFile cmd curlErrorFile |
			cmd := '/usr/bin/curl -L ' , url printString.
			downoadedFile := FileReference newTempFilePrefix: 'LoadSpec' suffix: '.ston'.
			curlErrorFile := FileReference newTempFilePrefix: 'CurlError' suffix: '.err'.
			[ 
			GsHostProcess new
				commandLine: cmd;
				stderrPath: curlErrorFile pathString;
				stdoutPath: downoadedFile pathString;
				executeWithInput: nil ]
				on: ChildError
				do: [ :ex | 
					self
						error:
							'error downloading url ' , url printString , ' see ' , curlErrorFile pathString
								, ' for details' ].
			[ 
			[ ^ self fromFile: downoadedFile pathString ]
				on: Error
				do: [ :ex | 
					self
						error:
							'error creating load spec' , url printString , ' see '
								, downoadedFile pathString , ' for details' ] ]
				ensure: [ 
					curlErrorFile ensureDelete.
					downoadedFile ensureDelete ] ].
	self error: 'Unknown scheme: ' , url scheme printString