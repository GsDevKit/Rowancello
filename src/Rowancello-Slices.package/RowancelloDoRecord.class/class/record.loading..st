recording
record: sliceUrl loading: loadList
	"similar functionality to Metacello>>record: ... return list of packages and projects that would be loaded"

	^ self new record: (RowancelloSlice fromUrl: sliceUrl) loading: loadList