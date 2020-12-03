Class {
	#name : #AoCPart2PasswordGrammar,
	#superclass : #AoCPasswordGrammar,
	#category : #'AdventOfCode2020-Day 2'
}

{ #category : #grammar }
AoCPart2PasswordGrammar >> validator [

	^ policyWithPassword ==> [ :tokens | 
	  | policyInterval policyLetter passwordText |
	  policyInterval := tokens first first.
	  policyLetter := tokens first second.
	  passwordText := tokens second.
	  (((passwordText size >= policyInterval first) and: [(passwordText at: policyInterval first) == policyLetter]) xor: [ 
		   (passwordText size >= policyInterval last) and: [(passwordText at: policyInterval last) == policyLetter ] ])
		  ifFalse: [ PPFailure message: 'Password policy is not satisfied' ]
		  ifTrue: [ tokens ] ]
]
