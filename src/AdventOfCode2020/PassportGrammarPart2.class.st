Class {
	#name : #PassportGrammarPart2,
	#superclass : #PPCompositeParser,
	#instVars : [
		'color',
		'height',
		'passport',
		'element',
		'year',
		'byr',
		'eyr',
		'iyr',
		'hgt',
		'hcl',
		'ecl',
		'pid',
		'cid',
		'validPassport',
		'eyeColor'
	],
	#category : #'AdventOfCode2020-Day 4 - Passport Processing'
}

{ #category : #'as yet unclassified' }
PassportGrammarPart2 class >> countValidPassports: aCollection [

	| parser |
	parser := self new.
	^ aCollection count: [ :passport | parser matches: passport ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> byr [

	| yearValue |
	^ 'byr' asParser , ':' asParser , year flatten ==> [ :nodes | 
	  yearValue := nodes third asNumber.
	  (yearValue between: 1920 and: 2002)
		  ifTrue: [ #byr -> yearValue ]
		  ifFalse: [ PPFailure message: 'Birth year is out of range.' ] ]
]

{ #category : #accessing }
PassportGrammarPart2 >> cid [

	^ 'cid:' asParser , #digit asParser plus flatten
	  ==> [ :nodes | #cid -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> color [

	^ '#' asParser , (#hex asParser times: 6)
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> ecl [

	^ 'ecl:' asParser , eyeColor ==> [ :nodes | #ecl -> nodes second ]
]

{ #category : #accessing }
PassportGrammarPart2 >> element [

	^ byr / eyr / iyr / hgt / hcl / ecl / pid / cid
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> eyeColor [

^ 'amb' asParser / 'blu' asParser / 'brn' asParser / 'gry' asParser / 'grn' asParser / 'hzl' asParser / 'oth' asParser 
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> eyr [

	| yearValue |
	^ 'eyr' asParser , ':' asParser , year flatten ==> [ :nodes | 
	  yearValue := nodes third asNumber.
	  (yearValue between: 2020 and: 2030)
		  ifTrue: [ #eyr -> yearValue ]
		  ifFalse: [ PPFailure message: 'Expiration year is out of range.' ] ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> hcl [

	^ 'hcl:' asParser , color flatten
	  ==> [ :nodes | #hcl -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> height [

	^ #digit asParser plus flatten , ('cm' asParser / 'in' asParser)
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> hgt [

	| heightUnits heightValue |
	^ 'hgt:' asParser , height ==> [ :nodes | 
	  heightUnits := nodes second second.
	  heightValue := nodes second first asNumber.
	  heightUnits = 'cm'
		  ifTrue: [ 
			  (heightValue between: 150 and: 193)
				  ifTrue: [ #hgt -> heightValue ]
				  ifFalse: [ PPFailure message: 'Height value out of range.' ] ]
		  ifFalse: [ 
			  (heightValue between: 59 and: 76)
				  ifTrue: [ #hgt -> heightValue ]
				  ifFalse: [ PPFailure message: 'Height value out of range.' ] ] ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> iyr [

	| yearValue |
	^ 'iyr' asParser , ':' asParser , year flatten ==> [ :nodes | 
	  yearValue := nodes third asNumber.
	  (yearValue between: 2010 and: 2020)
		  ifTrue: [ #iyr -> yearValue ]
		  ifFalse: [ PPFailure message: 'Issue year is out of range.' ] ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> mandatoryFields [

	^ #( #iyr #byr #eyr #hgt #hcl #ecl #pid )
]

{ #category : #accessing }
PassportGrammarPart2 >> passport [

	^ element , (#space asParser plus , element min: 6 max: 7)
]

{ #category : #accessing }
PassportGrammarPart2 >> pid [

	^ 'pid:' asParser , '#' asParser optional , (#digit asParser times:
		  9) flatten ==> [ :nodes | #pid -> nodes second ]
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> start [ 
^ validPassport
]

{ #category : #'as yet unclassified' }
PassportGrammarPart2 >> validPassport [

	| passportData |
	^ passport ==> [ :tokens | 
	  passportData := Dictionary new.
	  passportData add: tokens first.
	  tokens second do: [ :token | passportData add: token second ].
	  (self mandatoryFields allSatisfy: [ :mandatoryField | 
		   passportData includesKey: mandatoryField ])
		  ifFalse: [ 
		  PPFailure message: 'Mandatory passport field is missing.' ]
		  ifTrue: [ passportData ] ]
]

{ #category : #accessing }
PassportGrammarPart2 >> year [

	^ #digit asParser times: 4
]
