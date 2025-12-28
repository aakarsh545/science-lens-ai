# Science Lens AI - PRP Framework
## Project Requirement & Planning Protocol

**Version:** 1.0
**Last Updated:** 2025-12-25
**Project:** Science Lens AI - Interactive Science Education Platform

---

## TABLE OF CONTENTS

1. [Quick Reference](#quick-reference)
2. [Pre-Feature Checklist](#pre-feature-checklist)
3. [Feature Proposal Template](#feature-proposal-template)
4. [Architecture Guidelines](#architecture-guidelines)
5. [Implementation Protocol](#implementation-protocol)
6. [Database Schema Standards](#database-schema-standards)
7. [Component Structure Guidelines](#component-structure-guidelines)
8. [API Integration Patterns](#api-integration-patterns)
9. [Design System Compliance](#design-system-compliance)
10. [Testing Requirements](#testing-requirements)
11. [Post-Implementation Checklist](#post-implementation-checklist)
12. [Code Quality Standards](#code-quality-standards)
13. [Common Patterns Reference](#common-patterns-reference)

---

## QUICK REFERENCE

### Tech Stack Summary
- **Frontend:** React 18 + TypeScript + Vite
- **Styling:** Tailwind CSS + shadcn/ui + Cosmic Theme
- **3D Graphics:** Three.js + React Three Fiber
- **Backend:** Supabase (PostgreSQL + Auth + Edge Functions)
- **State Management:** TanStack Query + React Context
- **Animations:** Framer Motion
- **Routing:** React Router v6

### Key Directories
```
/science-lens-ai/
├── src/
│   ├── pages/           # Page-level components
│   ├── components/      # Reusable components
│   │   └── ui/         # shadcn/ui components
│   ├── layouts/        # Layout wrappers
│   ├── hooks/          # Custom React hooks
│   ├── services/       # External API integrations
│   ├── integrations/   # Third-party integrations (Supabase)
│   ├── lib/            # Utility functions
│   └── types/          # TypeScript type definitions
├── supabase/
│   ├── migrations/     # Database schema changes
│   └── functions/      # Edge Functions
├── proposals/          # Feature planning documents
└── mockups/           # Design mockups
```

### Feature Addition Command Chain
```bash
# 1. Create proposal document
touch proposals/FEATURE_NAME.md

# 2. Create database migration (if needed)
npx supabase migration new feature_name

# 3. Run development server
npm run dev

# 4. Push database changes (when ready)
npx supabase db push

# 5. Build for production
npm run build
```

---

## PRE-FEATURE CHECKLIST

**Before starting ANY new feature, complete this checklist:**

### ✅ Phase 1: Discovery & Research
- [ ] **Understand the Goal**
  - What problem does this feature solve?
  - Who is the target user?
  - How does it align with the platform's educational mission?

- [ ] **Review Existing Code**
  - Search for similar existing features (`/src` directory)
  - Check if functionality already exists in `/proposals`
  - Review related components that may need modification

- [ ] **Identify Dependencies**
  - What new npm packages are needed?
  - What external APIs will be used?
  - What database tables are required?

### ✅ Phase 2: Technical Planning
- [ ] **Database Impact Assessment**
  - Are new tables needed? → Create migration plan
  - Do existing tables need modification? → Plan backward-compatible changes
  - Are RLS policies required? → Define access rules
  - Will there be realtime subscriptions? → Plan subscription strategy

- [ ] **Frontend Architecture**
  - Will new pages be created? → Plan routing
  - Will new components be created? → Check `/components` for reusability
  - What state management is needed? → TanStack Query or Context
  - Are new custom hooks required? → Plan in `/hooks`

- [ ] **Backend Requirements**
  - Are Edge Functions needed? → Plan in `/supabase/functions`
  - What API endpoints are required?
  - What authentication checks are needed?

### ✅ Phase 3: Design & UX
- [ ] **Visual Design**
  - Review `/mockups` for existing designs
  - Create mockup if new UI is significant
  - Ensure Cosmic Theme compliance

- [ ] **User Flow**
  - Map user journey step-by-step
  - Identify error states and edge cases
  - Plan loading states and skeletons

### ✅ Phase 4: Documentation
- [ ] **Create Proposal Document**
  - Use [Feature Proposal Template](#feature-proposal-template)
  - Save to `/proposals/FEATURE_NAME.md`
  - Include all technical specifications

---

## FEATURE PROPOSAL TEMPLATE

**Every new feature MUST have a proposal document in `/proposals/`**

```markdown
# Feature: [Feature Name]

## Metadata
- **Status:** Proposed | In Progress | Completed | On Hold
- **Priority:** High | Medium | Low
- **Estimated Complexity:** Simple | Moderate | Complex
- **Created:** [Date]
- **Last Updated:** [Date]

---

## 1. OVERVIEW

### 1.1 Problem Statement
[Describe the user pain point or opportunity]

### 1.2 Proposed Solution
[High-level description of the solution]

### 1.3 Success Criteria
- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Measurable criterion 3]

---

## 2. TECHNICAL SPECIFICATIONS

### 2.1 Database Changes

**New Tables:**
```sql
-- Example: Table definition
CREATE TABLE table_name (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  -- Add other columns
);

-- RLS Policies
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own data"
  ON table_name FOR SELECT
  USING (auth.uid() = user_id);

-- Indexes
CREATE INDEX idx_table_name_user_id ON table_name(user_id);
```

**Existing Table Modifications:**
- [ ] Table: `table_name` - Change description
- [ ] Migration file: `timestamp_feature_name.sql`

### 2.2 Frontend Components

**New Pages:**
- [ ] `/route-path` → `src/pages/FeatureNamePage.tsx`

**New Components:**
- [ ] `FeatureName` → `src/components/FeatureName.tsx`
- [ ] `FeatureNameItem` → `src/components/FeatureNameItem.tsx`

**New Hooks:**
- [ ] `useFeatureName` → `src/hooks/useFeatureName.ts`

**Component Hierarchy:**
```
FeatureNamePage (Layout)
├── FeatureNameHeader
│   ├── Title
│   └── Actions
├── FeatureNameList
│   ├── FeatureNameItem (repeated)
│   └── FeatureNameEmpty
└── FeatureNameFooter
```

### 2.3 Backend Changes

**Edge Functions:**
- [ ] `function-name` → `supabase/functions/function-name/index.ts`

**API Endpoints:**
- [ ] `GET /api/feature` - Description
- [ ] `POST /api/feature` - Description
- [ ] `PUT /api/feature/:id` - Description
- [ ] `DELETE /api/feature/:id` - Description

### 2.4 External Services
- [ ] Service: [Name] - Purpose - API Key Location
- [ ] Service: [Name] - Purpose - API Key Location

### 2.5 New Dependencies
```json
{
  "dependencies": {
    "package-name": "^version"
  }
}
```

---

## 3. USER EXPERIENCE

### 3.1 User Flow
1. User navigates to [location]
2. User sees [description]
3. User interacts with [action]
4. System responds with [outcome]

### 3.2 UI Mockups
[Reference mockup files or embed images]
- `/mockups/feature-name-design.png`

### 3.3 Edge Cases & Error States
- [ ] No data available → Show empty state
- [ ] Network error → Show retry option
- [ ] Permission denied → Show access denied message
- [ ] Loading state → Show skeleton/progress

---

## 4. IMPLEMENTATION STEPS

### Phase 1: Database (Priority: High)
1. [ ] Create migration file
2. [ ] Write SQL schema
3. [ ] Define RLS policies
4. [ ] Create indexes
5. [ ] Test migration locally
6. [ ] Push to Supabase

### Phase 2: Backend (Priority: High)
1. [ ] Create Edge Functions
2. [ ] Implement authentication checks
3. [ ] Add error handling
4. [ ] Test with Supabase CLI

### Phase 3: Frontend - Core (Priority: High)
1. [ ] Create page component
2. [ ] Implement basic layout
3. [ ] Connect to Supabase
4. [ ] Display data
5. [ ] Add error handling

### Phase 4: Frontend - Polish (Priority: Medium)
1. [ ] Add animations (Framer Motion)
2. [ ] Apply Cosmic Theme
3. [ ] Add loading states
4. [ ] Add empty states
5. [ ] Responsive design

### Phase 5: Testing (Priority: High)
1. [ ] Manual testing
2. [ ] Edge case testing
3. [ ] Cross-browser testing
4. [ ] Mobile testing

---

## 5. TESTING CHECKLIST

### Functional Tests
- [ ] Core functionality works end-to-end
- [ ] All API calls succeed/fail appropriately
- [ ] Database operations work correctly
- [ ] Authentication/authorization works

### UI/UX Tests
- [ ] Design matches Cosmic Theme
- [ ] Responsive on mobile (375px+)
- [ ] Responsive on tablet (768px+)
- [ ] Responsive on desktop (1024px+)
- [ ] Loading states display correctly
- [ ] Error states are user-friendly
- [ ] Empty states provide guidance

### Integration Tests
- [ ] Works with existing features
- [ ] Doesn't break existing pages
- [ ] Navigation flow works
- [ ] State persists correctly

---

## 6. ROLLBACK PLAN

If this feature causes issues:
1. Database changes: [Rollback SQL or migration]
2. Frontend changes: [Git revert commit hash]
3. Backend changes: [Disable Edge Function]

---

## 7. POST-IMPLEMENTATION TASKS

- [ ] Update documentation
- [ ] Add inline code comments
- [ ] Create user-facing documentation (if applicable)
- [ ] Monitor for bugs/issues
- [ ] Gather user feedback

---

## 8. NOTES

[Additional notes, considerations, or constraints]
```

---

## ARCHITECTURE GUIDELINES

### Component Architecture Principles

#### 1. Component Types & Responsibilities

**Page Components** (`/src/pages/`)
- **Purpose:** Route-level components that assemble layouts and features
- **Naming:** `{FeatureName}Page.tsx`
- **Characteristics:**
  - Handle routing and navigation
  - Compose multiple child components
  - Manage page-level state
  - Define page metadata (title, description)

**Layout Components** (`/src/layouts/`)
- **Purpose:** Shared layout wrappers
- **Examples:** `AppLayout.tsx`, `AuthenticatedLayout.tsx`
- **Characteristics:**
  - Provide consistent structure
  - Handle navigation headers/footers
  - Manage authentication state

**Feature Components** (`/src/components/`)
- **Purpose:** Reusable feature-specific components
- **Naming:** `{FeatureName}.tsx` or `{FeatureName}{Element}.tsx`
- **Characteristics:**
  - Self-contained functionality
  - Accept props for configuration
  - Emit events via callbacks
  - No direct routing (use props/navigation)

**UI Components** (`/src/components/ui/`)
- **Purpose:** Low-level design system components (shadcn/ui)
- **Characteristics:**
  - Highly reusable
  - Minimal logic
  - Styled variants
  - Accessibility-compliant

#### 2. Component Structure Template

```tsx
/**
 * ComponentName - Brief description
 *
 * @param props - Component properties
 * @param props.propName - Description of prop
 * @returns JSX element
 */

// 1. Imports (grouped and sorted)
import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import { Button } from '@/components/ui/button';
import { useToast } from '@/hooks/use-toast';
import type { Database } from '@/integrations/supabase/types';

// 2. Type Definitions
type TableName = Database['public']['Tables']['table_name'];

interface ComponentNameProps {
  // Prop definitions with JSDoc
  /** Description of required prop */
  requiredProp: string;
  /** Description of optional prop */
  optionalProp?: number;
  /** Callback function */
  onAction?: (data: any) => void;
}

// 3. Component Definition
export function ComponentName({
  requiredProp,
  optionalProp,
  onAction
}: ComponentNameProps) {
  // 4. Hooks (order: router → query → state → refs → other)
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const { toast } = useToast();

  // 5. Queries (TanStack Query)
  const { data, isLoading, error } = useQuery({
    queryKey: ['feature-name', requiredProp],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('table_name')
        .select('*')
        .eq('id', requiredProp)
        .single();

      if (error) throw error;
      return data;
    },
  });

  // 6. Mutations
  const mutation = useMutation({
    mutationFn: async (variables: any) => {
      const { data, error } = await supabase
        .from('table_name')
        .insert(variables);

      if (error) throw error;
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['feature-name'] });
      toast({
        title: "Success",
        description: "Operation completed successfully",
      });
    },
    onError: (error) => {
      toast({
        title: "Error",
        description: error.message,
        variant: "destructive",
      });
    },
  });

  // 7. Local State
  const [localState, setLocalState] = useState(defaultValue);

  // 8. Derived State
  const derivedValue = useMemo(() => {
    return computeSomething(data);
  }, [data]);

  // 9. Effects
  useEffect(() => {
    // Side effect logic
    return () => {
      // Cleanup
    };
  }, [dependencies]);

  // 10. Event Handlers
  const handleClick = () => {
    // Handle click
  };

  // 11. Conditional Renders
  if (isLoading) {
    return <LoadingSkeleton />;
  }

  if (error) {
    return <ErrorMessage error={error} />;
  }

  // 12. Render
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
      className="cosmic-component-classes"
    >
      {/* JSX content */}
    </motion.div>
  );
}
```

### Data Layer Architecture

#### TanStack Query Patterns

**Fetching Data:**
```tsx
// Single item
const { data, isLoading, error } = useQuery({
  queryKey: ['resource', id],
  queryFn: async () => {
    const { data, error } = await supabase
      .from('table_name')
      .select('*')
      .eq('id', id)
      .single();

    if (error) throw error;
    return data;
  },
});

// List with pagination
const { data, isLoading, error } = useQuery({
  queryKey: ['resources', { page, limit }],
  queryFn: async () => {
    const { data, error } = await supabase
      .from('table_name')
      .select('*')
      .range((page - 1) * limit, page * limit - 1)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data;
  },
});

// Real-time subscription
useEffect(() => {
  const channel = supabase
    .channel('table_name_changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'table_name',
      },
      (payload) => {
        queryClient.invalidateQueries({ queryKey: ['resources'] });
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}, []);
```

**Mutating Data:**
```tsx
// Create
const createMutation = useMutation({
  mutationFn: async (newItem: CreateInput) => {
    const { data, error } = await supabase
      .from('table_name')
      .insert(newItem)
      .select()
      .single();

    if (error) throw error;
    return data;
  },
  onSuccess: (data) => {
    queryClient.invalidateQueries({ queryKey: ['resources'] });
    // Or optimistic update
    queryClient.setQueryData(['resource', data.id], data);
  },
});

// Update
const updateMutation = useMutation({
  mutationFn: async ({ id, updates }: { id: string; updates: UpdateInput }) => {
    const { data, error } = await supabase
      .from('table_name')
      .update(updates)
      .eq('id', id)
      .select()
      .single();

    if (error) throw error;
    return data;
  },
  onMutate: async (variables) => {
    // Cancel ongoing queries
    await queryClient.cancelQueries({ queryKey: ['resource', variables.id] });

    // Snapshot previous value
    const previousData = queryClient.getQueryData(['resource', variables.id]);

    // Optimistically update
    queryClient.setQueryData(['resource', variables.id], (old: any) => ({
      ...old,
      ...variables.updates,
    }));

    return { previousData };
  },
  onError: (err, variables, context) => {
    // Rollback on error
    queryClient.setQueryData(['resource', variables.id], context?.previousData);
  },
});

// Delete
const deleteMutation = useMutation({
  mutationFn: async (id: string) => {
    const { error } = await supabase
      .from('table_name')
      .delete()
      .eq('id', id);

    if (error) throw error;
  },
  onSuccess: () => {
    queryClient.invalidateQueries({ queryKey: ['resources'] });
  },
});
```

### Custom Hook Patterns

```tsx
// /src/hooks/useFeatureName.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import type { Database } from '@/integrations/supabase/types';

type TableName = Database['public']['Tables']['table_name'];

interface UseFeatureNameOptions {
  enabled?: boolean;
  refetchInterval?: number;
}

export function useFeatureName(
  id?: string,
  options: UseFeatureNameOptions = {}
) {
  const queryClient = useQueryClient();

  // Query
  const query = useQuery({
    queryKey: ['feature-name', id],
    queryFn: async () => {
      if (!id) throw new Error('ID is required');

      const { data, error } = await supabase
        .from('table_name')
        .select('*')
        .eq('id', id)
        .single();

      if (error) throw error;
      return data;
    },
    enabled: !!id && (options.enabled ?? true),
    refetchInterval: options.refetchInterval,
  });

  // Create mutation
  const create = useMutation({
    mutationFn: async (input: TableName['Insert']) => {
      const { data, error } = await supabase
        .from('table_name')
        .insert(input)
        .select()
        .single();

      if (error) throw error;
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['feature-name'] });
    },
  });

  // Update mutation
  const update = useMutation({
    mutationFn: async ({ id, updates }: { id: string; updates: TableName['Update'] }) => {
      const { data, error } = await supabase
        .from('table_name')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

      if (error) throw error;
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['feature-name'] });
    },
  });

  // Delete mutation
  const remove = useMutation({
    mutationFn: async (id: string) => {
      const { error } = await supabase
        .from('table_name')
        .delete()
        .eq('id', id);

      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['feature-name'] });
    },
  });

  return {
    // Query state
    data: query.data,
    isLoading: query.isLoading,
    error: query.error,
    isError: query.isError,
    // Mutations
    create: create.mutate,
    createAsync: create.mutateAsync,
    isCreating: create.isPending,
    update: update.mutate,
    updateAsync: update.mutateAsync,
    isUpdating: update.isPending,
    remove: remove.mutate,
    removeAsync: remove.mutateAsync,
    isRemoving: remove.isPending,
    // Utilities
    refetch: query.refetch,
  };
}
```

---

## IMPLEMENTATION PROTOCOL

### Step-by-Step Feature Addition

#### STEP 1: Create Proposal Document
```bash
# Create proposal in /proposals
touch proposals/feature-name.md
```

Fill out the complete [Feature Proposal Template](#feature-proposal-template).

#### STEP 2: Database Changes (if needed)
```bash
# Create new migration
npx supabase migration new feature_name

# Edit the generated file in supabase/migrations/
# vim supabase/migrations/TIMESTAMP_feature_name.sql
```

**Migration Template:**
```sql
-- Migration: feature_name
-- Description: Brief description of changes

-- Enable UUID extension if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create new table
CREATE TABLE IF NOT EXISTS feature_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  metadata JSONB DEFAULT '{}'::jsonb,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'archived')),
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_feature_items_user_id ON feature_items(user_id);
CREATE INDEX IF NOT EXISTS idx_feature_items_status ON feature_items(status);
CREATE INDEX IF NOT EXISTS idx_feature_items_created_at ON feature_items(created_at DESC);

-- Enable Row Level Security
ALTER TABLE feature_items ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view their own items"
  ON feature_items FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own items"
  ON feature_items FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own items"
  ON feature_items FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own items"
  ON feature_items FOR DELETE
  USING (auth.uid() = user_id);

-- Create updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_feature_items_updated_at
  BEFORE UPDATE ON feature_items
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Add comments for documentation
COMMENT ON TABLE feature_items IS 'Stores feature items for each user';
COMMENT ON COLUMN feature_items.metadata IS 'Flexible JSON storage for additional properties';
```

**Test migration locally:**
```bash
# Push to local Supabase
npx supabase db push

# Verify changes
npx supabase db reset
```

#### STEP 3: Update TypeScript Types
```bash
# Generate types from database
npx supabase gen types typescript --local > src/integrations/supabase/types.ts
```

#### STEP 4: Create Custom Hook (if reusable)
```bash
# Create hook file
touch src/hooks/useFeatureName.ts
```

Use the [Custom Hook Pattern](#custom-hook-patterns) template.

#### STEP 5: Create Components
```bash
# Create main component
touch src/components/FeatureName.tsx

# Create sub-components if needed
touch src/components/FeatureNameItem.tsx
touch src/components/FeatureNameList.tsx
```

Use the [Component Structure Template](#component-structure-template).

#### STEP 6: Create Page Component
```bash
# Create page
touch src/pages/FeatureNamePage.tsx
```

**Page Template:**
```tsx
/**
 * FeatureNamePage - Page description
 */

import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { ArrowLeft, Plus } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { AppLayout } from '@/layouts/AppLayout';
import { FeatureName } from '@/components/FeatureName';
import { useFeatureName } from '@/hooks/useFeatureName';

export function FeatureNamePage() {
  const navigate = useNavigate();
  const [selectedId, setSelectedId] = useState<string | null>(null);

  const { data, isLoading, error } = useFeatureName(selectedId, {
    enabled: !!selectedId,
  });

  return (
    <AppLayout>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        className="container mx-auto px-4 py-8"
      >
        {/* Header */}
        <div className="flex items-center justify-between mb-8">
          <div className="flex items-center gap-4">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => navigate(-1)}
            >
              <ArrowLeft className="h-5 w-5" />
            </Button>
            <div>
              <h1 className="text-4xl font-bold bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent">
                Feature Name
              </h1>
              <p className="text-muted-foreground mt-1">
                Brief description of the feature
              </p>
            </div>
          </div>

          <Button>
            <Plus className="h-4 w-4 mr-2" />
            Add New
          </Button>
        </div>

        {/* Main Content */}
        <FeatureName
          data={data}
          isLoading={isLoading}
          error={error}
          onSelect={setSelectedId}
        />
      </motion.div>
    </AppLayout>
  );
}
```

#### STEP 7: Add Routing
```tsx
// In src/App.tsx or router configuration
import { FeatureNamePage } from '@/pages/FeatureNamePage';

// Add route
<Route path="/feature-name" element={<FeatureNamePage />} />
```

#### STEP 8: Create Edge Function (if needed)
```bash
# Create edge function
npx supabase functions new function-name
```

**Edge Function Template:**
```typescript
// supabase/functions/function-name/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts';
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

serve(async (req) => {
  // Handle CORS
  if (req.method === 'OPTIONS') {
    return new Response('ok', {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers':
          'authorization, x-client-info, apikey, content-type',
      },
    });
  }

  try {
    // Create Supabase client with service role key
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    // Parse request
    const { method } = req;
    const url = new URL(req.url);
    const body = await req.json();

    // Route based on method
    switch (method) {
      case 'POST': {
        // Handle POST request
        const { data, error } = await supabase
          .from('table_name')
          .insert(body)
          .select()
          .single();

        if (error) throw error;

        return new Response(JSON.stringify(data), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      case 'GET': {
        // Handle GET request
        const id = url.searchParams.get('id');

        const { data, error } = await supabase
          .from('table_name')
          .select('*')
          .eq('id', id)
          .single();

        if (error) throw error;

        return new Response(JSON.stringify(data), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      default:
        return new Response('Method not allowed', { status: 405 });
    }
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});
```

#### STEP 9: Test Locally
```bash
# Start dev server
npm run dev

# Test edge functions
npx supabase functions serve
```

#### STEP 10: Deploy
```bash
# Push database changes to production
npx supabase db push

# Deploy edge functions
npx supabase functions deploy function-name

# Build and deploy frontend
npm run build
```

---

## DATABASE SCHEMA STANDARDS

### Naming Conventions

**Tables:**
- Use plural nouns: `users`, `courses`, `lessons`
- Use snake_case: `lesson_progress`, `user_achievements`
- Prefix with related entity if namespaced: `chat_messages`, `course_enrollments`

**Columns:**
- Primary keys: Always `id UUID PRIMARY KEY DEFAULT gen_random_uuid()`
- Foreign keys: `{entity}_id UUID REFERENCES {table}(id)`
- Timestamps: `created_at TIMESTAMPTZ DEFAULT NOW()`, `updated_at TIMESTAMPTZ DEFAULT NOW()`
- Booleans: Prefix with `is_`, `has_`, `can_`: `is_active`, `has_completed`
- Status columns: Use `status TEXT` with CHECK constraint

**Indexes:**
- Pattern: `idx_{table}_{column(s)}`
- Examples: `idx_lessons_course_id`, `idx_users_email`

**Policies:**
- Pattern: `"Users can {action} their own {resources}"`
- Examples: `"Users can view their own progress"`, `"Users can create their own achievements"`

### Column Types Reference

```sql
-- Identifiers
id              UUID PRIMARY KEY
user_id         UUID REFERENCES auth.users(id)
course_id       UUID REFERENCES courses(id)

-- Text fields
name            TEXT NOT NULL
title           TEXT NOT NULL
description     TEXT
email           TEXT UNIQUE
content         TEXT

-- Numeric fields
count           INTEGER DEFAULT 0
progress        INTEGER DEFAULT 0 CHECK (progress >= 0 AND progress <= 100)
xp_earned       INTEGER DEFAULT 0
order_index     INTEGER DEFAULT 0

-- Boolean fields
is_published    BOOLEAN DEFAULT false
is_required     BOOLEAN DEFAULT false
has_completed   BOOLEAN DEFAULT false

-- JSON fields
metadata        JSONB DEFAULT '{}'::jsonb
settings        JSONB DEFAULT '{}'::jsonb
content_data    JSONB

-- Timestamps
created_at      TIMESTAMPTZ DEFAULT NOW() NOT NULL
updated_at      TIMESTAMPTZ DEFAULT NOW() NOT NULL
completed_at    TIMESTAMPTZ
deleted_at      TIMESTAMPTZ

-- Enums (as TEXT with CHECK)
status          TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'archived'))
difficulty      TEXT CHECK (difficulty IN ('beginner', 'intermediate', 'advanced'))
```

### Relationship Patterns

**One-to-Many:**
```sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Index foreign key for performance
CREATE INDEX idx_posts_user_id ON posts(user_id);
```

**Many-to-Many:**
```sql
-- Junction table
CREATE TABLE course_enrollments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  course_id UUID REFERENCES courses(id) ON DELETE CASCADE NOT NULL,
  enrolled_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'completed', 'dropped')),

  -- Prevent duplicate enrollments
  UNIQUE(user_id, course_id)
);

-- Indexes for both sides
CREATE INDEX idx_course_enrollments_user_id ON course_enrollments(user_id);
CREATE INDEX idx_course_enrollments_course_id ON course_enrollments(course_id);
```

**Self-Referencing (Hierarchical):**
```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  parent_id UUID REFERENCES comments(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX idx_comments_parent_id ON comments(parent_id);
```

### RLS Policy Patterns

**Full Access for Owner:**
```sql
CREATE POLICY "Users can view own resources"
  ON table_name FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own resources"
  ON table_name FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own resources"
  ON table_name FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own resources"
  ON table_name FOR DELETE
  USING (auth.uid() = user_id);
```

**Public Read (with restrictions):**
```sql
CREATE POLICY "Anyone can view published resources"
  ON courses FOR SELECT
  USING (is_published = true);
```

**Role-Based Access:**
```sql
CREATE POLICY "Admins can do anything"
  ON table_name FOR ALL
  USING (
    auth.uid() IN (
      SELECT id FROM profiles WHERE role = 'admin'
    )
  );
```

### Trigger Patterns

**Updated Timestamp:**
```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_table_name_updated_at
  BEFORE UPDATE ON table_name
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
```

**Soft Delete:**
```sql
CREATE OR REPLACE FUNCTION soft_delete()
RETURNS TRIGGER AS $$
BEGIN
  NEW.deleted_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER soft_delete_table_name
  BEFORE DELETE ON table_name
  FOR EACH ROW
  EXECUTE FUNCTION soft_delete();

-- Update policy to filter out deleted
CREATE POLICY "Exclude deleted records"
  ON table_name FOR SELECT
  USING (deleted_at IS NULL);
```

---

## COMPONENT STRUCTURE GUIDELINES

### File Organization

**Component Directory Structure:**
```
src/components/
├── ui/                    # shadcn/ui base components
│   ├── button.tsx
│   ├── input.tsx
│   └── ...
├── FeatureName.tsx        # Main feature component
├── FeatureName.tsx        # Feature-specific components
├── FeatureNameList.tsx
├── FeatureNameItem.tsx
└── index.ts              # Export barrel
```

**When to Create a New Component:**
- ✅ Reusable UI element used in 2+ places
- ✅ Complex logic that can be isolated
- ✅ Distinct UI section with clear boundaries
- ❌ One-off use (keep in page component)
- ❌ Just wrapping HTML (use inline)

### Component Composition Patterns

**Compound Components:**
```tsx
// Usage
<Accordion>
  <AccordionItem value="item-1">
    <AccordionTrigger>Is it accessible?</AccordionTrigger>
    <AccordionContent>Yes. It adheres to the WAI-ARIA design pattern.</AccordionContent>
  </AccordionItem>
</Accordion>

// Implementation
interface AccordionContextValue {
  openItems: Set<string>;
  toggle: (value: string) => void;
}

const AccordionContext = createContext<AccordionContextValue | null>(null);

function Accordion({ children, defaultValue }: AccordionProps) {
  const [openItems, setOpenItems] = useState(new Set(defaultValue));

  const toggle = (value: string) => {
    const newOpen = new Set(openItems);
    if (newOpen.has(value)) {
      newOpen.delete(value);
    } else {
      newOpen.add(value);
    }
    setOpenItems(newOpen);
  };

  return (
    <AccordionContext.Provider value={{ openItems, toggle }}>
      <div className="accordion">{children}</div>
    </AccordionContext.Provider>
  );
}

Accordion.Item = AccordionItem;
Accordion.Trigger = AccordionTrigger;
Accordion.Content = AccordionContent;

export { Accordion };
```

**Render Props:**
```tsx
function DataSource({ render, children }: { render: (data: Data) => JSX.Element; children?: (data: Data) => JSX.Element }) {
  const { data } = useQuery({ queryKey: ['data'], queryFn: fetchData });

  // Support both render and children patterns
  return (render || children)(data);
}

// Usage
<DataSource render={(data) => <div>{data.name}</div>} />
// or
<DataSource>{(data) => <div>{data.name}</div>}</DataSource>
```

**Container/Presentational Pattern:**
```tsx
// Container component (logic)
export function FeatureNameContainer({ id }: { id: string }) {
  const { data, isLoading } = useFeatureName(id);

  if (isLoading) return <FeatureNameSkeleton />;

  return <FeatureNamePresentational data={data} />;
}

// Presentational component (UI)
export function FeatureNamePresentational({ data }: { data: FeatureData }) {
  return <div>{/* Pure UI rendering */}</div>;
}
```

### Props Patterns

**Flexible Render Prop:**
```tsx
interface ItemListProps {
  items: Item[];
  renderItem: (item: Item, index: number) => React.ReactNode;
  renderEmpty?: () => React.ReactNode;
}

function ItemList({ items, renderItem, renderEmpty }: ItemListProps) {
  if (items.length === 0 && renderEmpty) {
    return renderEmpty();
  }

  return (
    <ul>
      {items.map((item, index) => (
        <li key={item.id}>{renderItem(item, index)}</li>
      ))}
    </ul>
  );
}
```

**Polymorphic Component (as prop):**
```tsx
import { ReactElement, cloneElement } from 'react';

interface ButtonProps {
  as?: React.ElementType;
  children: React.ReactNode;
}

export function Button({ as: Component = 'button', children, ...props }: ButtonProps) {
  return <Component {...props}>{children}</Component>;
}

// Usage
<Button>Click me</Button>
<Button as="a" href="/link">Link</Button>
<Button as={Link} to="/route">Route</Button>
```

### State Management Patterns

**useReducer for Complex State:**
```tsx
type State = {
  items: Item[];
  selectedId: string | null;
  filter: FilterType;
  isLoading: boolean;
};

type Action =
  | { type: 'SET_ITEMS'; payload: Item[] }
  | { type: 'SELECT_ITEM'; payload: string }
  | { type: 'SET_FILTER'; payload: FilterType }
  | { type: 'SET_LOADING'; payload: boolean };

const initialState: State = {
  items: [],
  selectedId: null,
  filter: 'all',
  isLoading: false,
};

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case 'SET_ITEMS':
      return { ...state, items: action.payload };
    case 'SELECT_ITEM':
      return { ...state, selectedId: action.payload };
    case 'SET_FILTER':
      return { ...state, filter: action.payload };
    case 'SET_LOADING':
      return { ...state, isLoading: action.payload };
    default:
      return state;
  }
}

export function FeatureComponent() {
  const [state, dispatch] = useReducer(reducer, initialState);

  // Use state and dispatch
}
```

**Context for Shared State:**
```tsx
// FeatureContext.tsx
interface FeatureContextValue {
  state: State;
  actions: {
    addItem: (item: Item) => void;
    removeItem: (id: string) => void;
    updateItem: (id: string, updates: Partial<Item>) => void;
  };
}

const FeatureContext = createContext<FeatureContextValue | null>(null);

export function FeatureProvider({ children }: { children: React.ReactNode }) {
  const [state, setState] = useState<State>(initialState);

  const actions = useMemo(() => ({
    addItem: (item: Item) => setState(prev => ({ ...prev, items: [...prev.items, item] })),
    removeItem: (id: string) => setState(prev => ({ ...prev, items: prev.items.filter(i => i.id !== id) })),
    updateItem: (id: string, updates: Partial<Item>) => setState(prev => ({
      ...prev,
      items: prev.items.map(i => i.id === id ? { ...i, ...updates } : i)
    })),
  }), []);

  return (
    <FeatureContext.Provider value={{ state, actions }}>
      {children}
    </FeatureContext.Provider>
  );
}

export function useFeatureContext() {
  const context = useContext(FeatureContext);
  if (!context) {
    throw new Error('useFeatureContext must be used within FeatureProvider');
  }
  return context;
}
```

---

## API INTEGRATION PATTERNS

### Supabase Client Integration

**Direct Supabase Calls:**
```tsx
import { supabase } from '@/integrations/supabase/client';

// Single query
const { data, error } = await supabase
  .from('table_name')
  .select('*')
  .eq('id', id)
  .single();

// Insert
const { data, error } = await supabase
  .from('table_name')
  .insert({ name: 'New Item' })
  .select()
  .single();

// Update
const { data, error } = await supabase
  .from('table_name')
  .update({ status: 'active' })
  .eq('id', id)
  .select()
  .single();

// Delete
const { error } = await supabase
  .from('table_name')
  .delete()
  .eq('id', id);

// Complex query with joins
const { data, error } = await supabase
  .from('lessons')
  .select(`
    *,
    course:courses(*),
    progress:lesson_progress(*)
  `)
  .eq('course_id', courseId)
  .order('order_index');
```

### Edge Function Integration

**Calling Edge Functions:**
```tsx
import { supabase } from '@/integrations/supabase/client';

// Simple call
const { data, error } = await supabase.functions.invoke('function-name', {
  body: { param1: 'value1', param2: 'value2' },
});

// With authentication
const { data: { session } } = await supabase.auth.getSession();

const response = await fetch(`${import.meta.env.VITE_SUPABASE_URL}/functions/v1/function-name`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${session.access_token}`,
  },
  body: JSON.stringify({ param1: 'value1' }),
});

const result = await response.json();
```

### External API Integration

**Creating API Service:**
```tsx
// src/services/openai.ts
const API_KEY = import.meta.env.VITE_OPENAI_API_KEY;
const BASE_URL = 'https://api.openai.com/v1';

interface ChatMessage {
  role: 'system' | 'user' | 'assistant';
  content: string;
}

interface ChatCompletionParams {
  messages: ChatMessage[];
  model?: string;
  temperature?: number;
  maxTokens?: number;
}

export async function createChatCompletion({
  messages,
  model = 'gpt-4',
  temperature = 0.7,
  maxTokens = 1000,
}: ChatCompletionParams) {
  const response = await fetch(`${BASE_URL}/chat/completions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${API_KEY}`,
    },
    body: JSON.stringify({
      model,
      messages,
      temperature,
      max_tokens: maxTokens,
    }),
  });

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`OpenAI API error: ${error}`);
  }

  const data = await response.json();
  return data.choices[0].message.content;
}
```

**Using the Service:**
```tsx
import { createChatCompletion } from '@/services/openai';

const { mutate: sendMessage, isLoading } = useMutation({
  mutationFn: async (userMessage: string) => {
    const response = await createChatCompletion({
      messages: [
        { role: 'system', content: 'You are a helpful science tutor.' },
        { role: 'user', content: userMessage },
      ],
    });

    return response;
  },
});
```

### Real-time Subscriptions

**Database Changes Subscription:**
```tsx
useEffect(() => {
  const channel = supabase
    .channel('custom-channel')
    .on(
      'postgres_changes',
      {
        event: '*', // or 'INSERT', 'UPDATE', 'DELETE'
        schema: 'public',
        table: 'table_name',
        filter: `user_id=eq.${userId}`, // Optional filter
      },
      (payload) => {
        console.log('Change received!', payload);
        // Handle different event types
        switch (payload.eventType) {
          case 'INSERT':
            // Handle new record
            break;
          case 'UPDATE':
            // Handle update
            break;
          case 'DELETE':
            // Handle deletion
            break;
        }
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}, [userId]);
```

**Broadcast/Presence:**
```tsx
// Broadcast (for client-to-client communication)
useEffect(() => {
  const channel = supabase.channel('room-1');

  // Subscribe to broadcast
  channel
    .on('broadcast', { event: 'message' }, ({ payload }) => {
      console.log('Received:', payload);
    })
    .subscribe();

  // Send broadcast
  const sendBroadcast = (message: any) => {
    channel.send({
      type: 'broadcast',
      event: 'message',
      payload: message,
    });
  };

  return () => {
    supabase.removeChannel(channel);
  };
}, []);

// Presence (for online/offline tracking)
useEffect(() => {
  const channel = supabase.channel('online-users');

  channel
    .on('presence', { event: 'sync' }, () => {
      const state = channel.presenceState();
      console.log('Online users:', state);
    })
    .on('presence', { event: 'join' }, ({ key, newPresences }) => {
      console.log('User joined:', newPresences);
    })
    .on('presence', { event: 'leave' }, ({ key, leftPresences }) => {
      console.log('User left:', leftPresences);
    })
    .subscribe(async (status) => {
      if (status === 'SUBSCRIBED') {
        await channel.track({
          user_id: userId,
          online_at: new Date().toISOString(),
        });
      }
    });

  return () => {
    supabase.removeChannel(channel);
  };
}, [userId]);
```

---

## DESIGN SYSTEM COMPLIANCE

### Cosmic Theme Color Palette

**Primary Colors:**
```tsx
// Deep space background
--background: '222.2 84% 4.9%'
--foreground: '210 40% 98%'

// Card/surface
--card: '222.2 84% 4.9%'
--card-foreground: '210 40% 98%'

// Primary actions (electric blue)
--primary: '217.2 91.2% 59.8%'
--primary-foreground: '222.2 47.4% 11.2%'

// Secondary (purple)
--secondary: '217.2 32.6% 17.5%'
--secondary-foreground: '210 40% 98%'

// Accents
--accent: '217.2 32.6% 17.5%'
--accent-foreground: '210 40% 98%'

// Achievement (gold)
--gold: '45 100% 50%'
--gold-foreground: '0 0% 0%'

// Destructive (error)
--destructive: '0 84.2% 60.2%'
--destructive-foreground: '210 40% 98%'

// Semantic colors
--success: '142.1 76.2% 36.3%'
--warning: '32 95% 44%'
--info: '199 89% 48%'
```

**Usage in Tailwind:**
```tsx
// Background gradients
className="bg-gradient-to-br from-blue-950 via-purple-950 to-slate-950"

// Text gradients
className="bg-gradient-to-r from-blue-400 to-purple-500 bg-clip-text text-transparent"

// Glow effects
className="shadow-lg shadow-blue-500/50"
className="shadow-[0_0_20px_rgba(59,130,246,0.5)]"

// Borders
className="border border-blue-500/20"
className="border border-purple-500/30"
```

### Typography Standards

**Font Families:**
```tsx
// Headings
className="font-bold text-4xl"

// Body
className="text-base text-foreground/90"

// Small text
className="text-sm text-muted-foreground"

// Captions
className="text-xs text-muted-foreground/70"
```

**Font Sizes:**
- `text-xs`: Captions, labels (12px)
- `text-sm`: Small text, metadata (14px)
- `text-base`: Body text (16px)
- `text-lg`: Subheadings (18px)
- `text-xl`: Important headings (20px)
- `text-2xl`: Section headings (24px)
- `text-3xl`: Page titles (30px)
- `text-4xl`: Hero titles (36px+)

### Spacing Standards

**Padding:**
- `p-1` (4px): Tight spacing
- `p-2` (8px): Compact elements
- `p-4` (16px): Default padding
- `p-6` (24px): Sections
- `p-8` (32px): Large sections

**Margins:**
- `m-1` (4px): Tight spacing
- `m-2` (8px): Compact elements
- `m-4` (16px): Default margin
- `m-6` (24px): Section spacing
- `m-8` (32px): Large sections

**Gaps:**
- `gap-2` (8px): Related items
- `gap-4` (16px): Default gap
- `gap-6` (24px): Section separation
- `gap-8` (32px): Large separation

### Animation Standards (Framer Motion)

**Page Transitions:**
```tsx
<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  exit={{ opacity: 0, y: -20 }}
  transition={{ duration: 0.3 }}
>
  {/* Content */}
</motion.div>
```

**Stagger Children:**
```tsx
<motion.div
  variants={{
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1,
      },
    },
  }}
  initial="hidden"
  animate="visible"
>
  {items.map((item) => (
    <motion.div
      key={item.id}
      variants={{
        hidden: { opacity: 0, x: -20 },
        visible: { opacity: 1, x: 0 },
      }}
    >
      {item.content}
    </motion.div>
  ))}
</motion.div>
```

**Hover Effects:**
```tsx
<motion.div
  whileHover={{ scale: 1.05, boxShadow: '0 0 20px rgba(59,130,246,0.5)' }}
  whileTap={{ scale: 0.95 }}
  transition={{ type: 'spring', stiffness: 400, damping: 17 }}
>
  {/* Interactive content */}
</motion.div>
```

**Floating Animation:**
```tsx
<motion.div
  animate={{
    y: [0, -10, 0],
  }}
  transition={{
    duration: 2,
    repeat: Infinity,
    ease: 'easeInOut',
  }}
>
  {/* Floating element */}
</motion.div>
```

### Icon Usage

**Importing Icons:**
```tsx
import { ArrowLeft, Plus, Settings, User, Search } from 'lucide-react';
```

**Sizing:**
```tsx
<ArrowLeft className="h-4 w-4" />  // Small (16px)
<ArrowLeft className="h-5 w-5" />  // Default (20px)
<ArrowLeft className="h-6 w-6" />  // Medium (24px)
<ArrowLeft className="h-8 w-8" />  // Large (32px)
```

**With Text:**
```tsx
<Button>
  <Plus className="h-4 w-4 mr-2" />
  Add New
</Button>
```

### Component-Specific Guidelines

**Buttons:**
```tsx
// Primary action
<Button className="bg-blue-600 hover:bg-blue-700">
  Save Changes
</Button>

// Secondary action
<Button variant="secondary" className="bg-purple-600 hover:bg-purple-700">
  Learn More
</Button>

// Destructive action
<Button variant="destructive">
  Delete
</Button>

// Icon button
<Button variant="ghost" size="icon">
  <Settings className="h-4 w-4" />
</Button>
```

**Cards:**
```tsx
<div className="rounded-lg border border-blue-500/20 bg-blue-950/50 p-6 backdrop-blur">
  {/* Card content */}
</div>
```

**Inputs:**
```tsx
<Input
  className="border-blue-500/20 bg-blue-950/50 focus:border-blue-500"
  placeholder="Enter text..."
/>
```

**Loading States:**
```tsx
// Skeleton
<div className="space-y-3">
  <Skeleton className="h-4 w-full" />
  <Skeleton className="h-4 w-2/3" />
</Skeleton>
</div>

// Spinner
<div className="flex items-center justify-center">
  <Loader2 className="h-8 w-8 animate-spin text-blue-500" />
</div>
```

---

## TESTING REQUIREMENTS

### Manual Testing Checklist

**Functional Testing:**
- [ ] All user flows work correctly
- [ ] Forms validate input properly
- [ ] Error messages display correctly
- [ ] Success states show appropriate feedback
- [ ] Loading states display during async operations
- [ ] Empty states provide guidance

**Database Testing:**
- [ ] Data persists correctly
- [ ] RLS policies enforce access control
- [ ] Cascading deletes work as expected
- [ ] Indexes improve query performance
- [ ] Constraints prevent invalid data

**API Testing:**
- [ ] Edge Functions handle all HTTP methods
- [ ] Error responses have proper status codes
- [ ] Authentication is enforced
- [ ] Rate limiting works (if implemented)
- [ ] Response formats are consistent

### Browser Testing

**Supported Browsers:**
- [ ] Chrome/Edge (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Mobile Safari (iOS 14+)
- [ ] Chrome Mobile (Android 10+)

**Responsive Testing:**
- [ ] Mobile (375px - 640px)
- [ ] Tablet (641px - 1024px)
- [ ] Desktop (1025px+)

### Performance Testing

**Load Time:**
- [ ] Initial load < 3 seconds
- [ ] Time to interactive < 5 seconds
- [ ] First contentful paint < 1.5 seconds

**Runtime Performance:**
- [ ] No memory leaks
- [ ] Efficient re-renders (use React DevTools Profiler)
- [ ] Optimized images (use WebP format)
- [ ] Code splitting implemented (React.lazy)

### Accessibility Testing

**WCAG 2.1 Compliance:**
- [ ] Keyboard navigation works
- [ ] Screen reader compatibility
- [ ] Focus indicators visible
- [ ] Color contrast ratios ≥ 4.5:1
- [ ] ARIA labels on interactive elements
- [ ] Alt text on images

**Testing Tools:**
- Lighthouse (Chrome DevTools)
- axe DevTools
- WAVE browser extension

### Security Testing

**Authentication & Authorization:**
- [ ] Protected routes require auth
- [ ] RLS policies work correctly
- [ ] API keys not exposed to client
- [ ] SQL injection prevention
- [ ] XSS prevention

**Input Validation:**
- [ ] Server-side validation
- [ ] Client-side validation
- [ ] File upload restrictions
- [ ] Rate limiting on sensitive endpoints

---

## POST-IMPLEMENTATION CHECKLIST

### Code Review
- [ ] Code follows TypeScript best practices
- [ ] All `any` types removed or justified
- [ ] No console.log statements left in production code
- [ ] Error handling is comprehensive
- [ ] Comments explain complex logic
- [ ] Function and variable names are descriptive

### Documentation
- [ ] Proposal document updated with actual implementation details
- [ ] API documentation updated (if applicable)
- [ ] Database schema documented
- [ ] User-facing documentation created (if applicable)

### Performance Optimization
- [ ] Images optimized and compressed
- [ ] Unnecessary dependencies removed
- [ ] Bundle size analyzed and optimized
- [ ] Lazy loading implemented where appropriate
- [ ] Database queries optimized (EXPLAIN ANALYZE)

### Deployment
- [ ] Environment variables configured
- [ ] Database migrations pushed to production
- [ ] Edge Functions deployed
- [ ] Frontend build successful
- [ ] Production smoke tests pass

### Monitoring & Analytics
- [ ] Error tracking set up (Sentry, etc.)
- [ ] Analytics events added (if applicable)
- [ ] Performance monitoring configured
- [ ] Health checks implemented

---

## CODE QUALITY STANDARDS

### TypeScript Best Practices

**Type Definitions:**
```tsx
// ✅ Good: Explicit types
interface User {
  id: string;
  name: string;
  email: string;
  role: 'admin' | 'user' | 'guest';
}

function getUserById(id: string): Promise<User> {
  // Implementation
}

// ❌ Bad: Using any
function getUserById(id: any): any {
  // Implementation
}
```

**Type Guards:**
```tsx
// Type guard function
function isUser(data: unknown): data is User {
  return (
    typeof data === 'object' &&
    data !== null &&
    'id' in data &&
    'name' in data &&
    'email' in data
  );
}

// Usage
if (isUser(response.data)) {
  // TypeScript knows response.data is User
  console.log(response.data.name);
}
```

**Discriminated Unions:**
```tsx
type ApiResponse =
  | { status: 'success'; data: User }
  | { status: 'error'; error: string };

function handleResponse(response: ApiResponse) {
  switch (response.status) {
    case 'success':
      // TypeScript knows response.data exists
      return response.data.name;
    case 'error':
      // TypeScript knows response.error exists
      throw new Error(response.error);
  }
}
```

### React Best Practices

**Component Organization:**
```tsx
// ✅ Good: Organized, readable
export function UserProfile({ userId }: { userId: string }) {
  // 1. Hooks
  const { data, isLoading } = useUser(userId);

  // 2. Derived state
  const fullName = `${data?.firstName} ${data?.lastName}`;

  // 3. Event handlers
  const handleClick = () => {
    // Handle click
  };

  // 4. Effects
  useEffect(() => {
    // Side effect
  }, [userId]);

  // 5. Conditional renders
  if (isLoading) return <Skeleton />;

  // 6. Return
  return <div>{/* JSX */}</div>;
}

// ❌ Bad: Disorganized
export function UserProfile({ userId }: { userId: string }) {
  const [local, setLocal] = useState(0);

  useEffect(() => {
    console.log('effect');
  }, []);

  if (userId) {
    return <div>{userId}</div>;
  }

  const { data } = useUser(userId);

  return <div>{data?.name}</div>;
}
```

**Dependency Arrays:**
```tsx
// ✅ Good: All dependencies included
useEffect(() => {
  const subscription = subscribe(userId);
  return () => subscription.unsubscribe();
}, [userId]);

// ❌ Bad: Missing dependency (ESLint will catch this)
useEffect(() => {
  const subscription = subscribe(userId);
  return () => subscription.unsubscribe();
}, []); // userId should be in dependencies
```

**Custom Hooks:**
```tsx
// ✅ Good: Reusable custom hook
function useToggle(initialValue: boolean = false) {
  const [value, setValue] = useState(initialValue);
  const toggle = useCallback(() => setValue(v => !v), []);
  const setTrue = useCallback(() => setValue(true), []);
  const setFalse = useCallback(() => setValue(false), []);

  return { value, toggle, setTrue, setFalse, setValue };
}

// Usage
const { value: isOpen, toggle } = useToggle();
```

### Performance Best Practices

**Memoization:**
```tsx
// useMemo for expensive calculations
const sortedItems = useMemo(() => {
  return items.sort((a, b) => a.name.localeCompare(b.name));
}, [items]);

// useCallback for stable function references
const handleClick = useCallback(() => {
  navigate('/path');
}, [navigate]);

// React.memo for preventing unnecessary re-renders
const ExpensiveComponent = React.memo(({ data }: { data: Data }) => {
  return <div>{/* Complex rendering */}</div>;
});
```

**Code Splitting:**
```tsx
// Lazy load routes
const DashboardPage = lazy(() => import('@/pages/DashboardPage'));

// Suspense wrapper
<Suspense fallback={<PageSkeleton />}>
  <DashboardPage />
</Suspense>

// Lazy load components
const HeavyComponent = lazy(() => import('@/components/HeavyComponent'));
```

**Virtualization for Long Lists:**
```tsx
// Use react-window or react-virtuoso for lists with 100+ items
import { useVirtualizer } from '@tanstack/react-virtual';

function VirtualList({ items }: { items: Item[] }) {
  const parentRef = useRef<HTMLDivElement>(null);

  const virtualizer = useVirtualizer({
    count: items.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 50,
  });

  return (
    <div ref={parentRef} className="h-screen overflow-auto">
      <div style={{ height: `${virtualizer.getTotalSize()}px` }}>
        {virtualizer.getVirtualItems().map((virtualItem) => (
          <div
            key={virtualItem.key}
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              width: '100%',
              height: `${virtualItem.size}px`,
              transform: `translateY(${virtualItem.start}px)`,
            }}
          >
            {items[virtualItem.index].content}
          </div>
        ))}
      </div>
    </div>
  );
}
```

### Error Handling

**Error Boundaries:**
```tsx
class ErrorBoundary extends React.Component<
  { children: React.ReactNode; fallback?: React.ReactNode },
  { hasError: boolean; error?: Error }
> {
  constructor(props: any) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error) {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
    // Log to error tracking service
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback || <ErrorFallback error={this.state.error} />;
    }

    return this.props.children;
  }
}

function ErrorFallback({ error }: { error?: Error }) {
  return (
    <div className="flex items-center justify-center min-h-screen">
      <div className="text-center">
        <h1 className="text-2xl font-bold mb-4">Something went wrong</h1>
        <p className="text-muted-foreground mb-4">{error?.message}</p>
        <Button onClick={() => window.location.reload()}>
          Reload Page
        </Button>
      </div>
    </div>
  );
}
```

**Try-Catch in Async Operations:**
```tsx
const { data, error } = useQuery({
  queryKey: ['data'],
  queryFn: async () => {
    try {
      const response = await fetch('/api/data');
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const data = await response.json();
      return data;
    } catch (error) {
      // Log error for debugging
      console.error('Failed to fetch data:', error);
      // Re-throw to let TanStack Query handle it
      throw error;
    }
  },
  onError: (error) => {
    toast({
      title: "Error loading data",
      description: error.message,
      variant: "destructive",
    });
  },
});
```

---

## COMMON PATTERNS REFERENCE

### Form Handling

**React Hook Form + Zod:**
```tsx
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';

// Zod schema
const formSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  age: z.number().min(18, 'Must be at least 18'),
});

type FormData = z.infer<typeof formSchema>;

export function ProfileForm() {
  const form = useForm<FormData>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      name: '',
      email: '',
      age: 18,
    },
  });

  const mutation = useMutation({
    mutationFn: async (data: FormData) => {
      const response = await fetch('/api/profile', {
        method: 'POST',
        body: JSON.stringify(data),
      });
      return response.json();
    },
    onSuccess: () => {
      toast({ title: 'Profile updated!' });
    },
  });

  const onSubmit = (data: FormData) => {
    mutation.mutate(data);
  };

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
        <FormField
          control={form.control}
          name="name"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input type="email" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button type="submit" disabled={mutation.isPending}>
          {mutation.isPending ? 'Saving...' : 'Save'}
        </Button>
      </form>
    </Form>
  );
}
```

### Search & Filter

**Search with Debounce:**
```tsx
import { useDebouncedValue } from '@/hooks/useDebouncedValue';

export function UserSearch() {
  const [searchTerm, setSearchTerm] = useState('');
  const debouncedSearch = useDebouncedValue(searchTerm, 300);

  const { data } = useQuery({
    queryKey: ['users', debouncedSearch],
    queryFn: () => searchUsers(debouncedSearch),
    enabled: debouncedSearch.length >= 2,
  });

  return (
    <div>
      <Input
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        placeholder="Search users..."
      />
      {/* Render results */}
    </div>
  );
}

// Custom hook
function useDebouncedValue<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(handler);
  }, [value, delay]);

  return debouncedValue;
}
```

**Multi-Filter:**
```tsx
interface FilterState {
  category: string;
  difficulty: string;
  status: string;
}

export function FilteredList() {
  const [filters, setFilters] = useState<FilterState>({
    category: 'all',
    difficulty: 'all',
    status: 'all',
  });

  const { data } = useQuery({
    queryKey: ['items', filters],
    queryFn: () => fetchItems(filters),
  });

  const updateFilter = (key: keyof FilterState, value: string) => {
    setFilters(prev => ({ ...prev, [key]: value }));
  };

  const clearFilters = () => {
    setFilters({
      category: 'all',
      difficulty: 'all',
      status: 'all',
    });
  };

  return (
    <div>
      <div className="flex gap-2">
        <Select value={filters.category} onValueChange={(v) => updateFilter('category', v)}>
          {/* Category options */}
        </Select>
        <Select value={filters.difficulty} onValueChange={(v) => updateFilter('difficulty', v)}>
          {/* Difficulty options */}
        </Select>
        <Button variant="ghost" onClick={clearFilters}>
          Clear Filters
        </Button>
      </div>

      {/* Render filtered results */}
    </div>
  );
}
```

### Pagination

**Simple Pagination:**
```tsx
export function PaginatedList() {
  const [page, setPage] = useState(1);
  const limit = 20;

  const { data, isLoading } = useQuery({
    queryKey: ['items', page, limit],
    queryFn: () => fetchItems(page, limit),
  });

  const totalPages = Math.ceil((data?.total || 0) / limit);

  return (
    <div>
      {/* List items */}
      <div className="grid gap-2">
        {data?.items.map(item => (
          <div key={item.id}>{item.name}</div>
        ))}
      </div>

      {/* Pagination controls */}
      <div className="flex gap-2 mt-4">
        <Button
          onClick={() => setPage(p => Math.max(1, p - 1))}
          disabled={page === 1}
        >
          Previous
        </Button>

        <span className="flex items-center px-4">
          Page {page} of {totalPages}
        </span>

        <Button
          onClick={() => setPage(p => Math.min(totalPages, p + 1))}
          disabled={page === totalPages}
        >
          Next
        </Button>
      </div>
    </div>
  );
}
```

### Infinite Scroll

**Infinite Query:**
```tsx
import { useInfiniteQuery } from '@tanstack/react-query';

export function InfiniteList() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
    isLoading,
  } = useInfiniteQuery({
    queryKey: ['items'],
    queryFn: async ({ pageParam = 0 }) => {
      const response = await fetch(`/api/items?cursor=${pageParam}`);
      return response.json();
    },
    getNextPageParam: (lastPage) => lastPage.nextCursor,
  });

  const observerRef = useRef<IntersectionObserver>();

  const lastElementRef = useCallback(
    (node: HTMLDivElement | null) => {
      if (isLoading) return;
      if (observerRef.current) observerRef.current.disconnect();

      observerRef.current = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting && hasNextPage) {
          fetchNextPage();
        }
      });

      if (node) observerRef.current.observe(node);
    },
    [isLoading, hasNextPage, fetchNextPage]
  );

  const items = data?.pages.flatMap(page => page.items) || [];

  return (
    <div>
      {items.map((item, index) => (
        <div
          key={item.id}
          ref={index === items.length - 1 ? lastElementRef : null}
        >
          {item.name}
        </div>
      ))}

      {isFetchingNextPage && <div>Loading more...</div>}
    </div>
  );
}
```

### Modal/Dialog

**Dialog with State:**
```tsx
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/ui/dialog';

export function ItemDialog({ item }: { item: Item }) {
  const [open, setOpen] = useState(false);

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        <Button variant="ghost">View Details</Button>
      </DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{item.name}</DialogTitle>
          <DialogDescription>{item.description}</DialogDescription>
        </DialogHeader>
        <div className="mt-4">
          {/* Additional content */}
        </div>
      </DialogContent>
    </Dialog>
  );
}
```

---

## SUMMARY: FEATURE ADDITION WORKFLOW

When adding a new feature to Science Lens AI, follow this exact sequence:

### 1. Discovery Phase
- Read this PRP document completely
- Understand the problem and user needs
- Review existing codebase for similar patterns
- Identify all dependencies and requirements

### 2. Planning Phase
- Create proposal document in `/proposals/`
- Define database schema (if needed)
- Plan component architecture
- Design user flows and edge cases

### 3. Database Phase
- Create migration with `npx supabase migration new`
- Write SQL with proper RLS policies
- Test migration locally
- Generate TypeScript types

### 4. Backend Phase
- Create Edge Functions (if needed)
- Implement authentication/authorization
- Test API endpoints
- Set up real-time subscriptions (if needed)

### 5. Frontend Phase
- Create custom hooks for data fetching
- Build components following structure template
- Create page component with routing
- Implement error handling and loading states

### 6. Styling Phase
- Apply Cosmic Theme colors and typography
- Add Framer Motion animations
- Ensure responsive design
- Verify accessibility compliance

### 7. Testing Phase
- Manual functional testing
- Browser and device testing
- Performance optimization
- Security verification

### 8. Deployment Phase
- Push database changes to production
- Deploy Edge Functions
- Build and deploy frontend
- Monitor for issues

### 9. Documentation Phase
- Update proposal with final implementation
- Document API changes
- Update code comments
- Create user-facing documentation (if needed)

---

## APPENDIX: Quick Reference Commands

```bash
# Supabase
npx supabase migration new feature_name      # Create migration
npx supabase db push                         # Push to local DB
npx supabase db reset                        # Reset local DB
npx supabase gen types typescript --local    # Generate types
npx supabase functions deploy name           # Deploy function

# Development
npm run dev                                  # Start dev server
npm run build                                # Build for production
npm run preview                              # Preview production build

# Git
git add .
git commit -m "feat: add feature name"
git push
```

---

**END OF PRP FRAMEWORK**

This document should be referenced before starting any new feature. Keep it updated as the project evolves.
