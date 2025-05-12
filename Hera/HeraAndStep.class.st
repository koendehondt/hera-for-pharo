Class {
	#name : 'HeraAndStep',
	#superclass : 'HeraStep',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraAndStep >> accept: visitor [

	visitor visitAndStep: self
]

{ #category : 'accessing' }
HeraAndStep >> keyword [

	^ 'And'
]
