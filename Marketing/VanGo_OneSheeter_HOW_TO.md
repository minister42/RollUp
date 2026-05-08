# VanGo One-Sheeter — How to Use

Hand-out for in-person conversations with food truck operators. **Front** sells the concept; **back** captures their feedback.

## The structural intent

The two sides are deliberately doing opposite jobs:

- **Front** — pitch mode. Loud, confident, illustrated. Tells them what we're building and what's in it for them. They read this *first* (without flipping the page) and form a mental model.
- **Back** — listening mode. Quieter visual register, lots of writing space, structured questions. Once they've turned the page, the body language shifts from "look at this" to "tell me what's missing."

Don't try to merge them onto one side — the page-flip is the cue that the conversation just changed gears.

## Print it

```bash
open Marketing/VanGo_OneSheeter.html
```

Then in Safari/Chrome:

1. **`⌘P`** to open the print dialog.
2. Set paper size to **US Letter**, margins to **None** (the file has its own margins).
3. Layout: **Two-sided** (long-edge binding) — this puts the back on the back of the front automatically.
4. **Save as PDF** if you're sending to a print shop, or print directly on a colour printer.

For best results: matte cardstock at ~32 lb / 120 gsm. The cobalt cards on the back side benefit from a heavier paper that doesn't curl.

## Customise before printing

Open the HTML in any text editor and edit these:

- **Return-to block** (bottom-right of back side): replace `[Your name]`, `[email@vango.app]`, `[(555) 555-5555]` with real contact info.
- **Pricing tiers**: if you change the $9.99 / $24.99 split before showing it to operators, edit the `.tier` blocks on the back.
- **Hero quote on the front**: the current quote is generic ("My regulars always find me. New customers..."). Once you've heard a *real* quote in your first few conversations, swap it in — it'll resonate harder.

## How to use it in conversation

Suggested 5-minute structure:

1. Open with the front side. *"Quick pitch — read the headline and the value props, then I'll shut up."* Let them read.
2. Walk through the three mockups. *"This is what your dashboard would look like. This is what customers would see. This is how you'd push a deal."* 30 seconds each.
3. Flip to the back. *"This is the part where I shut up and you talk. The pricing — does that feel right? Are we missing features? What's the deal-breaker?"*
4. Don't fill in the answers for them — let them write. People say more in writing than they would out loud.
5. Leave the sheet with them if they want time. Pick it up the next day.

## Capturing the feedback

Once you've collected a stack:

- Photograph the back of each sheet (one image per truck).
- Transcribe to a spreadsheet by question: Q1 column, Q2 column, etc. The pattern jumps out fast — what gets repeated, what only one person mentioned, where the price elasticity lives.
- Look for **what they DIDN'T write** as much as what they did. If nobody answers Q5 ("missing features"), that means we covered it. If everyone writes the same thing in Q6 ("won't use without X"), we have our priority.

## Future versions

Once you have ~10 responses, this document evolves:

- **v2**: replace the generic hero quote with a real one ("This would replace 4 different tools" — actual operator).
- **v3**: tighten the feature list to whatever Q4 said was must-have, drop the rest from the front side.
- **v4 (post-launch)**: stop being a feedback document, become a true sales sheet.

The questions on the back are deliberately open-ended for v1 because we don't know enough yet to ask multiple-choice. Once we do, the back will get more structured.

## Where the screenshots come from

The "screenshots" in the front-side mockups are **inline SVG/HTML drawn in the brand colours** — not real Xcode renders. That was a deliberate choice for v1: we're not shipping yet, the real screens are still moving, and a stylised mockup is more truthful than a photo of an in-progress build.

When the app is App-Store-ready, replace the three `.mockup .phone` blocks in `VanGo_OneSheeter.html` with `<img>` tags pointing to real device screenshots from `xcrun simctl io ...` or the App Store Connect screenshot tool.
