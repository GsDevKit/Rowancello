api spec callbacks
repositoryForVersion: anObject
GsFile gciLogServer: 'this is the spot where (', anObject class name, ') needs to use the receiver (baseline constructor) to add the currentAttricuteList to the repository object ... Collection, String, ...'.
false ifTrue: [ self halt: self class name, ' repositoryForVersion  ']. 
self commonVersionSpec repositories repository: anObject constructor: self