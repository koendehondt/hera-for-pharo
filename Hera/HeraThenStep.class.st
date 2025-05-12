Class {
	#name : 'HeraThenStep',
	#superclass : 'HeraStep',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraThenStep >> accept: visitor [

	visitor visitThenStep: self
]

{ #category : 'accessing' }
HeraThenStep >> keyword [

	^ 'Then'
]
