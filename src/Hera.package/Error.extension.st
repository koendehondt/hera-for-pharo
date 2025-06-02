Extension { #name : 'Error' }

{ #category : '*Hera' }
Error >> heraReportStep: aStep of: aScenario in: aReporter [

	aReporter reportErrorStep: aStep of: aScenario withError: self
]
