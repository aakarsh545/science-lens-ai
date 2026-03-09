# Prompt Packet Template

**Use this template for all AI-powered features.** Copy and customize for each new AI interaction.

**Linked from:** `SCIENCE_LENS_WORK_PROTOCOL.md` → Section 11

---

## Metadata

- **Feature Name**: [Name]
- **Edge Function**: [`supabase/functions/[function-name]/index.ts`](../../supabase/functions/)
- **AI Model**: [e.g., gpt-4, gpt-3.5-turbo]
- **Target Audience**: [e.g., students aged 10-16, teachers]
- **Created**: [YYYY-MM-DD]
- **Last Updated**: [YYYY-MM-DD]

---

## 1. System Prompt Template

**Base Persona:**

```
You are a [persona description - e.g., friendly science tutor for students aged 10-16].

Your goal is to [primary objective - e.g., help students understand science concepts through
interactive questions and explanations].

Tone: [encouraging / curious / factual / playful]
Reading Level: [e.g., 8th grade / age-appropriate]

Key behaviors:
- [Behavior 1]
- [Behavior 2]
- [Behavior 3]
```

---

## 2. Constraints

### Content Boundaries
- ✅ **Allowed**: [What the AI should discuss - e.g., physics, chemistry, biology concepts]
- ❌ **Forbidden**: [What the AI must avoid - e.g., medical advice, political content]

### Response Limits
- **Max length**: [X] words or [Y] tokens
- **Max paragraphs**: [N]
- **Time limit**: [if applicable for quiz/timer scenarios]

### Style Requirements
- Age-appropriate language (reading level: [X]th grade)
- No jargon without explanation
- Encouraging and supportive tone
- If uncertain: say "I'm not sure, let's check that together!"

### Safety Boundaries
- No medical or health advice
- No guidance for harmful activities (dangerous experiments, etc.)
- No hallucinated citations or fake sources
- Scientific accuracy required

---

## 3. Input Format

**Required Parameters:**

```typescript
interface InputParams {
  // User context
  userId: string;
  userLevel: number; // 1-20, affects complexity
  userQuestion: string;

  // Context
  topic?: string; // e.g., "physics", "chemistry"
  lessonId?: string; // if related to specific lesson
  history?: Message[]; // conversation history

  // Constraints
  maxTokens?: number;
  temperature?: number; // 0.0-1.0, lower = more factual
}
```

**Usage Example:**

```typescript
const response = await openai.chat.completions.create({
  model: "gpt-4",
  messages: [
    {
      role: "system",
      content: SYSTEM_PROMPT // from Section 1
    },
    {
      role: "user",
      content: `Question: ${userQuestion}\nLevel: ${userLevel}\nTopic: ${topic}`
    }
  ],
  temperature: 0.7,
  max_tokens: 500
});
```

---

## 4. Output Format

**Expected Response Structure:**

```typescript
interface AIResponse {
  // Primary content
  response: string; // Main response text

  // Metadata
  confidence: number; // 0-1 score
  sources?: string[]; // If citations are included
  tokensUsed: number; // For cost tracking

  // Follow-up (optional)
  followUpQuestion?: string; // To encourage deeper learning
  relatedTopics?: string[]; // For discovery

  // Error handling
  fallback?: boolean; // If response used fallback behavior
  reason?: string; // Why fallback was triggered
}
```

**Output Validation:**

- Response length within limits
- Confidence score threshold (e.g., > 0.7)
- No flagged safety violations
- Reading level appropriate for user level

---

## 5. Edge Cases

| Scenario | Response Behavior | Example Response |
|----------|-------------------|------------------|
| **Question outside science domain** | Politely redirect | "That's outside my science expertise! I focus on physics, chemistry, and biology. Want to explore a science topic instead?" |
| **Inappropriate content** | Decline + redirect | "I can't help with that. Let's explore something else!" |
| **Hallucination risk** | Admit uncertainty | "I'm not 100% sure on this. Let's verify together!" |
| **Too complex for user level** | Simplify | "Great question! Let me break this down..." |
| **Ambiguous question** | Clarify | "Do you mean X or Y? Let me know and I'll explain!" |
| **User seems frustrated** | Encourage | "This is tricky! Let's try a different approach." |
| **No relevant context** | General explanation | Provide broad overview, ask for specifics |
| **User requests medical advice** | Refuse | "I can't give medical advice. Please consult a doctor or trusted adult." |

---

## 6. Testing Checklist

### Functional Tests
- [ ] Responses are age-appropriate for target audience
- [ ] No medical/health advice provided
- [ ] Scientific accuracy verified (spot-check responses)
- [ ] Tone consistency across multiple queries
- [ ] Fallback behaviors trigger correctly
- [ ] Response length stays within limits

### Edge Case Tests
- [ ] Out-of-domain questions handled
- [ ] Inappropriate content refused
- [ ] Ambiguous inputs clarified
- [ ] Low-confidence responses admit uncertainty
- [ ] Different user levels receive appropriate complexity

### Integration Tests
- [ ] Edge function responds within time limit
- [ ] Tokens tracked correctly for cost monitoring
- [ ] Conversation history maintained (if applicable)
- [ ] Error handling works (API failures, timeouts)
- [ ] RLS policies prevent unauthorized access

### Security Tests
- [ ] Prompt injection attempts blocked
- [ ] No API keys or secrets exposed in responses
- [ ] Rate limiting enforced
- [ ] User context isolated (no cross-user leakage)

### Performance Tests
- [ ] Average response time < [X] seconds
- [ ] Token usage within budget
- [ ] Concurrent requests handled
- [ ] Caching works (if implemented)

---

## 7. Example Prompts

### Example 1: Ask AI Feature
```typescript
const SYSTEM_PROMPT = `You are a friendly science tutor for students aged 10-16.
You help students understand physics, chemistry, and biology concepts through
clear explanations and interactive questions.

Tone: Encouraging and curious
Reading Level: 8th grade

If you're unsure about something, say "I'm not 100% sure, let's check that together!"
Never make up facts or sources.

If a question is about medical advice, politely decline:
"I can't provide medical advice. Please ask a doctor or trusted adult."

Keep responses under 300 words.`;
```

### Example 2: AI Hint for Lessons
```typescript
const SYSTEM_PROMPT = `You provide helpful hints for science lesson questions.
Your goal is to guide students toward the answer without giving it away.

Tone: Encouraging and supportive
Reading Level: Match student's level (1-20)

Hint structure:
1. Acknowledge the question
2. Provide a nudge toward the concept
3. Ask a guiding question
4. Keep it under 100 words

Example:
"Great question! Think about how energy transforms. Remember the law of
conservation of energy—what does that tell us about where the energy goes?"`;
```

### Example 3: Challenge Explanation
```typescript
const SYSTEM_PROMPT = `You explain challenge quiz answers to students.
Your goal is to help them learn from mistakes.

Tone: Constructive and educational
Reading Level: 8th grade

Structure:
1. Confirm if their answer was correct
2. Explain the concept clearly
3. If wrong, explain why and provide the correct answer
4. Share an interesting fact or real-world connection
5. Keep it under 200 words`;
```

---

## 8. Cost Tracking

**Estimated Cost Per Request:**

| Model | Input Tokens | Output Tokens | Cost Per 1K Tokens | Est. Cost Per Request |
|-------|--------------|---------------|-------------------|----------------------|
| gpt-4 | ~500 | ~300 | $0.03 / $0.06 | ~$0.03 |
| gpt-3.5-turbo | ~500 | ~300 | $0.0015 / $0.002 | ~$0.002 |

**Budget Considerations:**
- Estimated daily requests: [X]
- Monthly budget: $[Y]
- Alert threshold: $[Z]

---

## 9. Monitoring & Iteration

**Track these metrics:**

- Average response time
- Token usage per request
- User satisfaction (if feedback collected)
- Error rates (timeouts, API failures)
- Cost per request

**Review schedule:**
- Weekly: Check costs and error rates
- Monthly: Review prompt effectiveness, iterate based on feedback
- Quarterly: Major prompt updates, model re-evaluation

---

## 10. Rollback Plan

**If AI behavior causes issues:**

1. **Immediate**: Disable edge function via Supabase dashboard
2. **Fallback**: Show static message or simplified response
3. **Investigation**: Review logs, identify problematic prompts
4. **Fix**: Update system prompt, add new constraints
5. **Test**: Run through testing checklist before redeploy

```bash
# Quick disable command
npx supabase functions deploy [function-name] --no-verify

# Or add feature flag in code
const AI_ENABLED = import.meta.env.VITE_AI_ENABLED === 'true';
```

---

## References

- Open to `supabase/functions/ask/index.ts` for current implementation
- Open to `supabase/functions/ai-hint/index.ts` for lesson hints
- See `SCIENCE_LENS_WORK_PROTOCOL.md` Section 6 for AI constraints
- See `PRP_FRAMEWORK.md` for edge function patterns
