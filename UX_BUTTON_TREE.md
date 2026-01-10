# Science Lens AI - Complete UX Button Tree

**Button-Level Accuracy Map**
*Every button, every requirement, every destination*

**Generated:** 2025-12-29
**Purpose:** UX documentation and button-level correctness verification

---

## LEGEND

**Requirements Key:**
- 🌐 **Public** - No authentication required
- 🔐 **Auth** - Authentication required
- 💰 **Credits** - Credits required (amount specified)
- ⭐ **Premium** - Premium subscription required
- 🎯 **Level** - Minimum user level required
- 🏪 **Shop** - Must own or purchase item

**Button States:**
- ✅ **Always Visible** - Button always shown
- 🔒 **Conditional** - Button shown/hidden based on conditions
- ⚠️ **Disabled** - Button exists but disabled based on conditions

---

## PUBLIC PAGES (No Authentication Required)

### 🏠 Landing Page (/)

#### Navigation Bar
```
┌─ [Sign In] ─────────────────────────────────────┐
│ Location: LandingPage.tsx:261                  │
│ Action: Opens AuthModal                        │
│ Requirements: 🌐 Public                         │
│ Variant: ghostCosmic                           │
└─────────────────────────────────────────────────┘

┌─ [Get Started] ─────────────────────────────────┐
│ Location: LandingPage.tsx:262                  │
│ Action: Opens onboarding cutscene              │
│ Requirements: 🌐 Public                         │
│ Variant: cosmic                                │
└─────────────────────────────────────────────────┘
```

#### Intro Animation (Conditional Display)
```
┌─ [Skip Intro →] ────────────────────────────────┐
│ Location: LandingPage.tsx:209                  │
│ Action: Closes intro animation                 │
│ Requirements: 🌐 Public                         │
│ Visibility: 🔒 Only during intro animation     │
└─────────────────────────────────────────────────┘
```

#### Hero Section
```
┌─ [Start Learning] ──────────────────────────────┐
│ Location: LandingPage.tsx:275                  │
│ Action: Opens onboarding cutscene              │
│ Requirements: 🌐 Public                         │
│ Variant: hero, xl, icon: Zap                   │
└─────────────────────────────────────────────────┘

┌─ [How It Works] ───────────────────────────────┐
│ Location: LandingPage.tsx:280                  │
│ Action: Smooth scroll to #how-it-works section │
│ Requirements: 🌐 Public                         │
│ Variant: ghostCosmic, xl, icon: Sparkles      │
└─────────────────────────────────────────────────┘
```

#### Features & Stats Sections
*No interactive buttons - informational content only*

#### CTA Section
```
┌─ [Start Learning Now] ──────────────────────────┐
│ Location: LandingPage.tsx:462                  │
│ Action: Opens onboarding cutscene              │
│ Requirements: 🌐 Public                         │
│ Variant: hero, xl, icons: Zap + Sparkles      │
└─────────────────────────────────────────────────┘
```

#### Footer
*No interactive buttons documented*

---

## AUTHENTICATION FLOWS

### 🔐 AuthModal (Dialog)

#### Tab Navigation
```
┌─ [Sign In] Tab ─────────────────────────────────┐
│ Location: AuthModal.tsx:195                    │
│ Action: Switches to sign-in form               │
│ Requirements: 🌐 Public (modal open)            │
└─────────────────────────────────────────────────┘

┌─ [Sign Up] Tab ─────────────────────────────────┐
│ Location: AuthModal.tsx:196                    │
│ Action: Switches to sign-up form               │
│ Requirements: 🌐 Public (modal open)            │
└─────────────────────────────────────────────────┘
```

#### Sign In Form
```
┌─ [Sign In] Submit Button ───────────────────────┐
│ Location: AuthModal.tsx:223                    │
│ Action: Authenticates user with email/password  │
│ Success: Closes modal → auto-nav to /science-lens│
│ Requirements: 🌐 Public                         │
│   - Valid email format                          │
│   - Password min 6 characters                   │
│ State: ⚠️ Disabled during isLoading             │
└─────────────────────────────────────────────────┘
```

#### Sign Up Form
```
┌─ [Sign Up] Submit Button ───────────────────────┐
│ Location: AuthModal.tsx:287                    │
│ Action: Creates new account with username       │
│ Success: Closes modal → auto-nav to /science-lens│
│ Requirements: 🌐 Public                         │
│   - Valid email format                          │
│   - Username: 3-20 chars, alphanumeric + _     │
│   - Unique username (real-time validation)      │
│   - Password min 6 characters                   │
│ State: ⚠️ Disabled if:                          │
│   - isLoading = true                            │
│   - usernameError exists                        │
│   - checkingUsername = true                     │
└─────────────────────────────────────────────────┘
```

---

## AUTHENTICATED PAGES

### 🏠 Dashboard (/science-lens)

#### Header / Top Bar
```
┌─ [⚙️ Settings] ─────────────────────────────────┐
│ Location: Dashboard.tsx:265                    │
│ Action: Opens settings panel/dialog             │
│ Requirements: 🔐 Authenticated                  │
│ Variant: ghost, icon: Settings                 │
└─────────────────────────────────────────────────┘

┌─ [🚪 Sign Out] ─────────────────────────────────┐
│ Location: Dashboard.tsx:269                    │
│ Action: Signs out user → redirects to /         │
│ Requirements: 🔐 Authenticated                  │
│ Variant: ghost, icon: LogOut                   │
│ Confirmation: None (immediate action)           │
└─────────────────────────────────────────────────┘
```

#### Learning Section (Main CTA)
```
┌─ [Choose Topic & Start] ────────────────────────┐
│ Location: Dashboard.tsx:387                    │
│ Action: Opens topic selector modal              │
│ Next: User selects topic → navigates to lesson   │
│ Requirements: 🔐 Authenticated                  │
│ Variant: cosmic, large, primary CTA             │
│ State: ⚠️ Disabled if: loading topics           │
└─────────────────────────────────────────────────┘

┌─ [Explore All Topics 📖] ───────────────────────┐
│ Location: Dashboard.tsx:398                    │
│ Action: Opens topic browser (not lesson start)  │
│ Requirements: 🔐 Authenticated                  │
│ Variant: outline, large, icon: BookOpen        │
└─────────────────────────────────────────────────┘
```

#### Error State (Conditional)
```
┌─ [Try Again] ───────────────────────────────────┐
│ Location: Dashboard.tsx:238                    │
│ Action: Reloads the page                        │
│ Requirements: 🔐 Authenticated                  │
│ Visibility: 🔒 Only shown when error loading    │
│ Variant: outline                                │
└─────────────────────────────────────────────────┘
```

---

### 📚 Learning Page (/science-lens/learning)

#### Topic/Lesson Cards
```
┌─ [Continue Learning / Start Lesson] ────────────┐
│ Location: LearnSciencePage.tsx:293             │
│ Action: Navigates to lesson player              │
│ Destination: /science-lens/learn/{topicSlug}   │
│ Requirements: 🔐 Authenticated                  │
│   - 🎯 Level requirement (varies by topic)      │
│ Text Logic:                                     │
│   - "Continue Learning" if progress > 0         │
│   - "Start Lesson" if progress = 0              │
│ Variant: outline                                │
└─────────────────────────────────────────────────┘
```

#### Lesson Player (Within Lessons)
*Documented in lesson-specific components*

---

### 🤖 Ask AI Page (/science-lens/ask)

#### Chat Interface
```
┌─ [Send Message] (Paper plane icon) ─────────────┐
│ Location: EnhancedChatView.tsx:555             │
│ Action: Sends user message to AI                │
│ Requirements: 🔐 Authenticated                  │
│   - 💰 Credits ≥ 1 (server-validated)          │
│   - Non-empty message                           │
│ State: ⚠️ Disabled if:                          │
│   - message.trim() = ""                         │
│   - isLoading = true                            │
│   - Insufficient credits (CreditGuard)          │
│ Behavior:                                       │
│   - Shows loading state during AI response      │
│   - Auto-scrolls to bottom on new message      │
└─────────────────────────────────────────────────┘

┌─ [Export Chat as PDF 📄] ───────────────────────┐
│ Location: EnhancedChatView.tsx:426             │
│ Action: Downloads conversation as PDF           │
│ Requirements: 🔐 Authenticated                  │
│   - Messages exist in conversation              │
│ Visibility: 🔒 Only when messages.length > 0   │
│ Variant: outline, small                         │
└─────────────────────────────────────────────────┘
```

#### Credit Guard (When Credits Low)
```
┌─ [Get Credits Now ⚡] ──────────────────────────┐
│ Location: CreditGuard.tsx:144                  │
│ Action: Navigates to pricing page               │
│ Destination: /science-lens/pricing              │
│ Requirements: 🔐 Authenticated                  │
│   - Credits = 0 (blocking state)                │
│ Visibility: 🔒 Only when credits = 0            │
└─────────────────────────────────────────────────┘

┌─ [Go to Dashboard] ─────────────────────────────┐
│ Location: CreditGuard.tsx:153                  │
│ Action: Navigates to dashboard                  │
│ Destination: /science-lens                      │
│ Requirements: 🔐 Authenticated                  │
│   - Credits = 0 (blocking state)                │
│ Visibility: 🔒 Only when credits = 0            │
│ Variant: outline                                │
└─────────────────────────────────────────────────┘

┌─ [Get More] (Warning Banner) ───────────────────┐
│ Location: CreditGuard.tsx:174                  │
│ Action: Navigates to pricing page               │
│ Destination: /science-lens/pricing              │
│ Requirements: 🔐 Authenticated                  │
│   - 1 ≤ Credits ≤ 3 (warning state)             │
│ Visibility: 🔒 Only when 1 ≤ credits ≤ 3        │
│ Variant: outline, small                         │
└─────────────────────────────────────────────────┘
```

---

### 💎 Pricing Page (/science-lens/pricing)

#### Navigation
```
┌─ [← Back to Dashboard] ─────────────────────────┐
│ Location: PricingPage.tsx:65                   │
│ Action: Navigates back to dashboard             │
│ Destination: /science-lens                      │
│ Requirements: 🔐 Authenticated                  │
│ Variant: ghost, icon: ArrowLeft                 │
└─────────────────────────────────────────────────┘
```

#### Premium Tab
```
┌─ [Get Premium $9.99/mo] ────────────────────────┐
│ Location: PricingPage.tsx:154                  │
│ Action: Initiates premium subscription checkout │
│ Destination: /science-lens/billing?type=premium │
│ Requirements: 🔐 Authenticated                  │
│ State: ⚠️ Disabled if:                          │
│   - User already has premium                    │
│   - Button text changes to "Already Premium"    │
│ Variant: large, gradient background             │
└─────────────────────────────────────────────────┘
```

#### Coins Tab
```
┌─ [Purchase] (500 Coins - $4.99) ────────────────┐
│ Location: PricingPage.tsx:244 (first pack)     │
│ Action: Initiates coin pack checkout            │
│ Destination: /science-lens/billing?type=coins   │
│ Requirements: 🔐 Authenticated                  │
│ Variant: gradient amber                         │
└─────────────────────────────────────────────────┘

┌─ [Purchase] (1,200 Coins - $9.99) ─────────────┐
│ Location: PricingPage.tsx:244 (second pack)    │
│ Action: Initiates coin pack checkout            │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘

┌─ [Purchase] (2,500 Coins - $19.99) ────────────┐
│ Location: PricingPage.tsx:244 (third pack)     │
│ Action: Initiates coin pack checkout            │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘

┌─ [Purchase] (6,500 Coins - $49.99) ────────────┐
│ Location: PricingPage.tsx:244 (fourth pack)    │
│ Action: Initiates coin pack checkout            │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘

┌─ [Purchase] (14,000 Coins - $99.99) ───────────┐
│ Location: PricingPage.tsx:244 (fifth pack)     │
│ Action: Initiates coin pack checkout            │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘
```

#### XP Boosts Tab
```
┌─ [Activate Boost] (2x XP - 30 min) ────────────┐
│ Location: PricingPage.tsx:287 (first boost)    │
│ Action: Purchases and activates XP boost        │
│ Requirements: 🔐 Authenticated                  │
│   - 💰 Coins required (amount varies)           │
│ Variant: gradient purple                        │
└─────────────────────────────────────────────────┘

┌─ [Activate Boost] (3x XP - 30 min) ────────────┐
│ Location: PricingPage.tsx:287 (second boost)   │
│ Action: Purchases and activates XP boost        │
│ Requirements: 🔐 Authenticated                  │
│   - 💰 Higher coin cost                        │
└─────────────────────────────────────────────────┘

┌─ [Activate Boost] (2x XP - 60 min) ────────────┐
│ Location: PricingPage.tsx:287 (third boost)    │
│ Action: Purchases and activates XP boost        │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘

┌─ [Activate Boost] (3x XP - 60 min) ────────────┐
│ Location: PricingPage.tsx:287 (fourth boost)   │
│ Action: Purchases and activates XP boost        │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘
```

---

### 🛒 Shop Page (/science-lens/shop)

#### Navigation
```
┌─ [← Back to Dashboard] ─────────────────────────┐
│ Location: Similar to Dashboard.tsx:131         │
│ Action: Navigates back to dashboard             │
│ Destination: /science-lens                      │
│ Requirements: 🔐 Authenticated                  │
│ Variant: ghost, icon: ArrowLeft                 │
└─────────────────────────────────────────────────┘
```

#### Shop Items (Dynamic Based on Type)

**Themes Category**
```
┌─ [Purchase] (Themes) ───────────────────────────┐
│ Action: Buys theme with coins                   │
│ Requirements: 🔐 Authenticated                  │
│   - 💰 Coin cost varies by theme                │
│   - 🎯 Level requirement (some themes)          │
│ State: ⚠️ Disabled if:                          │
│   - Insufficient coins                          │
│   - Level requirement not met                   │
│   - Already owned                               │
└─────────────────────────────────────────────────┘

┌─ [Equip] (Themes) ──────────────────────────────┐
│ Action: Equips theme for user                   │
│ Requirements: 🔐 Authenticated                  │
│   - 🏪 Must own theme                          │
│ State: 🔒 Hidden if not owned                   │
│ Text changes to "Equipped" when active          │
└─────────────────────────────────────────────────┘
```

**Avatars Category**
```
┌─ [Purchase] (Avatars) ──────────────────────────┐
│ Action: Buys avatar with coins                  │
│ Requirements: 🔐 Authenticated                  │
│   - 💰 Coin cost varies                         │
│   - 🎯 Level requirement                        │
│ State: Similar to themes                        │
└─────────────────────────────────────────────────┘

┌─ [Equip] (Avatars) ─────────────────────────────┐
│ Action: Equips avatar for user                  │
│ Requirements: 🔐 Authenticated                  │
│   - 🏪 Must own avatar                         │
└─────────────────────────────────────────────────┘
```

**Premium Items**
```
┌─ [Purchase] (Premium Items) ────────────────────┐
│ Action: Purchases premium-exclusive items       │
│ Requirements: 🔐 Authenticated                  │
│   - ⭐ Premium subscription required            │
│   - 💰 Coin cost OR free for premium users     │
│ State: ⚠️ Disabled if not premium               │
└─────────────────────────────────────────────────┘
```

**Free Items**
```
┌─ [Claim Free] (Free Items) ─────────────────────┐
│ Action: Claims free item (no cost)              │
│ Requirements: 🔐 Authenticated                  │
│   - 🎯 Level requirement may apply              │
│ State: ⚠️ Disabled if:                          │
│   - Level requirement not met                   │
│   - Already claimed                             │
└─────────────────────────────────────────────────┘
```

---

### 💳 Billing/Checkout Page (/science-lens/billing)

#### Navigation
```
┌─ [← Back to Pricing] ───────────────────────────┐
│ Location: BillingPage.tsx:168                   │
│ Action: Returns to pricing page                 │
│ Destination: /science-lens/pricing              │
│ Requirements: 🔐 Authenticated                  │
│ Visibility: 🔒 If coming from pricing           │
│ Variant: ghost, icon: ArrowLeft                 │
└─────────────────────────────────────────────────┘

┌─ [← Back to Shop] ─────────────────────────────┐
│ Location: BillingPage.tsx:168 (dynamic)        │
│ Action: Returns to shop page                    │
│ Destination: /science-lens/shop                 │
│ Requirements: 🔐 Authenticated                  │
│ Visibility: 🔒 If coming from shop              │
└─────────────────────────────────────────────────┘
```

#### Payment (Demo Mode)
```
┌─ [Run Demo (No Payment)] ───────────────────────┐
│ Location: DummyPaymentCard.tsx:151             │
│ Action: Processes demo payment (no real charge) │
│ Success:                                        │
│   - Shows processing animation                  │
│   - Simulates payment success                   │
│   - Redirects back to origin                    │
│ Requirements: 🔐 Authenticated                  │
│   - In checkout flow                            │
│ State: ⚠️ Disabled during processing            │
│ Notes: Demo mode only - real payments TBD       │
└─────────────────────────────────────────────────┘
```

---

## SPECIAL FEATURES

### 🎙️ Voice Reader (Text-to-Speech)
```
┌─ [▶️ Play] ─────────────────────────────────────┐
│ Location: VoiceReader.tsx:79                   │
│ Action: Starts text-to-speech playback          │
│ Requirements: 🔐 Authenticated                  │
│   - Browser supports SpeechSynthesis API        │
│ State: 🔒 Hidden when playing                   │
└─────────────────────────────────────────────────┘

┌─ [⏸️ Pause] ────────────────────────────────────┐
│ Location: VoiceReader.tsx:94                   │
│ Action: Pauses text-to-speech playback          │
│ Requirements: 🔐 Authenticated                  │
│   - Currently playing                           │
│ Visibility: 🔒 Only shown when playing          │
└─────────────────────────────────────────────────┘

┌─ [⏹️ Stop] ────────────────────────────────────┐
│ Location: VoiceReader.tsx:114                  │
│ Action: Stops text-to-speech playback           │
│ Requirements: 🔐 Authenticated                  │
│   - Currently playing or paused                 │
└─────────────────────────────────────────────────┘
```

### ⚙️ Settings Panel
```
┌─ [Toggle: Dark Mode] ───────────────────────────┐
│ Location: Settings.tsx:86 (pattern)            │
│ Action: Toggles dark/light theme                │
│ Requirements: 🔐 Authenticated                  │
│ Persistence: Saved to localStorage              │
└─────────────────────────────────────────────────┘

┌─ [Toggle: Sound Effects] ───────────────────────┐
│ Action: Enables/disables UI sound effects       │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘

┌─ [Toggle: Voice Auto-Play] ────────────────────┐
│ Action: Auto-plays voice on new messages        │
│ Requirements: 🔐 Authenticated                  │
└─────────────────────────────────────────────────┘
```

### 🛡️ Admin Toggle (Testing Only)
```
┌─ [Toggle Admin Mode] ───────────────────────────┐
│ Location: AdminToggle.tsx:251                  │
│ Action: Toggles admin privileges                │
│ Requirements: 🔐 Authenticated                  │
│   - 🛡️ Admin user only                         │
│ Purpose: Testing admin features                 │
│ Visibility: 🔒 Admin users only                 │
└─────────────────────────────────────────────────┘
```

---

## ERROR STATES

### Error Boundary
```
┌─ [Try Again] ───────────────────────────────────┐
│ Location: ErrorBoundary.tsx:96                 │
│ Action: Reloads the application                 │
│ Requirements: None (error recovery)             │
│ Visibility: 🔒 Only when error boundary catches │
│ Variant: outline                                │
└─────────────────────────────────────────────────┘
```

---

## BUTTON REQUIREMENTS MATRIX

### By Authentication Status

| Button | Unauthenticated | Authenticated | Notes |
|--------|----------------|---------------|-------|
| Landing page CTAs | ✅ Visible | ❌ Hidden (auto-nav) | Public access |
| Auth modal | ✅ Visible | ❌ Hidden | Only for logged-out users |
| Dashboard | ❌ Redirect | ✅ Visible | Protected route |
| Ask AI | ❌ Redirect | ✅ Visible | Protected route |
| Pricing | ❌ Redirect | ✅ Visible | Protected route |
| Shop | ❌ Redirect | ✅ Visible | Protected route |

### By Credit Status

| Button | Sufficient Credits | Insufficient Credits | Notes |
|--------|-------------------|---------------------|-------|
| Send Message | ✅ Enabled | ⚠️ Blocked by CreditGuard | Server-validated |
| Continue Learning | ✅ Enabled | ✅ Enabled | No credit cost |

### By Subscription Status

| Button | Free User | Premium User | Notes |
|--------|-----------|-------------|-------|
| Premium purchase | ✅ Enabled | ⚠️ Disabled (text: "Already Premium") | |
| Premium items | ⚠️ Disabled | ✅ Enabled | Shop items |

### By Level Requirements

| Button | Below Level | At/Above Level | Notes |
|--------|------------|---------------|-------|
| Advanced topics | ⚠️ Disabled | ✅ Enabled | In Learn page |
| Premium themes | ⚠️ Disabled | ✅ Enabled | In shop |

---

## BUTTON BEHAVIOR SPECIFICATIONS

### Loading States
- **Sign In/Sign Up**: Button shows spinner, disabled during API call
- **Send Message**: Icon button disabled during AI response
- **Purchase buttons**: Disabled during processing
- **Navigation buttons**: Never show loading state

### Disabled States
- **Empty input validation**: Message send button disabled when input empty
- **Insufficient funds**: Purchase buttons disabled when coins insufficient
- **Level requirements**: Buttons disabled until level requirement met
- **Already owned**: Purchase buttons disabled, show "Owned" or "Equipped"

### Hover States
- **Primary buttons**: Scale transform (hover:scale-105)
- **Icon buttons**: Color shift or brightness increase
- **Ghost buttons**: Background color appears

### Active/Pressed States
- **Toggle buttons**: Visual feedback when active
- **Equipped items**: Different variant/state shown

---

## ACCESSIBILITY CONSIDERATIONS

### Keyboard Navigation
- All buttons are focusable
- Enter/Space triggers button action
- Tab order follows visual layout

### Screen Reader Support
- Icon buttons have aria-labels
- Button text describes action
- Disabled state announced

### Visual Feedback
- Loading spinners for async actions
- Disabled state visually distinct
- Hover states for interactive elements

---

## ROUTE PROTECTION SUMMARY

### Public Routes
- `/` - Landing page
- No authentication required

### Protected Routes (Auto-Redirect if Unauthenticated)
- `/science-lens` - Dashboard
- `/science-lens/learning` - Learning page
- `/science-lens/ask` - Ask AI page
- `/science-lens/pricing` - Pricing page
- `/science-lens/shop` - Shop page
- `/science-lens/billing` - Checkout page

### Authentication Flow
1. Unauthenticated user accesses protected route
2. Redirected to `/` (landing page)
3. User clicks "Sign In" or "Get Started"
4. AuthModal opens
5. User completes sign in/sign up
6. On success: Modal closes → Auto-navigate to `/science-lens`

---

## BUTTON PLACEMENT CONSISTENCY

### Header/Top Bar Pattern
- Left: Logo/Brand
- Right: Settings (icon) | Sign Out (icon)

### Back Navigation Pattern
- Top-left: `<- Back to [Previous Page]`
- Consistent across all pages except landing

### Primary CTA Pattern
- Hero section: Large, prominent, center-aligned
- Variant: `cosmic` or `hero`
- Size: `xl` or large

### Secondary Action Pattern
- Variant: `outline` or `ghost`
- Smaller size
- Less prominent placement

---

## END OF DOCUMENT

**Total Unique Buttons Documented:** 50+
**Total Routes Mapped:** 8
**Requirement Categories:** 5 (Auth, Credits, Premium, Level, Ownership)

---

**Document Version:** 1.0
**Last Updated:** 2025-12-29
**Maintainer:** UX Team

*This document is a living reference. Update when buttons are added, modified, or removed.*
