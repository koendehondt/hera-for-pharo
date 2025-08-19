Class {
	#name : 'HeraClassCreator',
	#superclass : 'Object',
	#instVars : [
		'targetPackage',
		'targetTag',
		'targetSuperclass',
		'targetClassName'
	],
	#category : 'Hera-UI-Feature Browser',
	#package : 'Hera-UI',
	#tag : 'Feature Browser'
}

{ #category : 'creating' }
HeraClassCreator >> createClass [

	^ Smalltalk classInstaller make: [ :classBuilder |
		classBuilder
			name: self targetClassName;
			superclass: self targetSuperclass;
			package: self targetPackage;
			tag: self targetTag ]
]

{ #category : 'accessing' }
HeraClassCreator >> targetClassName [

	^ targetClassName
]

{ #category : 'accessing' }
HeraClassCreator >> targetClassName: aString [

	targetClassName := aString
]

{ #category : 'accessing' }
HeraClassCreator >> targetPackage [

	^ targetPackage
]

{ #category : 'accessing' }
HeraClassCreator >> targetPackage: aPackage [

	targetPackage := aPackage
]

{ #category : 'accessing' }
HeraClassCreator >> targetSuperclass [

	^ targetSuperclass
]

{ #category : 'accessing' }
HeraClassCreator >> targetSuperclass: aClass [

	targetSuperclass := aClass
]

{ #category : 'accessing' }
HeraClassCreator >> targetTag [

	^ targetTag
]

{ #category : 'accessing' }
HeraClassCreator >> targetTag: aTag [

	targetTag := aTag
]
