Class {
	#name : 'HeraState',
	#superclass : 'Object',
	#instVars : [
		'state'
	],
	#category : 'Hera-Core',
	#package : 'Hera',
	#tag : 'Core'
}

{ #category : 'accessing' }
HeraState >> at: keyObject [

	^ state at: keyObject ifAbsent: [ nil ]
]

{ #category : 'accessing' }
HeraState >> at: keyObject put: valueObject [

	^ state at: keyObject put: valueObject
]

{ #category : 'accessing' }
HeraState >> clear [

	state := Dictionary new
]

{ #category : 'initialization' }
HeraState >> initialize [

	super initialize.
	self clear
]
