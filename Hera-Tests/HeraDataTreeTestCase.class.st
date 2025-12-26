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
HeraDataTreeTestCase >> testAsStepArgument [

	self assert: subject asStepArgument equals: (HeraDataTreeArgument new dataTree: subject)
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
HeraDataTreeTestCase >> testHasParameters [

	self deny: subject hasParameters.
	subject data: {
		HeraDataTreeItem new level: 1; text: '<grand_parent>' .
		HeraDataTreeItem new level: 2; text: '<parent>' .
		HeraDataTreeItem new level: 3; text: '<child>' }.
	self assert: subject hasParameters
]

{ #category : 'tests' }
HeraDataTreeTestCase >> testParameters [

	self assert: subject parameters equals: Set new.
	subject data: {
		HeraDataTreeItem new level: 1; text: '<grand_parent>' .
		HeraDataTreeItem new level: 2; text: '<parent>' .
		HeraDataTreeItem new level: 3; text: '<child>' }.
	self assert: subject parameters equals: (Set with: 'child' with: 'grand_parent' with: 'parent')
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
