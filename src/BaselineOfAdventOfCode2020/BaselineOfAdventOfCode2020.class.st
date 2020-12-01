Class {
	#name : #BaselineOfAdventOfCode2020,
	#superclass : #BaselineOf,
	#category : #BaselineOfAdventOfCode2020
}

{ #category : #baselines }
BaselineOfAdventOfCode2020 >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: #AdventOfCode2020;
			package: #'AdventOfCode2020-Tests'
			with: [ spec requires: #( 'AdventOfCode2020' ) ].
		spec
			group: 'Core' with: #( 'AdventOfCode2020' );
			group: 'CoreTests' with: #( 'AdventOfCode2020' 'AdventOfCode2020-Tests' );
			group: 'default' with: #( 'Core' 'CoreTests' ) ]
]
