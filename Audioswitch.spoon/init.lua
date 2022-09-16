local inspect = hs.inspect

local Audioswitch = {}

Audioswitch.name = "Audioswitch"
Audioswitch.version = "1.1"
Audioswitch.author = "Quin Marilyn <quin.marilyn05@gmail.com>"
Audioswitch.license = "MIT"
Audioswitch.homepage = "https://www.github.com/TheQuinbox/Audioswitch"

local speakScript = [[
tell application "voiceover" to output "MESSAGE"
]]

local function speak(text)
    local script = speakScript:gsub("MESSAGE", function()
        return text
    end)
    success, _, output = hs.osascript.applescript(script)
    if not success then
        print(inspect(output))
    end
end

local function prevOutput()
    local currDevice = hs.audiodevice.defaultOutputDevice()
    local outputDevices = hs.audiodevice.allOutputDevices()
    local index = 0
    for i, device in pairs(outputDevices) do
        if device == currDevice then
            index = i
            break
        end
    end
    if index <= 1 then
        return
    end
    outputDevices[index - 1]:setDefaultOutputDevice()
    speak(outputDevices[index - 1]:name())
end

local function nextOutput()
    local currDevice = hs.audiodevice.defaultOutputDevice()
    local outputDevices = hs.audiodevice.allOutputDevices()
    local index = 0
    for i, device in pairs(outputDevices) do
        if device == currDevice then
            index = i
            break
        end
    end
    if index >= #outputDevices then
        return
    end
    outputDevices[index + 1]:setDefaultOutputDevice()
    speak(outputDevices[index + 1]:name())
end

local function prevInput()
    local currDevice = hs.audiodevice.defaultInputDevice()
    local inputDevices = hs.audiodevice.allInputDevices()
    local index = 0
    for i, device in pairs(inputDevices) do
        if device == currDevice then
            index = i
            break
        end
    end
    if index <= 1 then
        return
    end
    inputDevices[index - 1]:setDefaultInputDevice()
    speak(inputDevices[index - 1]:name())
end

local function nextInput()
    local currDevice = hs.audiodevice.defaultInputDevice()
    local inputDevices = hs.audiodevice.allInputDevices()
    local index = 0
    for i, device in pairs(inputDevices) do
        if device == currDevice then
            index = i
            break
        end
    end
    if index >= #inputDevices then
        return
    end
    inputDevices[index + 1]:setDefaultInputDevice()
    speak(inputDevices[index + 1]:name())
end

local function muteInputDevice()
    local device = hs.audiodevice.defaultInputDevice()
    local muted = device:muted()
    if muted then
        device:setInputMuted(false)
        speak("Unmuted")
    else
        device:setInputMuted(true)
        speak("Muted")
    end
end

local prevOutputHotkey = hs.hotkey.new("ctrl-shift", "[", prevOutput)
local nextOutputHotkey = hs.hotkey.new("ctrl-shift", "]", nextOutput)
local prevInputHotkey = hs.hotkey.new("ctrl-cmd-shift", "[", prevInput)
local nextInputHotkey = hs.hotkey.new("ctrl-cmd-shift", "]", nextInput)
local muteInputHotkey = hs.hotkey.new("ctrl-shift", "m", muteInputDevice)

function Audioswitch.init() end

function Audioswitch.start()
    prevOutputHotkey:enable()
    nextOutputHotkey:enable()
    prevInputHotkey:enable()
    nextInputHotkey:enable()
    muteInputHotkey:enable()
end

function Audioswitch.stop()
    prevOutputHotkey:disable()
    nextOutputHotkey:disable()
    prevInputHotkey:disable()
    nextInputHotkey:disable()
    muteInputHotkey:disable()
end

return Audioswitch
