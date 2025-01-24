Class {
	#name : 'BaselineOfHera',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfHera',
	#package : 'BaselineOfHera'
}

{ #category : 'baselines' }
BaselineOfHera >> baseline: spec [
	<baseline>
	
	"See https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md"
	
	spec for: #common do: [
		spec
			package: 'Hera';
			package: 'Hera-UI' with: [ spec requires: #('Hera') ];
			package: 'Hera-AcceptanceTests' with: [ spec requires: #('Hera') ];
			package: 'Hera-Tests' with: [ spec requires: #('Hera') ];
			package: 'Hera-UI-Tests' with: [ spec requires: #('Hera-UI') ] ].
	spec postLoadDoIt: #postLoad
]

{ #category : 'baselines' }
BaselineOfHera >> initializeClasses [

	Smalltalk globals allClasses
		select: [ :class | class name beginsWith: 'Hera' ]
		thenDo: [ :class | class initialize ]
]

{ #category : 'baselines' }
BaselineOfHera >> postLoad [

	self initializeClasses
]
