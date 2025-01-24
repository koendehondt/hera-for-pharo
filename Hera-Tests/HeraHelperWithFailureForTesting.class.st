Class {
	#name : 'HeraHelperWithFailureForTesting',
	#superclass : 'HeraHelperForTesting',
	#category : 'Hera-Tests-Support',
	#package : 'Hera-Tests',
	#tag : 'Support'
}

{ #category : 'helpers' }
HeraHelperWithFailureForTesting >> verifyCurrentPageIsSignInPage [

	self expect: false description: 'The current page is not the sign-in page.'
]
