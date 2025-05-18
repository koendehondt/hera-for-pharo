Class {
	#name : 'HeraRunnerTool',
	#superclass : 'Object',
	#category : 'Hera-Tools',
	#package : 'Hera-Tools'
}

{ #category : 'accessing' }
HeraRunnerTool >> resultsFileReference [

	^ FileLocator imageDirectory / 'acceptance_tests_results.txt'
]

{ #category : 'running' }
HeraRunnerTool >> run: aScope [

	| scriptRunner |
	scriptRunner := HeraMultiScriptRunner new.
	self resultsFileReference writeStreamDo: [ :stream |
		scriptRunner runScope: aScope reportOn: stream ]
]

{ #category : 'running' }
HeraRunnerTool >> runAll [

	self run: HeraScope default
]
