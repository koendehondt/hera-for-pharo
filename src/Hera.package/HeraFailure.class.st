Class {
	#name : 'HeraFailure',
	#superclass : 'HeraError',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'running' }
HeraFailure >> heraReportStep: aStep of: aScenario in: aReporter [

	aReporter reportFailedStep: aStep of: aScenario withFailure: self
]
