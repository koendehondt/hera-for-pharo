Class {
	#name : 'HeraGivenStep',
	#superclass : 'HeraStep',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraGivenStep >> accept: visitor [

	visitor visitGivenStep: self
]

{ #category : 'accessing' }
HeraGivenStep >> keyword [

	^ 'Given'
]
