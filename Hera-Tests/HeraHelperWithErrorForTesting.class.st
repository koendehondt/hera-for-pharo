Class {
	#name : 'HeraHelperWithErrorForTesting',
	#superclass : 'HeraHelperForTesting',
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'helpers' }
HeraHelperWithErrorForTesting >> pressSignInButton [

	Error signal: 'Button not found'
]
