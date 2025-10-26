Class {
	#name : 'HeraExamplePerson',
	#superclass : 'Object',
	#instVars : [
		'name',
		'children'
	],
	#category : 'Hera-Documentation-Example domain',
	#package : 'Hera-Documentation',
	#tag : 'Example domain'
}

{ #category : 'accessing' }
HeraExamplePerson >> addChild: aPerson [

	children add: aPerson
]

{ #category : 'accessing' }
HeraExamplePerson >> children [

	^ children
]

{ #category : 'initialization' }
HeraExamplePerson >> initialize [

	super initialize.
	children := OrderedCollection new
]

{ #category : 'accessing' }
HeraExamplePerson >> name [

	^ name
]

{ #category : 'accessing' }
HeraExamplePerson >> name: aString [

	name := aString
]

{ #category : 'printing' }
HeraExamplePerson >> printOn: aStream [

	aStream
		nextPutAll: 'Person ';
		nextPutAll: self name
]
