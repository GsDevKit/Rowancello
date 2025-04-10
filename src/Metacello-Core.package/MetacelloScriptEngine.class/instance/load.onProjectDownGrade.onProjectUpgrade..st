actions api
load: required onProjectDownGrade: onDownGradeBlock onProjectUpgrade: onUpgradeBlock
	MetacelloProjectRegistration
		copyRegistryRestoreOnErrorWhile: [ 
			self
				handleNotificationsForAction: [ 
					| version loadedSpec |
					self setDefaultsAndValidateProjectSpec.
					[ loadedSpec := (self lookupProjectSpecFor: self projectSpec) copy ]
						on: Notification
						do: [ :ex | self halt ] ] ]