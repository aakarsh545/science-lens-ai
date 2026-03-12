# Ask / Chat System — Postponed

Status: POSTPONED — not deleted. All code is intact and reusable.

## What was moved:
- src/pages/AskPage.tsx
- src/components/EnhancedChatView.tsx
- src/components/ChatInterface.tsx
- src/components/ChatView.tsx
- src/components/ConversationsList.tsx
- src/components/ChatProgress.tsx
- src/services/aiService.ts
- src/utils/pdfExport.ts
- supabase/functions/ask/

## What was cleaned from shared files:
- App.tsx — AskPage import and /ask route removed
- AppSidebar.tsx — /ask nav link and ConversationsList removed
- Dashboard.tsx — ChatInterface import and render removed
- DashboardMainPage.tsx — /ask navigation card removed

## To re-enable:
1. Move all src/ files back to their original locations
2. Redeploy edge function: supabase/functions/ask
3. In App.tsx re-add: import AskPage from "@/pages/AskPage"
4. In App.tsx re-add route: <Route path="ask" element={<AskPage />} />
5. In AppSidebar.tsx re-add /ask nav item and ConversationsList
6. In Dashboard.tsx re-add ChatInterface import and render
7. In DashboardMainPage.tsx re-add /ask navigation card

## DB tables still active (no action needed):
- conversations
- messages
- questions

## Note on credits:
- The credits system (user_stats.credits, deduct_credits RPC, refresh_daily_credits RPC)
  remains fully active — it is used by other edge functions too.
  Do NOT remove anything credits-related when re-enabling this feature.

