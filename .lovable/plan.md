

## Fix Build Errors

Two fixes to restore the build:

### Fix 1: Remove merge conflict markers in `AdminToggle.tsx`
- **Line 37**: Delete `<<<<<<< HEAD` — the code below it (edge function calls) is the correct implementation
- **Line 73**: Delete `<<<<<<< HEAD` — same situation

### Fix 2: Fix `fetch()` syntax in `grok-hint/index.ts`
- **Line 76**: Change `});` to `})` — closes `JSON.stringify()` 
- Add `);` on a new line after — closes the `fetch()` call

So lines 76-77 become:
```
      })
    );
```

No other changes. No UI, functionality, or environment variable modifications.

