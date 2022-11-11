local inspect = hs.inspect

local Audioswitch = {}

Audioswitch.name = "Audioswitch"
Audioswitch.version = "1.2"
Audioswitch.author = "Quin Marilyn <quin.marilyn05@gmail.com>"
Audioswitch.license = "MIT"
Audioswitch.homepage = "https://www.github.com/TheQuinbox/Audioswitch"

local synth = hs.speech.new()

local function speak(text)
	if hs.application.get("VoiceOver") ~= nil then
		hs.osascript.applescript("tell application \"VoiceOver\" to output \"" .. text .. "\"")
	else 
		synth:speak(text)
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

local function listOutputDevices()
	local outputDevices = hs.audiodevice.allOutputDevices()
	res = #outputDevices .. " output devices: "
	for i, device in pairs(outputDevices) do
		res = res .. device:name() .. ", "
	end
	-- Strip trailing commas, so it doesn't read all weird.
	res = res:sub(1, -3)
	speak(res)
end

local function listInputDevices()
	local inputDevices = hs.audiodevice.allInputDevices()
	res = #inputDevices .. " input devices: "
	for i, device in pairs(inputDevices) do
		res = res .. device:name() .. ", "
	end
	-- Strip trailing commas, so it doesn't read all weird.
	res = res:sub(1, -3)
	speak(res)
end

local prevOutputHotkey = hs.hotkey.new("ctrl-shift", "[", prevOutput)
local nextOutputHotkey = hs.hotkey.new("ctrl-shift", "]", nextOutput)
local prevInputHotkey = hs.hotkey.new("ctrl-cmd-shift", "[", prevInput)
local nextInputHotkey = hs.hotkey.new("ctrl-cmd-shift", "]", nextInput)
local muteInputHotkey = hs.hotkey.new("ctrl-shift", "m", muteInputDevice)
local listOutputHotkey = hs.hotkey.new("control-shift", "l", listOutputDevices)
local listInputHotkey = hs.hotkey.new("control-cmd-shift", "l", listInputDevices)

function Audioswitch.init()
end

function Audioswitch.start()
	prevOutputHotkey:enable()
	nextOutputHotkey:enable()
	prevInputHotkey:enable()
	nextInputHotkey:enable()
	muteInputHotkey:enable()
	listOutputHotkey:enable()
	listInputHotkey:enable()
end

function Audioswitch.stop()
	prevOutputHotkey:disable()
	nextOutputHotkey:disable()
	prevInputHotkey:disable()
	nextInputHotkey:disable()
	muteInputHotkey:disable()
	listOutputHotkey:disable()
	listInputHotkey:disable()
end

return Audioswitch
