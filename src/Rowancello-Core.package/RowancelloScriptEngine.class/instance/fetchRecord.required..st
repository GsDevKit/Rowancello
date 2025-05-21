actions api
fetchRecord: fetchRecordBlock required: required
           | version loadedSpec theRoot |
          self setDefaultsAndValidateProjectSpec.
          loadedSpec := self lookupProjectSpecFor: self projectSpec. 
          version := loadedSpec versionForScriptEngine: self.
          self root: (theRoot := fetchRecordBlock value: version).
	self commonVersionSpec: theRoot