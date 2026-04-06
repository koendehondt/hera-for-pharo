Class {
	#name : 'HeraExamplesAcceptanceTest',
	#superclass : 'HeraAcceptanceTest',
	#category : 'Hera-Documentation-Examples',
	#package : 'Hera-Documentation',
	#tag : 'Examples'
}

{ #category : 'accessing' }
HeraExamplesAcceptanceTest class >> nameInBrowser [

	^ 'General'
]

{ #category : 'features' }
HeraExamplesAcceptanceTest >> featureStopwatch [

	<heraFeature: 'Stopwatch'>

	^ (self feature: 'Stopwatch')
		scenarios: {
			(self scenario: 'Starting, stopping, and reading')
				when: 'I start the stopwatch';
				and: 'I stop the stopwatch';
				then: 'the stopwatch shows less than 1 millisecond' }
]
