instance creation
fromFile: filePath
	filePath asFileReference
		readStreamDo: [ :fileStream | 
			| stream |
			stream := ZnBufferedReadStream on: fileStream.	"wrap with buffered stream to bypass https://github.com/GemTalk/FileSystemGs/issues/9"
			^ STON fromStream: stream ]