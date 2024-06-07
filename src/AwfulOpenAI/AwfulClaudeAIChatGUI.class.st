Class {
	#name : #AwfulClaudeAIChatGUI,
	#superclass : #OpenAIChatGUI,
	#category : #AwfulOpenAI
}

{ #category : #accessing }
AwfulClaudeAIChatGUI class >> openWithSDK: anOpenAISDK [

	| gui |
	gui := self new chatSession:
		       (AwfulClaudeChatSession startWithSDK: anOpenAISDK).
	gui open.
	gui fieldInput takeKeyboardFocus
]
