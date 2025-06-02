Class {
	#name : 'HeraExecutableHelperStep',
	#superclass : 'HeraExecutableStep',
	#instVars : [
		'helper'
	],
	#category : 'Hera-Step definitions',
	#package : 'Hera',
	#tag : 'Step definitions'
}

{ #category : 'accessing' }
HeraExecutableHelperStep >> helper: aHelper [

	helper := aHelper
]

{ #category : 'running' }
HeraExecutableHelperStep >> run [

	stepMethod valueWithReceiver: helper arguments: arguments
]
