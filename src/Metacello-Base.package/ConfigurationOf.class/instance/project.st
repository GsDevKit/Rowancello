accessing
project
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := self projectClass new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            project versionNumberClass: self versionNumberClass.
false ifTrue: [ 
	  "I don't think this is useful ... but in case I need it, I'll leave a reference"
            project class versionConstructorClass on: self project: project.	"Construct the project"
	].
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]