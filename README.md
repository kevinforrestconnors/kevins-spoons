# kevins-spoons
hammerspoon scripts :)

## perky-duck-remap.lua

I was working on a braille course that recommended that I use the Perky Duck application as a braille writer.  I disliked the standard key maps:

* Dot 1: `f`
* Dot 2: `d`
* Dot 3: `s`
* Dot 4: `j`
* Dot 5: `k`
* Dot 6: `l`

I mostly disliked this key map because it's doesn't spatially represent the dots in the same way that a (mostly) vertical (e.g. `q a z`) mapping would.  Unfortunately, Perky Duck is a pretty shite software and doesn't allow you to remap these keys - there's actually a setting for it... which doesn't work :)

This script remaps those keys to:

* Dot 1: `q`
* Dot 2: `a`
* Dot 3: `z`
* Dot 4: `[`
* Dot 5: `;`
* Dot 6: `.`

This is, of course, configurable to your desires, but note: *You cannot remap the a key to itself with hammerspoon (a bug, in my opinion), so you can't do something like `edc okm` because it intercepts the default map.*  Unfortunately, you can't leave it unmapped, or it won't work correctly with multiple concurrent inputs.

This script can be adapted to fit any program which has different behavior for multiple simultaneous keypresses.

### Key Queue

In order to make this remapping work, I had to program in a queue of keys to be sent when a key is released.  This means that instead of multi-key commands being sent based on a time interval, all the pressed-down keys are sent when a key is released.

The unintentional effect of this is that the user experience of typing braille in this particular case is far more pleasurable - no longer do I feel rushed when I am unsure which keys to press together, and it doesn't make a difference when typing quickly.
