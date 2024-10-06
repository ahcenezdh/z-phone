local phoneProp = 0
local phoneModel = `prop_amb_phone`

local function LoadAnimation(dict)
	lib.requestAnimDict(dict)
    RemoveAnimDict(dict)
end

local function CheckAnimLoop()
    CreateThread(function()
        while PhoneData.AnimationData.lib ~= nil and PhoneData.AnimationData.anim ~= nil do
            if not IsEntityPlayingAnim(cache.ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
                LoadAnimation(PhoneData.AnimationData.lib)
                TaskPlayAnim(cache.ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false, false, false)
            end
            Wait(500)
        end
    end)
end

function newPhoneProp()
	deletePhone()
    lib.requestModel(phoneModel)
	phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, true, true, false)

	local bone = GetPedBoneIndex(cache.ped, 28422)
    local x, y, z, xRot, yRot, zRot

	if phoneModel == `prop_cs_phone_01` then
        x, y, z = 0.0, 0.0, 0.0
        xRot, yRot, zRot = 50.0, 320.0, 50.0
	else
		x, y, z = 0.0, 0.0, 0.0
        xRot, yRot, zRot = 0.0, 0.0, 0.0
	end

    AttachEntityToEntity(phoneProp, cache.ped, bone, x, y, z, xRot, yRot, zRot, true, true, false, false, 2, true)
    SetModelAsNoLongerNeeded(phoneModel)
end

function deletePhone()
	if phoneProp ~= 0 then
		DeleteObject(phoneProp)
		phoneProp = 0
	end
end

function DoPhoneAnimation(anim)
    local AnimationLib = 'cellphone@'
    local AnimationStatus = anim
    if cache.vehicle ~= 0 then
        AnimationLib = 'anim@cellphone@in_car@ps'
    end
    LoadAnimation(AnimationLib)
    TaskPlayAnim(cache.ped, AnimationLib, AnimationStatus, 3.0, 3.0, -1, 50, 0, false, false, false)
    PhoneData.AnimationData.lib = AnimationLib
    PhoneData.AnimationData.anim = AnimationStatus
    CheckAnimLoop()
end