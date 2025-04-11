actions api
analyze: required
	MetacelloProjectRegistration
		copyRegistryRestoreOnErrorWhile: [ 
			self
				handleNotificationsForAction: [ 
					| version loadedSpec |
					self setDefaultsAndValidateProjectSpec.
					[ loadedSpec := (self lookupProjectSpecFor: self projectSpec) copy ]
						on: Notification
						do: [ :ex | self halt ].
					version := loadedSpec versionForScriptEngine: self.
					self
						root:
							(required isEmpty
								ifTrue: [ version load ]
								ifFalse: [ version load: required ]) loadDirective.
					loadedSpec loads: required.
					self halt ] ]