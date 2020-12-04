Class {
	#name : #AoCForestMap,
	#superclass : #Object,
	#instVars : [
		'mapAsString',
		'slope',
		'extendedMap',
		'treesAsPoints'
	],
	#category : #'AdventOfCode2020-Day 3'
}

{ #category : #'instance creation' }
AoCForestMap class >> fromString: aString slope: aPoint [
^ self new mapString: aString slope: aPoint 
]

{ #category : #counting }
AoCForestMap >> countTreesOnPath [

	^ treesAsPoints count: [ :treePoint | 
		  (0 @ 0 to: slope sideOf: treePoint) = #center ]
]

{ #category : #private }
AoCForestMap >> extendedMapHeight [

	^ (extendedMap splitOn: self splitter) size
]

{ #category : #private }
AoCForestMap >> extendedMapWidth [

^ (extendedMap splitOn: self splitter)  first size
]

{ #category : #private }
AoCForestMap >> extendsMapIfRequired [

	| width height splittedMap requiredMapWidth widthExtensions |
	splittedMap := mapAsString splitOn: self splitter.
	width := splittedMap first size.
	height := splittedMap size.
	requiredMapWidth := (slope x * (height / slope y) + 1) ceiling.
	widthExtensions := (requiredMapWidth / width) ceiling.

	extendedMap := Character cr join:
		               (splittedMap collect: [ :line | 
			                line repeat: widthExtensions ]).

	treesAsPoints := ((extendedMap splitOn: self splitter) 
		                  collectWithIndex: [ :line :numRow | 
			                  (line asOrderedCollection collectWithIndex: [ 
				                   :char 
				                   :numColumn | 
				                   char = $# ifTrue: [ numColumn - 1 @ (numRow - 1) ] ]) 
				                  reject: #isNil ]) flattened
]

{ #category : #initialization }
AoCForestMap >> mapString: aString slope: aPoint [


	
	mapAsString := aString.
	slope := aPoint.
	self extendsMapIfRequired
]

{ #category : #private }
AoCForestMap >> splitter [
^ [ :each | 
		          each = Character cr or: [ each = Character lf ]]
]
