Class {
	#name : 'HeraDocString',
	#superclass : 'Object',
	#instVars : [
		'lines'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'comparing' }
HeraDocString >> = other [

	^ self class = other class and: [ self lines = other lines ]
]

{ #category : 'accessing' }
HeraDocString >> lines [

	^ lines
]

{ #category : 'accessing' }
HeraDocString >> lines: anArrayOfStrings [

	lines := anArrayOfStrings
]

{ #category : 'printing' }
HeraDocString >> printFormattedOn: aStream indentation: aNumberOfTabs [

	aStream
		tab: aNumberOfTabs;
		nextPutAll: '"""'.
	lines do: [ :each | aStream crtab: aNumberOfTabs; nextPutAll: each ].
	aStream
		crtab: aNumberOfTabs;
		nextPutAll: '"""'
]

{ #category : 'printing' }
HeraDocString >> printOn: aStream [

	self printFormattedOn: aStream indentation: 0
]

{ #category : 'test api' }
HeraDocString >> string: aString [

	self lines: aString lines
]
