Class {
	#name : #AwfulClaudeSDKChatCompletion,
	#superclass : #OpenAISDKChatCompletion,
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulClaudeSDKChatCompletion class >> createWithAPIResponse: aResponse [
	| choice aMessage choices|
	choice := Dictionary new.
	aMessage := Dictionary new.
	aMessage at: 'content' put: (((aResponse at: 'content') last) at: 'text').
	aMessage at: 'role' put: (aResponse at: 'role').

	choice at: 'message' put: aMessage.
	choice at: 'index' put: 1.
	choice at: 'finish_reason' put: (aResponse at: 'stop_reason').
	
	choices := OrderedCollection with: (AwfulClaudeSDKChatCompletionChoices createWithAPIResponse: choice).

	^ super new
		id: (aResponse at: 'id');
		object: (aResponse at: 'type');
		created: nil;
		model: (aResponse at: 'model');
		choices: choices;
		usage: (aResponse at: 'usage')
]
