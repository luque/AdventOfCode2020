Class {
	#name : #AoCPasswordGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'number',
		'interval',
		'policy',
		'password',
		'policyWithPassword',
		'validator',
		'validPassword',
		'invalidPassword',
		'line'
	],
	#category : #'AdventOfCode2020-Day 2'
}

{ #category : #counting }
AoCPasswordGrammar class >> countInvalidPasswords: aCollection [
	| parser |
	parser := self new.
	^ aCollection count: [ :password | 
		                    (parser matches: password)
			                       not ].
]

{ #category : #counting }
AoCPasswordGrammar class >> highlight: inputLinesAsString [

	| parser text inputLines |
	parser := self new.
	text := Text new.
	inputLines := inputLinesAsString splitOn: Character cr.
	inputLines do: [ :line | 
		(parser matches: line)
			ifTrue: [ text append: line ]
			ifFalse: [ 
				text append: (line asText addAttribute: TextColor red) ].
		text append: Character cr ].

	^ text
]

{ #category : #grammar }
AoCPasswordGrammar >> interval [

	^ number , $- asParser , number ==> [ :nodes | Interval from: nodes first to: nodes last ]
]

{ #category : #grammar }
AoCPasswordGrammar >> invalidPassword [

	^ validator negate flatten
]

{ #category : #grammar }
AoCPasswordGrammar >> line [

	^ invalidPassword / validPassword 
]

{ #category : #grammar }
AoCPasswordGrammar >> number [

	^ #digit asParser plus trim flatten ==> [ :str | str asNumber ]
]

{ #category : #grammar }
AoCPasswordGrammar >> password [

	^ #letter asParser plus trim flatten
]

{ #category : #grammar }
AoCPasswordGrammar >> policy [ 
^ interval, #letter asParser trim, $: asParser.
]

{ #category : #grammar }
AoCPasswordGrammar >> policyWithPassword [
^ policy , password.
]

{ #category : #grammar }
AoCPasswordGrammar >> start [

	^ validPassword
]

{ #category : #grammar }
AoCPasswordGrammar >> validPassword [

	^ validator flatten
]

{ #category : #grammar }
AoCPasswordGrammar >> validator [

	^ policyWithPassword ==> [ :tokens | 
	  | policyInterval policyLetter passwordText numOccurrencesOfLetter |
	  "	  tokens := cc value."
	  policyInterval := tokens first first.
	  policyLetter := tokens first second.
	  passwordText := tokens second.
	  numOccurrencesOfLetter := passwordText count: [ :char | 
		                            char == policyLetter ].
	  (policyInterval rangeIncludes: numOccurrencesOfLetter)
		  ifFalse: [ PPFailure message: 'Password policy is not satisfied' ]
		  ifTrue: [ tokens ] ]
]
