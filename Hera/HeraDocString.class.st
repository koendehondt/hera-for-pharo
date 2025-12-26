Class {
	#name : 'HeraDocString',
	#superclass : 'HeraStructuredData',
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

{ #category : 'converting' }
HeraDocString >> asDocStringWithResolvedParameters: parametersAndValues [

	| resolvedLines |
	resolvedLines := self lines collect: [ :line | line heraParameterFormat: parametersAndValues ].
	^ self copy lines: resolvedLines
]

{ #category : 'converting' }
HeraDocString >> asStepArgument [

	^ HeraDocStringArgument new docString: self
]

{ #category : 'comparing' }
HeraDocString >> hash [

	^ self lines hash
]

{ #category : 'accessing' }
HeraDocString >> lines [

	^ lines
]

{ #category : 'accessing' }
HeraDocString >> lines: anArrayOfStrings [

	lines := anArrayOfStrings
]

{ #category : 'accessing' }
HeraDocString >> parameters [

	self lines ifNil: [ ^ Set new ].
	^ self lines inject: Set new into: [ :accu :line |
		accu addAll: (HeraParameterizedString new string: line) parameters; yourself ]
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
