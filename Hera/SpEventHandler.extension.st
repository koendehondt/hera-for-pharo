Extension { #name : 'SpEventHandler' }

{ #category : '*Hera' }
SpEventHandler >> heraDoubleClickEvent [

	^ events detect: [ :each | each isKindOf: SpMouseDoubleClickDefinition ] ifNone: [ nil ]
]
