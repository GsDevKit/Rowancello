actions api
record: required
    self
        fetchRecord: [ :version | 
          "the job is done ... no need to go any further in terms of the standard procedure"
	"this would be the spot where we should be generating the Rowan meta data for the project ... fullAttributeList needs to be preserved to provide the full conditional picture ..." 
	(version spec dynamicInstVarAt: #fullAttributeList) ]
        required: required