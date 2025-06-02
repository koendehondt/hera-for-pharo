Class {
	#name : 'HeraWhenStep',
	#superclass : 'HeraStep',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraWhenStep >> accept: visitor [

	visitor visitWhenStep: self
]

{ #category : 'accessing' }
HeraWhenStep >> keyword [

	^ 'When'
]
