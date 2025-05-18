Class {
	#name : 'HeraRunnerToolTestCase',
	#superclass : 'HeraTestCase',
	#category : 'Hera-Tools-Tests',
	#package : 'Hera-Tools-Tests'
}

{ #category : 'running' }
HeraRunnerToolTestCase >> describedClass [

	^ HeraRunnerTool
]

{ #category : 'running' }
HeraRunnerToolTestCase >> tearDown [

	subject resultsFileReference deleteIfAbsent: [ ].
	super tearDown
]

{ #category : 'tests' }
HeraRunnerToolTestCase >> testRunAll [

	subject runAll
]
