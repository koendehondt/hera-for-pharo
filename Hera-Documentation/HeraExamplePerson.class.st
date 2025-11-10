Class {
	#name : 'HeraExamplePerson',
	#superclass : 'Object',
	#instVars : [
		'name',
		'children',
		'isDisabled',
		'sex'
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
HeraExamplePerson >> beFemale [

	sex := #female
]

{ #category : 'accessing' }
HeraExamplePerson >> beMale [

	sex := #male
]

{ #category : 'accessing' }
HeraExamplePerson >> beOther [

	sex := #other
]

{ #category : 'accessing' }
HeraExamplePerson >> children [

	^ children
]

{ #category : 'initialization' }
HeraExamplePerson >> initialize [

	super initialize.
	name := 'Unknown'.
	isDisabled := false.
	children := OrderedCollection new
]

{ #category : 'accessing' }
HeraExamplePerson >> isDisabled [

	^ isDisabled
]

{ #category : 'accessing' }
HeraExamplePerson >> isDisabled: aBoolean [

	isDisabled := aBoolean
]

{ #category : 'testing' }
HeraExamplePerson >> isFemale [

	^ sex = #female
]

{ #category : 'testing' }
HeraExamplePerson >> isMale [

	^ sex = #male
]

{ #category : 'testing' }
HeraExamplePerson >> isOther [

	^ sex = #other
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
