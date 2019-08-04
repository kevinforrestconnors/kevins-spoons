function toggleBrailleKeyboardClosure()

  local keyboardStates = {normal = "Normal", braille = "Braille Transcription"}
  local keyboardState = keyboardStates.normal
  local dots = {}
  local mappings = {}

  -- hammerspoon bug: can't map key to same key, so we need to choose a vertical
  -- line that doesn't intercept Perky Duck's sdf jkl mapping
  -- you can choose any keys as long as they aren't s,d,f,j,k,l
  mappings["q"] = "f" -- dot 1
  mappings["a"] = "d" -- dot 2
  mappings["z"] = "s" -- dot 3
  mappings["["] = "j" -- dot 4
  mappings[";"] = "k" -- dot 5
  mappings["."] = "l" -- dot 6

  local keyQueue = {}

  function queueKeypress(key)
    table.insert(keyQueue, key)
  end

  function perkyDuckKeydown(modifiers, character)
      local event = require("hs.eventtap").event
      event.newKeyEvent(modifiers, string.lower(character), true):post() -- keydown
  end

  function perkyDuckKeyup(modifiers, character)
      local event = require("hs.eventtap").event
      event.newKeyEvent(modifiers, string.lower(character), false):post() -- keyup
  end

  function clearQueueAndSendKeys()
    for _, key in ipairs(keyQueue) do
      perkyDuckKeydown({}, key)
    end
    for _, key in ipairs(keyQueue) do
      perkyDuckKeyup({}, key)
    end
    keyQueue = {}
  end

  for key, remap in pairs(mappings) do -- set up keys
    table.insert(dots, hs.hotkey.new({}, key, function() queueKeypress(remap) end, function() clearQueueAndSendKeys() end, nil))
  end

  function disableKeys()
    for k, _ in pairs(dots) do dots[k]:disable() end
  end

  function enableKeys()
    for k, _ in pairs(dots) do dots[k]:enable() end
  end

  return function()
    hs.alert.show(keyboardState .. " keyboard state disabled.")
    if keyboardState == keyboardStates.normal then
      keyboardState = keyboardStates.braille
      enableKeys()
    else
      keyboardState = keyboardStates.normal
      disableKeys()
    end
    hs.alert.show(keyboardState .. " keyboard state activated.")
  end

end

hs.hotkey.bind({"cmd", "ctrl", "alt"}, "a", toggleBrailleKeyboardClosure())
