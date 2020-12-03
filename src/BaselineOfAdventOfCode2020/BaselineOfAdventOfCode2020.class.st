Class {
	#name : #BaselineOfAdventOfCode2020,
	#superclass : #BaselineOf,
	#category : #BaselineOfAdventOfCode2020
}

{ #category : #baselines }
BaselineOfAdventOfCode2020 >> baseline: spec [

	<baseline>
	self dependencies: spec.

	spec for: #common do: [ 
		spec
			package: #AdventOfCode2020
			with: [ spec requires: #( 'PetitParser' ) ];
			package: #'AdventOfCode2020-Tests'
			with: [ spec requires: #( 'AdventOfCode2020' ) ].
		spec
			group: 'Core' with: #( 'AdventOfCode2020' );
			group: 'CoreTests'
			with: #( 'AdventOfCode2020' 'AdventOfCode2020-Tests' );
			group: 'default' with: #( 'Core' 'CoreTests' ) ]
]

{ #category : #baselines }
BaselineOfAdventOfCode2020 >> dependencies: spec [

	spec
		baseline: 'PetitParser'
		with: [ spec repository: 'github://moosetechnology/PetitParser/src'; loads: 'Highlighter' ].
]
