-- [hs.hotkey.bind](http://www.hammerspoon.org/docs/hs.hotkey.html#bind)

local function keyCode(key)
  return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

hs.hotkey.bind({"ctrl", "shift", "cmd"}, 'h', 'home', keyCode('home'), nil)
hs.hotkey.bind({"ctrl", "shift", "cmd"}, 'j', 'pagedown', keyCode('pagedown'), nil)
hs.hotkey.bind({"ctrl", "shift", "cmd"}, 'k', 'pageup', keyCode('pageup'), nil)
hs.hotkey.bind({"ctrl", "shift", "cmd"}, 'l', 'end', keyCode('end'), nil)

hs.hotkey.bind({"ctrl", "shift"}, 'h', keyCode('left'), keyCode('left'), nil)
hs.hotkey.bind({"ctrl", "shift"}, 'j', keyCode('down'), keyCode('down'), nil)
hs.hotkey.bind({"ctrl", "shift"}, 'k', keyCode('up'), keyCode('up'), nil)
hs.hotkey.bind({"ctrl", "shift"}, 'l', keyCode('right'), keyCode('right'), nil)