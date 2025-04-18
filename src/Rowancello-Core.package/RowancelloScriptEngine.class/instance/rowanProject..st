actions api
rowanProject: required
	self
		fetchRecord: [ :version | 
			"create and return a project based on the `version spec` information"
			^ self createRowanProjectFrom: version spec ]
		required: required