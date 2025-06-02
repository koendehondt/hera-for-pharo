Class {
	#name : 'HeraMultiScriptRunner',
	#superclass : 'Object',
	#category : 'Hera-Running',
	#package : 'Hera',
	#tag : 'Running'
}

{ #category : 'running' }
HeraMultiScriptRunner >> reportResult: aResult featureCount: anInteger on: aStream [

	aStream
		cr;
		cr;
		nextPutAll: 'Number of features: ';
		print: anInteger;
		cr;
		nextPutAll: 'Number of scenarios: ';
		print: aResult totalCount;
		cr;
		nextPutAll: 'Passed: ';
		print: aResult passedCount;
		cr;
		nextPutAll: 'Failed: ';
		print: aResult failedCount;
		cr;
		nextPutAll: 'Error: ';
		print: aResult errorCount
]

{ #category : 'running' }
HeraMultiScriptRunner >> runScope: aScope reportOn: aStream [

	| result featureCount |
	result := HeraResult new.
	featureCount := 0.
	aScope
		do: [ :acceptanceTestClass |
			acceptanceTestClass sortedFeatures
				do: [ :eachAcceptanceTest | | scriptRunner reporter |
					featureCount := featureCount + 1.
					reporter := HeraTextReporter new.
					scriptRunner := HeraScriptRunner new
						suppressResultSummary;
						suppressPauseAndDebugSteps;
						acceptanceTest: eachAcceptanceTest;
						result: result;
						reporter: reporter.
					scriptRunner run.
					aStream nextPutAll: reporter text string ]
				separatedBy: [ aStream cr; cr ] ]
		separatedBy: [ aStream cr; cr ].
	self reportResult: result featureCount: featureCount on: aStream
]
