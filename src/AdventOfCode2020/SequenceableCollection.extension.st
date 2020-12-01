Extension { #name : #SequenceableCollection }

{ #category : #'*AdventOfCode2020' }
SequenceableCollection >> allTriosDo: aTernaryBlock [
	"Iterate over all the trios of the receiver and apply the ternaryBlock
	to each trio. "

	self allPairsDo: [ :first :second | 
		self do: [ :third | aTernaryBlock value: first value: second value: third ] ]
]

{ #category : #'*AdventOfCode2020' }
SequenceableCollection >> anyPairSatisfy: aBinaryBlock [
	self allPairsDo: [ :a :b | 
		(aBinaryBlock value: a value: b) ifTrue: [ ^ { a . b } ]
	] 
]

{ #category : #'*AdventOfCode2020' }
SequenceableCollection >> anyTrioSatisfy: aFullBlockClosure [

	self allTriosDo: [ :a :b :c |
		(aFullBlockClosure value: a value: b value: c) ifTrue: [ ^ { a . b . c } ] ]
]
