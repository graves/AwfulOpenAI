Class {
	#name : #AwfulOpenAISDK,
	#superclass : #OpenAISDK,
	#instVars : [
		'baseURL',
		'extraParams',
		'model'
	],
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulOpenAISDK class >> createWithAPIKey: anAPIKeyString baseURL: aBaseURLString [
	| sdk |
    sdk := self createWithAPIKey: anAPIKeyString.
    sdk baseURL: aBaseURLString.
    
    ^ sdk
]

{ #category : #accessing }
AwfulOpenAISDK class >> createWithAPIKey: anAPIKeyString baseURL: aBaseURLString extraParams: aDictionary [
	| sdk |
    sdk := self createWithAPIKey: anAPIKeyString.
    sdk baseURL: aBaseURLString.
    sdk extraParams: aDictionary.
    
    ^ sdk
]

{ #category : #accessing }
AwfulOpenAISDK class >> createWithAPIKey: anAPIKeyString baseURL: aBaseURLString model: aModelString [
	| sdk |
    sdk := self createWithAPIKey: anAPIKeyString.
    sdk baseURL: aBaseURLString.
    sdk model: aModelString.
    
    ^ sdk
]

{ #category : #accessing }
AwfulOpenAISDK class >> createWithAPIKey: anAPIKeyString baseURL: aBaseURLString organization: anOrganizationString [
	| sdk |
    sdk := self createWithAPIKey: anAPIKeyString organization: anOrganizationString.
    sdk baseURL: aBaseURLString.
    
    ^ sdk
]

{ #category : #accessing }
AwfulOpenAISDK >> baseURL [
	^ baseURL ifNil: [ ^ super baseURL ]
]

{ #category : #accessing }
AwfulOpenAISDK >> baseURL: aURLString [
	baseURL := aURLString.
]

{ #category : #accessing }
AwfulOpenAISDK >> createChatCompletionWithMessages: aChatObjectsArray model: aModelString temperature: aTemperatureFloat [
	| dict theClient json response decoded |
	dict := {'messages' -> (aChatObjectsArray collect: [ :e | e toDictionary ]).
			'model' -> aModelString.
			'temperature' -> aTemperatureFloat} asDictionary.

	self extraParams ifNotNil: [ dict := dict union: self extraParams ].
	self model ifNotNil: [ dict at: 'model' put: self model ].

	json := NeoJSONWriter toString: dict.

	theClient := self client.
	theClient
		entity: (ZnEntity with: json type: ZnMimeType applicationJson);
		url: self baseURL , '/chat/completions'.

	response := theClient post.

	decoded := NeoJSONReader fromString: response.
	(decoded includesKey: 'error')
		ifTrue: [ OpenAISDKException signalForObject: decoded ].

	^ OpenAISDKChatCompletion createWithAPIResponse: decoded
]

{ #category : #accessing }
AwfulOpenAISDK >> createChatCompletionWithMessages: aChatObjectsArray model: aModelString temperature: aTemperatureFloat transcript: aTranscript [
	| dict theClient json response decoded |
	
	aTranscript nextPutAll: 'Starting createChatCompletionWithMessages.';cr.
	
	dict := {'messages' -> (aChatObjectsArray collect: [ :e | e toDictionary ]).
			'model' -> aModelString.
			'temperature' -> aTemperatureFloat} asDictionary.

	self extraParams ifNotNil: [ dict := dict union: self extraParams ].
	self model ifNotNil: [ dict at: 'model' put: self model ].

	json := NeoJSONWriter toString: dict.
	
	aTranscript nextPutAll: json;cr.

	theClient := self client.
	theClient
		entity: (ZnEntity with: json type: ZnMimeType applicationJson);
		url: self baseURL , '/chat/completions'.

	response := theClient post.
	decoded := NeoJSONReader fromString: response.
	
	aTranscript nextPutAll: 'Got decoded: ';cr.
	aTranscript nextPutAll: response;cr.
	
	(decoded includesKey: 'error')
		ifTrue: [ 
			aTranscript nextPutAll: 'Signaling OpenAISDKException';cr.
			OpenAISDKException signalForObject: decoded 
		].
		
	aTranscript nextPutAll: 'Returning decoded.';cr.

	^ OpenAISDKChatCompletion createWithAPIResponse: decoded
]

{ #category : #accessing }
AwfulOpenAISDK >> extraParams [
	^ extraParams
]

{ #category : #accessing }
AwfulOpenAISDK >> extraParams: anObject [
	extraParams := anObject
]

{ #category : #accessing }
AwfulOpenAISDK >> model [
	^ model
]

{ #category : #accessing }
AwfulOpenAISDK >> model: anObject [
	model := anObject
]
