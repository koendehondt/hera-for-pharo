Class {
	#name : 'HeraDataTable',
	#superclass : 'HeraStructuredData',
	#instVars : [
		'data'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'comparing' }
HeraDataTable >> = other [

	^ self class = other class and: [ self data = other data ]
]

{ #category : 'converting' }
HeraDataTable >> asArray [
	"Assume that there is one column.
	 Answer an Array with the values in the single column."

	^ (data inject: OrderedCollection new into: [ :accu :eachRow | accu add: eachRow first; yourself ]) asArray
]

{ #category : 'converting' }
HeraDataTable >> asAssociations [
	"Assume that the first column is a header column and the second column holds the values.
	 Answer an Array of Associations with headers and values."

	^ (data inject: OrderedCollection new into: [ :accu :eachRow | accu add: eachRow first -> eachRow second; yourself ]) asArray
]

{ #category : 'converting' }
HeraDataTable >> asDataTableWithResolvedParameters: parametersAndValues [

	| resolvedData |
	resolvedData := self data collect: [ :row |
		row collect: [ :cell | cell heraParameterFormat: parametersAndValues ] ].
	^ self copy data: resolvedData
]

{ #category : 'converting' }
HeraDataTable >> asDictionaries [
	"Assume that the first row is a header row. The cell values will be used as string keys in the dictionaries.
	 Answer an Array of Dictionary instances with the data from the rows below the header row."

	| headerRow dictionaries dictionary |
	headerRow := data first.
	dictionaries := OrderedCollection new.
	data allButFirstDo: [ :eachRow |
		dictionary := Dictionary new.
		headerRow withIndexDo: [ :eachAttribute :index|
			dictionary at: eachAttribute put: (eachRow at: index) ].
		dictionaries add: dictionary ].
	^ dictionaries asArray
]

{ #category : 'converting' }
HeraDataTable >> asDictionary [
	"Assume that the first column is a header column and the second column holds the values.
	 Answer a Dictionary that maps the headers to the values."

	^ Dictionary newFrom: self asAssociations
]

{ #category : 'converting' }
HeraDataTable >> asStepArgument [

	^ HeraDataTableArgument new dataTable: self
]

{ #category : 'enumerating' }
HeraDataTable >> associationsDo: aBlock [
	"Assume that the first column is a header column and the second column holds the values.
	 Evaluate aBlock for every header and value."

	self asAssociations do: [ :association|
		aBlock value: association key value: association value ]
]

{ #category : 'accessing' }
HeraDataTable >> columnHeaders [
	"Assume that the first row is a header row.
	 Answer an Array with the headers."

	^ data first
]

{ #category : 'private - accessing' }
HeraDataTable >> data [
	"Private because the receiver is immutable."

	^ data
]

{ #category : 'accessing' }
HeraDataTable >> data: anArrayOfArrayOfStrings [

	data := anArrayOfArrayOfStrings
]

{ #category : 'comparing' }
HeraDataTable >> hash [

	^ self data hash
]

{ #category : 'initialization' }
HeraDataTable >> initialize [

	super initialize.
	data := #()
]

{ #category : 'testing' }
HeraDataTable >> isEmpty [

	^ self data isEmpty
]

{ #category : 'accessing' }
HeraDataTable >> parameters [

	^ self data inject: Set new into: [ :accu :row |
		row do: [ :cellValue |
			accu addAll: (HeraParameterizedString new string: cellValue) parameters ].
		accu ]
]

{ #category : 'printing' }
HeraDataTable >> printFormattedOn: aStream indentation: aNumberOfTabs [

	| columnWidths |
	data ifEmpty: [ ^ self ].
	columnWidths := Array new: data first size withAll: 0.
	data do: [ :eachRow |
		eachRow withIndexDo: [ :eachDatum :index |
			columnWidths at: index put: ((columnWidths at: index) max: eachDatum size) ] ].
	data withIndexDo: [ :eachRow :rowIndex |
		rowIndex > 1 ifTrue: [ aStream cr ].
		aStream
			tab: aNumberOfTabs;
			nextPut: $|.
		eachRow withIndexDo: [ :eachDatum :columnIndex |
			aStream
				space;
				nextPutAll: (eachDatum padRightTo: (columnWidths at: columnIndex));
				space;
				nextPut: $| ] ]
]

{ #category : 'printing' }
HeraDataTable >> printOn: aStream [

	self printFormattedOn: aStream indentation: 0
]

{ #category : 'accessing' }
HeraDataTable >> rows [

	^ data
]
