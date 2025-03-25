Class {
	#name : 'HeraFailure',
	#superclass : 'HeraError',
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'running' }
HeraFailure >> heraReportStep: aStep in: aReporter [

	aReporter reportFailedStep: aStep withFailure: self
]
