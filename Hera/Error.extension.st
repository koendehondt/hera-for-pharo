Extension { #name : 'Error' }

{ #category : '*Hera' }
Error >> heraReportStep: aStep in: aReporter [

	aReporter reportErrorStep: aStep withError: self
]
