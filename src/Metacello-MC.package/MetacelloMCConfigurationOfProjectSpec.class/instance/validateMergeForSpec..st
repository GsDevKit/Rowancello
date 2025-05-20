merging
validateMergeForSpec: aSpec
	((aSpec class isKindOf: MetacelloMCConfigurationOfProjectSpec)
		or: [ 
			aSpec class = MetacelloMCConfigurationOfProjectSpec
				or: [ aSpec class superclass = MetacelloMCConfigurationOfProjectSpec ] ])
		ifFalse: [ 
			self
				error:
					'The project spec ' , self name printString , ' in project '
						, self project label , ' has incompatible specs. '
						, aSpec class name asString , ' and ' , self class name asString
						, ' are not compatible.' ]