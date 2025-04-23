*rowancello-core
stonOn: stonWriter
	| savedLoaderClass savedVersionNumberClass |
	savedLoaderClass := loaderClass.
	savedVersionNumberClass := versionNumberClass.
	[ 
	versionNumberClass := loaderClass := nil.	"can't write a class to STON"
	super stonOn: stonWriter ]
		ensure: [ 
			loaderClass := savedLoaderClass.
			versionNumberClass := savedVersionNumberClass ]