Class {
	#name : 'HeraButStep',
	#superclass : 'HeraStep',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraButStep >> accept: visitor [

	visitor visitButStep: self
]

{ #category : 'accessing' }
HeraButStep >> keyword [

	^ 'But'
]
