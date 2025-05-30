generating
generate
	| metaDataDict package |
	metaDataDict := self baselineMetadata.
	package RowancelloPackage new.
	(metaDataDict at: 'Packages')
		keysAndValuesDo: [ :packageName :packageDetails | 
			packageDetails
				keysAndValuesDo: [ :attributeArray :packageProperties | 
					packageProperties
						keysAndValuesDo: [ :property :propertyValue | 
							"and the work begins"
							 self halt: 'not yet implemented'] ] ]