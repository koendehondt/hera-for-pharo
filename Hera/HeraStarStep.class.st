Class {
	#name : 'HeraStarStep',
	#superclass : 'HeraStep',
	#category : 'Hera-Script elements',
	#package : 'Hera',
	#tag : 'Script elements'
}

{ #category : 'visiting' }
HeraStarStep >> accept: visitor [

	visitor visitStarStep: self
]

{ #category : 'accessing' }
HeraStarStep >> keyword [

	^ '*'
]
