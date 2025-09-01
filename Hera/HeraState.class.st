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
HeraState >> at: aSymbol [

	^ state at: aSymbol ifAbsent: [ nil ]
]

{ #category : 'accessing' }
HeraState >> at: aSymbol put: anObject [

	^ state at: aSymbol put: anObject
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
