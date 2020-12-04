Class {
	#name : #AoCBitBltForestMap,
	#superclass : #AoCForestMap,
	#category : #'AdventOfCode2020-Day 3'
}

{ #category : #counting }
AoCBitBltForestMap >> countTreesOnPath [

	| mapForm slopeForm pathVertex slopeCanvas |
	mapForm := self form.
	slopeForm := Form extent: mapForm extent depth: 8.
	slopeForm fillBlack.
	pathVertex := OrderedCollection new.
	1 to: ((mapForm height // slope y) max: (mapForm width // slope x)) ceiling do: [ :i | 
	pathVertex add: (slope * i) ].
	slopeCanvas := slopeForm getCanvas.
	pathVertex do: [ :vertex | 
		slopeCanvas
			drawPolygon: { vertex }
			color: Color white
			borderWidth: 1
			borderColor: Color white ].

	(BitBlt toForm: mapForm) copyForm: slopeForm to: 0 @ 0 rule: Form and.

	mapForm unhibernate.
	^ mapForm bits count: [ :bit | 
		  (Color colorFromPixelValue: bit depth: 32) green
			  closeTo: 1
			  precision: 0.1 ]
]

{ #category : #counting }
AoCBitBltForestMap >> form [

	| form |
	form := Form extent: self extendedMapWidth @ self extendedMapHeight  depth: 32.
	form fillGray.
	treesAsPoints do: [ :point | form colorAt: point put: Color green ].
	^ form
]
