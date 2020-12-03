Class {
	#name : #MapOfTrees,
	#superclass : #Object,
	#instVars : [
		'mapAsString',
		'treesAsPoints',
		'slope'
	],
	#category : #'AdventOfCode2020-Day 3'
}

{ #category : #'instance creation' }
MapOfTrees class >> fromString: aString slope: aPoint [
^ self new mapString: aString slope: aPoint 
]

{ #category : #counting }
MapOfTrees >> countTreesOnPath [

	^ treesAsPoints count: [ :treePoint | 
		            (0 @ 0 to: slope sideOf: treePoint) = #center ].
]

{ #category : #private }
MapOfTrees >> extendedMapIfRequired [

	| width height splittedMap requiredMapWidth widthExtensions |
	splittedMap := mapAsString splitOn: self splitter.
	width := splittedMap first size.
	height := splittedMap size.
	requiredMapWidth := slope x * (height / slope y) ceiling.
	widthExtensions := (requiredMapWidth / width) ceiling.

	^ Character cr join:
		  (splittedMap collect: [ :line | line repeat: widthExtensions ])
]

{ #category : #initialization }
MapOfTrees >> mapString: aString slope: aPoint [

	| extendedMap |
	mapAsString := aString.
	slope := aPoint.
	extendedMap := self extendedMapIfRequired.

	treesAsPoints := ((extendedMap splitOn: self splitter) collectWithIndex: [ :line :numRow | (line asOrderedCollection collectWithIndex: [ 
				                   :char 
				                   :numColumn | 
				                   char = $# ifTrue: [ 
					                   numColumn - 1 @ (numRow - 1) ] ]) reject:
				                  #isNil ]) flattened
]

{ #category : #private }
MapOfTrees >> splitter [
^ [ :each | 
		          each = Character cr or: [ each = Character lf ]]
]
