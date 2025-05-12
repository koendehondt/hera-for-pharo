Class {
	#name : 'HeraExecutableAcceptanceTestStep',
	#superclass : 'HeraExecutableStep',
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'running' }
HeraExecutableAcceptanceTestStep >> run [

	stepMethod valueWithReceiver: acceptanceTest arguments: arguments
]
