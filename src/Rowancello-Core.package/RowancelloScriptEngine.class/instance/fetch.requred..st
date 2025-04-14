actions api
fetchRecord: fetchRecordBlock required: required
          | version loadedSpec |
          self setDefaultsAndValidateProjectSpec.
          loadedSpec := self lookupProjectSpecFor: self projectSpec.
          version := loadedSpec versionForScriptEngine: self.
          self root: (fetchRecordBlock value: version) loadDirective
