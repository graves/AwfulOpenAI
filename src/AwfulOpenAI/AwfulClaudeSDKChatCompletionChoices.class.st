Class {
	#name : #AwfulClaudeSDKChatCompletionChoices,
	#superclass : #OpenAISDKChatCompletionChoices,
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulClaudeSDKChatCompletionChoices >> createWithAPIResponse: aResponse [

	| aMessage |
	aMessage := aResponse at: 'message'.
	^ self new
		  index: (aResponse at: 'index');
		  message: (OpenAISDKChat
				   createWithRole: (aMessage at: 'role')
				   content: (aMessage at: 'content'));
		  finishReason: (aResponse at: 'finish_reason')
]
