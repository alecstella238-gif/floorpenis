local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlatformElevator"
screenGui.Parent = player:WaitForChild("PlayerGui") -- Standard parent for LocalPlayer

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.8, 0)
button.Text = "Elevator: OFF"
button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
button.Parent = screenGui

-- Variables for the Platform
local platform = nil
local isElevating = false
local elevationSpeed = 0.2 -- How many studs it rises per frame

-- Toggle Logic
button.MouseButton1Click:Connect(function()
	isElevating = not isElevating

	if isElevating then
		button.Text = "Elevator: ON"
		button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)

		-- Create the Platform
		platform = Instance.new("Part")
		platform.Size = Vector3.new(1000, 1, 1000)
		platform.Anchored = true
		platform.BrickColor = BrickColor.new("Bright blue")
		platform.Material = Enum.Material.Neon

		-- Position it slightly below the feet
		local feetPosition = rootPart.Position - Vector3.new(0, 3.5, 0)
		platform.Position = feetPosition
		platform.Parent = game.Workspace
	else
		button.Text = "Elevator: OFF"
		button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

		-- Clean up
		if platform then
			platform:Destroy()
			platform = nil
		end
	end
end)

-- Movement Loop
RunService.RenderStepped:Connect(function()
	if isElevating and platform then
		-- Increase the Y-axis (Height)
		platform.CFrame = platform.CFrame + Vector3.new(0, elevationSpeed, 0)
	end
end)
