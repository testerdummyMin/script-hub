local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local function setupEars(character)
	local earsAccessory = character:WaitForChild("Accessory (Webcore Cursor Cat Ears (White))", 15)
	if not earsAccessory then
		return
	end

	local handle = earsAccessory:WaitForChild("Handle", 5)
	if not handle then
		return
	end

	local head = character:WaitForChild("Head", 5)
	if not head then
		return
	end

	local weld = handle:FindFirstChildOfClass("Weld")
	if not weld then
		for _, child in ipairs(handle:GetChildren()) do
			if child:IsA("WeldConstraint") then
				child:Destroy()
			end
		end
		weld = Instance.new("Weld")
		weld.Part0 = head
		weld.Part1 = handle
		weld.C0 = head.CFrame:Inverse() * handle.CFrame
		weld.Parent = handle
	end

	print("i love cat - Min")

	local originalC0 = weld.C0
	local rot1 = originalC0 * CFrame.Angles(0, 0, math.rad(4))
	local rot2 = originalC0 * CFrame.Angles(0, 0, math.rad(-4))

	local tweenInfo = TweenInfo.new(
		0.5,
		Enum.EasingStyle.Cubic,
		Enum.EasingDirection.InOut
	)

	task.spawn(function()
		while earsAccessory.Parent and handle.Parent do
			local tween1 = TweenService:Create(weld, tweenInfo, {C0 = rot1})
			tween1:Play()
			tween1.Completed:Wait()

			local tween2 = TweenService:Create(weld, tweenInfo, {C0 = rot2})
			tween2:Play()
			tween2.Completed:Wait()
		end
	end)
end

local function setupTail(character)
	local tailAccessory = character:WaitForChild("Accessory (Cursor tailAccessory)", 15)
	if not tailAccessory then
		return
	end

	local handle = tailAccessory:WaitForChild("Handle", 5)
	if not handle then
		return
	end

	local rootPart = character:FindFirstChild("Torso") or character:FindFirstChild("LowerTorso") or character:WaitForChild("HumanoidRootPart", 5)
	if not rootPart then
		return
	end

	local weld = handle:FindFirstChildOfClass("Weld")
	if not weld then
		for _, child in ipairs(handle:GetChildren()) do
			if child:IsA("WeldConstraint") then
				child:Destroy()
			end
		end
		weld = Instance.new("Weld")
		weld.Part0 = rootPart
		weld.Part1 = handle
		weld.C0 = rootPart.CFrame:Inverse() * handle.CFrame
		weld.Parent = handle
	end

	task.wait(0.25)

	local originalC0 = weld.C0
	local rot1 = originalC0 * CFrame.Angles(math.rad(4), 0, 0)
	local rot2 = originalC0 * CFrame.Angles(math.rad(-4), 0, 0)

	local tweenInfo = TweenInfo.new(
		0.5,
		Enum.EasingStyle.Cubic,
		Enum.EasingDirection.InOut
	)

	task.spawn(function()
		while tailAccessory.Parent and handle.Parent do
			local tween1 = TweenService:Create(weld, tweenInfo, {C0 = rot1})
			tween1:Play()
			tween1.Completed:Wait()

			local tween2 = TweenService:Create(weld, tweenInfo, {C0 = rot2})
			tween2:Play()
			tween2.Completed:Wait()
		end
	end)
end

local function onCharacterAdded(character)
	setupEars(character)
	setupTail(character)
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
	onCharacterAdded(player.Character)
end
