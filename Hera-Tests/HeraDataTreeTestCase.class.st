Class {
	#name : 'HeraDataTreeTestCase',
	#superclass : 'HeraUnitTestCase',
	#category : 'Hera-Tests-Core',
	#package : 'Hera-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
HeraDataTreeTestCase >> describedClass [

	^ HeraDataTree
]

{ #category : 'tests' }
HeraDataTreeTestCase >> testDeepestLevelForLevel1 [

	subject data: {
		HeraDataTreeItem new level: 1; text: 'John' }.
	self assert: subject deepestLevel equals: 1
]

{ #category : 'tests' }
HeraDataTreeTestCase >> testDeepestLevelForLevel2 [

	subject data: {
		HeraDataTreeItem new level: 1; text: 'John' .
		HeraDataTreeItem new level: 2; text: 'Jane' }.
	self assert: subject deepestLevel equals: 2
]

{ #category : 'tests' }
HeraDataTreeTestCase >> testDeepestLevelForLevel3 [

	subject data: {
		HeraDataTreeItem new level: 1; text: 'John' .
		HeraDataTreeItem new level: 2; text: 'Jane' .
		HeraDataTreeItem new level: 3; text: 'William' .
		HeraDataTreeItem new level: 2; text: 'Mary' }.
	self assert: subject deepestLevel equals: 3
]

{ #category : 'tests' }
HeraDataTreeTestCase >> testPrintOn [

	| actualOutput expectedOutput |
	subject data: {
		HeraDataTreeItem new level: 1; text: 'John' .
		HeraDataTreeItem new level: 2; text: 'Jane'.
		HeraDataTreeItem new level: 3; text: 'William' .
		HeraDataTreeItem new level: 2; text: 'Mary' }.
	actualOutput := String streamContents: [ :stream | subject printOn: stream ].
	expectedOutput := '
>   John
>>    Jane
>>>     William
>>    Mary' allButFirst.
	self assert: actualOutput equals: expectedOutput
]
