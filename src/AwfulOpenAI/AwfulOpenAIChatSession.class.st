Class {
	#name : #AwfulOpenAIChatSession,
	#superclass : #OpenAIChatSession,
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulOpenAIChatSession >> submitPrompt: aPromptString role: aRoleString [
	| chat response assistantChat |
	chat := OpenAISDKChat createWithRole: aRoleString content: aPromptString.

	self addChat: chat.

	aRoleString = 'user'
		ifTrue: [ response := sdk
					createChatCompletionWithMessages: chats
					model: model
					temperature: temperature.

			assistantChat := response choices first message.
			self addChat: assistantChat ]
]

{ #category : #accessing }
AwfulOpenAIChatSession >> submitPrompt: aPromptString role: aRoleString transcript: aTranscript [
	| chat response assistantChat |
	chat := OpenAISDKChat createWithRole: aRoleString content: aPromptString.

	self addChat: chat.

	aRoleString = 'user'
		ifTrue: [ response := sdk
					createChatCompletionWithMessages: chats
					model: model
					temperature: temperature.

			assistantChat := response choices first message.
			self addChat: assistantChat ]
]

{ #category : #accessing }
AwfulOpenAIChatSession >> submitUserPrompt: anArticleString transcript: aTranscript [
	^ self submitPrompt: anArticleString role: 'user' transcript: aTranscript
]

{ #category : #accessing }
AwfulOpenAIChatSession >> systemPrompt: anObject [
	sdk systemPrompt: anObject
]
