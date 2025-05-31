accessing
addPackagePropertyFor: packageName at: propertyName put: propertyValue
	^ (self packageProperties at: packageName ifAbsentPut: [ Dictionary new ])
		at: propertyName
		put: propertyValue