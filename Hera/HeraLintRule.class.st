Class {
	#name : 'HeraLintRule',
	#superclass : 'Object',
	#instVars : [
		'astNode'
	],
	#category : 'Hera-Linter',
	#package : 'Hera',
	#tag : 'Linter'
}

{ #category : 'accessing' }
HeraLintRule >> astNode: anAstNode [

	astNode := anAstNode
]

{ #category : 'applying' }
HeraLintRule >> broken [

	self subclassResponsibility
]

{ #category : 'applying' }
HeraLintRule >> warning [

	self subclassResponsibility
]
