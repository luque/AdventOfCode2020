Class {
	#name : #AoCBitBltForestMap,
	#superclass : #AoCForestMap,
	#category : #'AdventOfCode2020-Day 3 - Toboggan Trajectory'
}

{ #category : #counting }
AoCBitBltForestMap >> countTreesOnPath [

	| mapForm  |
	mapForm := self form.
	(BitBlt toForm: mapForm)
		copyForm: self slopeMaskForm
		to: 0 @ 0
		rule: Form and.

	^ mapForm bits count: [ :bit | 
		  (Color colorFromPixelValue: bit depth: 32) green
			  closeTo: 1
			  precision: 0.1 ]
]

{ #category : #counting }
AoCBitBltForestMap >> form [

	| form |
	form := Form
		        extent: self extendedMapWidth @ self extendedMapHeight
		        depth: 32.
	form fillBlack.
	treesAsPoints do: [ :point | form colorAt: point put: Color green ].
	^ form
]

{ #category : #counting }
AoCBitBltForestMap >> slopeMaskForm [


	| slopeForm numPointsInTrajectory |
	slopeForm := Form extent:(self extendedMapWidth @ self extendedMapHeight ) depth: 8.
	slopeForm fillBlack.
	numPointsInTrajectory := ((self extendedMapHeight  // slope y max:
		                           self extendedMapWidth // slope x) - 1) ceiling.
	0 to: numPointsInTrajectory do: [ :i | 
		slopeForm
			fill: (Rectangle point: slope * i point: slope * i + (1 @ 1))
			fillColor: Color white ].
		
	^ slopeForm
]
