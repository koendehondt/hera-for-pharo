Class {
	#name : 'HeraRunnerTool',
	#superclass : 'Object',
	#category : 'Hera-Tools',
	#package : 'Hera-Tools'
}

{ #category : 'accessing' }
HeraRunnerTool >> resultsFileReference [

	^ FileLocator imageDirectory / 'acceptance_test_results.txt'
]

{ #category : 'running' }
HeraRunnerTool >> run: aScope [

	| reporter |
	reporter := HeraTextReporter new.
	HeraScriptRunner new
		scope: aScope asRunnerScope;
		reporter: reporter;
		run.
	self resultsFileReference writeStreamDo: [ :stream |
		stream nextPutAll: reporter text string ]
]

{ #category : 'running' }
HeraRunnerTool >> runAll [

	self run: HeraScope default
]
