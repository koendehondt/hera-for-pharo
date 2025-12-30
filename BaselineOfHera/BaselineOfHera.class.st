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
			package: 'Hera-AcceptanceTestsForTesting' with: [ spec requires: #('Hera') ];
			package: 'Hera-AcceptanceTests' with: [ spec requires: #('Hera') ];
			package: 'Hera-Documentation' with: [ spec requires: #('Hera') ];
			package: 'Hera-Pharo-AcceptanceTests' with: [ spec requires: #('Hera') ];
			package: 'Hera-Tests' with: [ spec requires: #('Hera' 'Hera-AcceptanceTestsForTesting') ];
			package: 'Hera-UI-Tests' with: [ spec requires: #('Hera-UI' 'Hera-AcceptanceTestsForTesting') ];
			package: 'Hera-Tools';
			package: 'Hera-Tools-Tests' with: [ spec requires: #('Hera' 'Hera-Tools' 'Hera-AcceptanceTests') ] ].
	spec postLoadDoIt: #postLoad
]

{ #category : 'baselines' }
BaselineOfHera >> initializeClasses [

	HeraSettings initialize.
	HeraResultStatus initialize
]

{ #category : 'baselines' }
BaselineOfHera >> postLoad [

	self initializeClasses.
	KMRepository reset. "Register the global keyboard shortcut to open the Hera Feature Browser."
]
