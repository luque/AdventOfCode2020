Class {
	#name : #PassportGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'year',
		'byr',
		'eyr',
		'iyr',
		'height',
		'hgt',
		'color',
		'hcl',
		'ecl',
		'pid',
		'cid',
		'passport',
		'element',
		'validPassport'
	],
	#category : #'AdventOfCode2020-Day 4 - Passport Processing'
}

{ #category : #'as yet unclassified' }
PassportGrammar class >> countValidPassports: aCollection [

	| parser |
	parser := self new.
	^ aCollection count: [ :passport | parser matches: passport ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> byr [

	^ 'byr' asParser , ':' asParser , year flatten
	  ==> [ :nodes | #byr -> nodes third ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> cid [

	^ 'cid:' asParser , #digit asParser plus flatten
	  ==> [ :nodes | #cid -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> color [

	^ '#' asParser optional, #word asParser plus
]

{ #category : #'as yet unclassified' }
PassportGrammar >> ecl [

	^ 'ecl:' asParser , color ==> [ :nodes | #ecl -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> element [

	^ byr / eyr / iyr / hgt / hcl / ecl / pid / cid
	  
]

{ #category : #'as yet unclassified' }
PassportGrammar >> eyr [

	^ 'eyr:' asParser , year flatten ==> [ :nodes | #eyr -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> hcl [

	^ 'hcl:' asParser , color flatten ==> [ :nodes | #hcl -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> height [

^ #digit asParser plus , ('cm' asParser / 'in' asParser) optional
]

{ #category : #'as yet unclassified' }
PassportGrammar >> hgt [

	^ 'hgt:' asParser , height flatten ==> [ :nodes |  #hgt -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> iyr [

	^ 'iyr:' asParser , year flatten ==> [ :nodes | #iyr -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> mandatoryFields [
	^ #(#iyr #byr #eyr #hgt #hcl #ecl #pid)
]

{ #category : #'as yet unclassified' }
PassportGrammar >> passport [

	^ element , ((#space asParser plus , element) min: 6 max: 7)
]

{ #category : #'as yet unclassified' }
PassportGrammar >> pid [

	^ 'pid:' asParser , '#' asParser optional, #word asParser plus flatten
	  ==> [ :nodes | #pid -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> start [

	^ validPassport
]

{ #category : #'as yet unclassified' }
PassportGrammar >> validPassport [

	| passportData |
	^ passport ==> [ :tokens | 
	  passportData := Dictionary new.
	  passportData add: tokens first.
	  tokens second do: [ :token | passportData add: token second ].
	  (self mandatoryFields allSatisfy: [ :mandatoryField | passportData includesKey: mandatoryField ])
	  	   ifFalse: [ PPFailure message: 'Mandatory passport field is missing.'  ] 
		   ifTrue: [ 
			passportData  ]
	   ]
]

{ #category : #'as yet unclassified' }
PassportGrammar >> year [

^ #digit asParser plus
]
