Class {
	#name : 'HeraRuleToken',
	#superclass : 'HeraKeywordToken',
	#category : 'Hera-Parser',
	#package : 'Hera',
	#tag : 'Parser'
}

{ #category : 'accessing' }
HeraRuleToken class >> keyword [

	^ 'Rule:'
]

{ #category : 'testing' }
HeraRuleToken >> isRuleToken [

	^ true
]
