Class {
	#name : #PasswordGrammar,
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
PasswordGrammar class >> countInvalidPasswords: aCollection [
	| parser |
	parser := self new.
	^ aCollection count: [ :password | 
		                    (parser matches: password)
			                       not ].
]

{ #category : #grammar }
PasswordGrammar >> interval [

	^ number , $- asParser , number ==> [ :nodes | Interval from: nodes first to: nodes last ]
]

{ #category : #grammar }
PasswordGrammar >> invalidPassword [

	^ validator negate flatten
]

{ #category : #grammar }
PasswordGrammar >> line [

	^ invalidPassword / validPassword 
]

{ #category : #grammar }
PasswordGrammar >> number [

	^ #digit asParser plus trim flatten ==> [ :str | str asNumber ]
]

{ #category : #grammar }
PasswordGrammar >> password [

	^ #letter asParser plus trim flatten
]

{ #category : #grammar }
PasswordGrammar >> policy [ 
^ interval, #letter asParser trim, $: asParser.
]

{ #category : #grammar }
PasswordGrammar >> policyWithPassword [
^ policy , password.
]

{ #category : #grammar }
PasswordGrammar >> start [

	^ validPassword
]

{ #category : #grammar }
PasswordGrammar >> validPassword [

	^ validator flatten
]

{ #category : #grammar }
PasswordGrammar >> validator [

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
