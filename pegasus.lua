-- PEGASUS HUB | yoruka.id
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

local GUI = Instance.new("ScreenGui")
GUI.Name = "PegasusHub"
GUI.ResetOnSpawn = false
GUI.DisplayOrder = 999
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUI.Parent = LP.PlayerGui

local BG    = Color3.fromRGB(28,28,30)
local CARD  = Color3.fromRGB(42,42,46)
local WHITE = Color3.fromRGB(255,255,255)
local GRAY  = Color3.fromRGB(100,100,110)
local GREEN = Color3.fromRGB(76,217,100)
local DARKBG= Color3.fromRGB(18,18,20)
local BLUE  = Color3.fromRGB(88,101,242)

local LOGO  = "rbxassetid://1000106344" -- foto warrior dari user

local function corner(p,r) local c=Instance.new("UICorner",p);c.CornerRadius=UDim.new(0,r or 12) end
local function mkStroke(p,c,t) local s=Instance.new("UIStroke",p);s.Color=c;s.Thickness=t or 1 end

-- ========================
-- MINI BADGE (foto bulat)
-- ========================
local Mini = Instance.new("Frame")
Mini.Size = UDim2.new(0,68,0,68)
Mini.Position = UDim2.new(0,20,0.5,-34)
Mini.BackgroundColor3 = Color3.fromRGB(10,10,12)
Mini.BorderSizePixel = 0
Mini.Visible = false
Mini.ZIndex = 999
Mini.Parent = GUI
corner(Mini,34)
mkStroke(Mini,Color3.fromRGB(90,90,100),2)

local MiniImg = Instance.new("ImageLabel")
MiniImg.Size = UDim2.new(1,0,1,0)
MiniImg.BackgroundTransparency = 1
MiniImg.Image = LOGO
MiniImg.ScaleType = Enum.ScaleType.Crop
MiniImg.ZIndex = 1000
MiniImg.Parent = Mini
corner(MiniImg,34)

local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(1,0,1,0)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = ""
MiniBtn.ZIndex = 1001
MiniBtn.Parent = Mini

-- ========================
-- MAIN PANEL
-- ========================
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0,340,0,590)
Panel.Position = UDim2.new(0.5,-170,0.5,-295)
Panel.BackgroundColor3 = BG
Panel.BorderSizePixel = 0
Panel.ZIndex = 100
Panel.Parent = GUI
corner(Panel,16)
mkStroke(Panel,Color3.fromRGB(55,55,60))

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,56)
Header.BackgroundColor3 = CARD
Header.BorderSizePixel = 0
Header.ZIndex = 101
Header.Parent = Panel
corner(Header,16)

-- Logo bulat foto warrior
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0,40,0,40)
LogoFrame.Position = UDim2.new(0,10,0.5,-20)
LogoFrame.BackgroundColor3 = Color3.fromRGB(10,10,12)
LogoFrame.BorderSizePixel = 0
LogoFrame.ZIndex = 102
LogoFrame.Parent = Header
corner(LogoFrame,20)
mkStroke(LogoFrame,Color3.fromRGB(90,90,100),1.5)

local LogoImg = Instance.new("ImageLabel")
LogoImg.Size = UDim2.new(1,0,1,0)
LogoImg.BackgroundTransparency = 1
LogoImg.Image = LOGO
LogoImg.ScaleType = Enum.ScaleType.Crop
LogoImg.ZIndex = 103
LogoImg.Parent = LogoFrame
corner(LogoImg,20)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1,-110,0,22)
TitleLbl.Position = UDim2.new(0,58,0,8)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "PEGASUS HUB"
TitleLbl.TextColor3 = WHITE
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextSize = 15
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.ZIndex = 102
TitleLbl.Parent = Header

local SubLbl = Instance.new("TextLabel")
SubLbl.Size = UDim2.new(1,-110,0,14)
SubLbl.Position = UDim2.new(0,58,0,30)
SubLbl.BackgroundTransparency = 1
SubLbl.Text = "created by rexx"
SubLbl.TextColor3 = GRAY
SubLbl.Font = Enum.Font.Gotham
SubLbl.TextSize = 11
SubLbl.TextXAlignment = Enum.TextXAlignment.Left
SubLbl.ZIndex = 102
SubLbl.Parent = Header

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,28,0,28)
MinBtn.Position = UDim2.new(1,-38,0.5,-14)
MinBtn.BackgroundColor3 = Color3.fromRGB(55,55,60)
MinBtn.Text = "-"
MinBtn.TextColor3 = WHITE
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 102
MinBtn.Parent = Header
corner(MinBtn,14)

-- Minimize / Open
MinBtn.MouseButton1Click:Connect(function()
    Panel.Visible = false
    Mini.Visible = true
end)
MiniBtn.MouseButton1Click:Connect(function()
    Mini.Visible = false
    Panel.Visible = true
end)

local HDivider = Instance.new("Frame")
HDivider.Size = UDim2.new(1,-28,0,1)
HDivider.Position = UDim2.new(0,14,0,56)
HDivider.BackgroundColor3 = Color3.fromRGB(55,55,60)
HDivider.BorderSizePixel = 0
HDivider.Parent = Panel

-- TABS
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1,-28,0,32)
TabBar.Position = UDim2.new(0,14,0,62)
TabBar.BackgroundTransparency = 1
TabBar.Parent = Panel
local TL = Instance.new("UIListLayout",TabBar)
TL.FillDirection = Enum.FillDirection.Horizontal
TL.Padding = UDim.new(0,6)

local Pages = {}
local TabBtns = {}
local tabList = {"MAIN","ESP","TROLL"}

for i,name in ipairs(tabList) do
    local tb = Instance.new("TextButton")
    tb.Size = UDim2.new(1/3,-5,1,0)
    tb.BackgroundColor3 = i==1 and Color3.fromRGB(80,80,88) or BG
    tb.Text = name
    tb.TextColor3 = i==1 and WHITE or GRAY
    tb.Font = Enum.Font.GothamBold
    tb.TextSize = 11
    tb.BorderSizePixel = 0
    tb.Parent = TabBar
    corner(tb,16)
    mkStroke(tb,Color3.fromRGB(55,55,60))
    TabBtns[i] = tb

    local pg = Instance.new("ScrollingFrame")
    pg.Size = UDim2.new(1,-28,1,-102)
    pg.Position = UDim2.new(0,14,0,100)
    pg.BackgroundTransparency = 1
    pg.ScrollBarThickness = 2
    pg.ScrollBarImageColor3 = GRAY
    pg.Visible = i==1
    pg.BorderSizePixel = 0
    pg.Parent = Panel
    Pages[i] = pg

    local pl = Instance.new("UIListLayout",pg)
    pl.Padding = UDim.new(0,6)
    pl.SortOrder = Enum.SortOrder.LayoutOrder

    tb.MouseButton1Click:Connect(function()
        for j,p in ipairs(Pages) do
            p.Visible = j==i
            TabBtns[j].BackgroundColor3 = j==i and Color3.fromRGB(80,80,88) or BG
            TabBtns[j].TextColor3 = j==i and WHITE or GRAY
        end
    end)
end

-- ========================
-- HELPERS
-- ========================
local states = {}

local function secLabel(parent,text,order)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,18)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = GRAY
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.LayoutOrder = order
    l.Parent = parent
end

local function makeCard(parent,order,h)
    local c = Instance.new("Frame")
    c.Size = UDim2.new(1,0,0,h or 46)
    c.BackgroundColor3 = CARD
    c.BorderSizePixel = 0
    c.LayoutOrder = order
    c.Parent = parent
    corner(c,12)
    return c
end

local function makeToggle(parent,label,order,callback)
    local c = makeCard(parent,order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,-60,1,0)
    lbl.Position = UDim2.new(0,14,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = WHITE
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local track = Instance.new("TextButton")
    track.Size = UDim2.new(0,44,0,26)
    track.Position = UDim2.new(1,-54,0.5,-13)
    track.BackgroundColor3 = Color3.fromRGB(55,55,60)
    track.Text = ""
    track.BorderSizePixel = 0
    track.Parent = c
    corner(track,13)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,20,0,20)
    knob.Position = UDim2.new(0,3,0.5,-10)
    knob.BackgroundColor3 = WHITE
    knob.BorderSizePixel = 0
    knob.Parent = track
    corner(knob,10)

    states[label] = false
    track.MouseButton1Click:Connect(function()
        states[label] = not states[label]
        local on = states[label]
        TweenService:Create(track,TweenInfo.new(0.15),{BackgroundColor3=on and GREEN or Color3.fromRGB(55,55,60)}):Play()
        TweenService:Create(knob,TweenInfo.new(0.15),{Position=on and UDim2.new(0,21,0.5,-10) or UDim2.new(0,3,0.5,-10)}):Play()
        callback(on)
    end)
    return c
end

-- Slider dengan input box angka langsung
local function makeSlider(parent,label,minV,maxV,defV,order,callback)
    local c = makeCard(parent,order,70)

    local topRow = Instance.new("Frame")
    topRow.Size = UDim2.new(1,-28,0,20)
    topRow.Position = UDim2.new(0,14,0,8)
    topRow.BackgroundTransparency = 1
    topRow.Parent = c

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = GRAY
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = topRow

    -- Input box angka (bisa diketik)
    local valBox = Instance.new("TextBox")
    valBox.Size = UDim2.new(0,52,0,20)
    valBox.Position = UDim2.new(1,-52,0,0)
    valBox.BackgroundColor3 = Color3.fromRGB(18,18,20)
    valBox.TextColor3 = WHITE
    valBox.Font = Enum.Font.GothamBold
    valBox.TextSize = 12
    valBox.Text = tostring(defV)
    valBox.TextXAlignment = Enum.TextXAlignment.Center
    valBox.BorderSizePixel = 0
    valBox.ClearTextOnFocus = false
    valBox.Parent = topRow
    corner(valBox,5)

    -- Track
    local trackFrame = Instance.new("Frame")
    trackFrame.Size = UDim2.new(1,-28,0,5)
    trackFrame.Position = UDim2.new(0,14,0,40)
    trackFrame.BackgroundColor3 = Color3.fromRGB(55,55,60)
    trackFrame.BorderSizePixel = 0
    trackFrame.Parent = c
    corner(trackFrame,3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defV-minV)/(maxV-minV),0,1,0)
    fill.BackgroundColor3 = WHITE
    fill.BorderSizePixel = 0
    fill.Parent = trackFrame
    corner(fill,3)

    local thumb = Instance.new("TextButton")
    thumb.Size = UDim2.new(0,20,0,20)
    thumb.AnchorPoint = Vector2.new(0.5,0.5)
    thumb.Position = UDim2.new((defV-minV)/(maxV-minV),0,0.5,0)
    thumb.BackgroundColor3 = WHITE
    thumb.Text = ""
    thumb.BorderSizePixel = 0
    thumb.Parent = trackFrame
    corner(thumb,10)
    mkStroke(thumb,GRAY,1.5)

    local curVal = defV
    local dragging = false

    local function setVal(rel)
        rel = math.clamp(rel,0,1)
        curVal = math.floor(minV + (maxV-minV)*rel)
        fill.Size = UDim2.new(rel,0,1,0)
        thumb.Position = UDim2.new(rel,0,0.5,0)
        valBox.Text = tostring(curVal)
        callback(curVal)
    end

    -- Drag thumb
    thumb.MouseButton1Down:Connect(function() dragging=true end)
    thumb.TouchLongPress:Connect(function() dragging=true end)

    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or
           i.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or
           i.UserInputType==Enum.UserInputType.Touch then
            local pos = i.UserInputType==Enum.UserInputType.Touch
                and i.Position or i.Position
            local rel = math.clamp(
                (pos.X - trackFrame.AbsolutePosition.X) / trackFrame.AbsoluteSize.X,
                0, 1
            )
            setVal(rel)
        end
    end)

    -- Klik track langsung
    trackFrame.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or
           i.UserInputType==Enum.UserInputType.Touch then
            local rel = math.clamp(
                (i.Position.X - trackFrame.AbsolutePosition.X) / trackFrame.AbsoluteSize.X,
                0, 1
            )
            setVal(rel)
            dragging = true
        end
    end)

    -- Input angka langsung
    valBox.FocusLost:Connect(function()
        local n = tonumber(valBox.Text)
        if n then
            n = math.clamp(math.floor(n),minV,maxV)
            setVal((n-minV)/(maxV-minV))
        else
            valBox.Text = tostring(curVal)
        end
    end)
end

-- ========================
-- FLY ROW (built-in)
-- ========================
local flySpeed = 50
local flyConn

local function makeFlyRow(parent,order)
    local c = makeCard(parent,order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0,30,1,0)
    lbl.Position = UDim2.new(0,14,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "FLY"
    lbl.TextColor3 = WHITE
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(0,120,1,0)
    sub.Position = UDim2.new(0,50,0,0)
    sub.BackgroundTransparency = 1
    sub.Text = "WASD + Space / Shift"
    sub.TextColor3 = GRAY
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 9
    sub.TextXAlignment = Enum.TextXAlignment.Left
    sub.Parent = c

    local execBtn = Instance.new("TextButton")
    execBtn.Size = UDim2.new(0,76,0,28)
    execBtn.Position = UDim2.new(1,-88,0.5,-14)
    execBtn.BackgroundColor3 = Color3.fromRGB(74,74,85)
    execBtn.Text = "EXECUTE"
    execBtn.TextColor3 = WHITE
    execBtn.Font = Enum.Font.GothamBold
    execBtn.TextSize = 10
    execBtn.BorderSizePixel = 0
    execBtn.Parent = c
    corner(execBtn,8)

    states["FLY"] = false
    execBtn.MouseButton1Click:Connect(function()
        states["FLY"] = not states["FLY"]
        local on = states["FLY"]
        if on then
            execBtn.BackgroundColor3 = GREEN
            execBtn.TextColor3 = Color3.fromRGB(0,0,0)
            execBtn.Text = "ON"
            local char = LP.Character or LP.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end
            if root:FindFirstChild("PegasBG") then root.PegasBG:Destroy() end
            if root:FindFirstChild("PegasBV") then root.PegasBV:Destroy() end
            local bg = Instance.new("BodyGyro")
            bg.Name="PegasBG"; bg.MaxTorque=Vector3.new(1e5,1e5,1e5)
            bg.D=150; bg.P=1e4; bg.Parent=root
            local bv = Instance.new("BodyVelocity")
            bv.Name="PegasBV"; bv.MaxForce=Vector3.new(1e5,1e5,1e5)
            bv.Velocity=Vector3.zero; bv.Parent=root
            flyConn = RunService.Heartbeat:Connect(function()
                if not states["FLY"] then return end
                local cam = workspace.CurrentCamera
                local vel = Vector3.zero
                local spd = flySpeed
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel=vel+cam.CFrame.LookVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel=vel-cam.CFrame.LookVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel=vel-cam.CFrame.RightVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel=vel+cam.CFrame.RightVector*spd end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel=vel+Vector3.new(0,spd,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel=vel-Vector3.new(0,spd,0) end
                bv.Velocity=vel; bg.CFrame=cam.CFrame
            end)
        else
            execBtn.BackgroundColor3=Color3.fromRGB(74,74,85)
            execBtn.TextColor3=WHITE; execBtn.Text="EXECUTE"
            if flyConn then flyConn:Disconnect();flyConn=nil end
            local char=LP.Character
            if char then
                local root=char:FindFirstChild("HumanoidRootPart")
                if root then
                    if root:FindFirstChild("PegasBG") then root.PegasBG:Destroy() end
                    if root:FindFirstChild("PegasBV") then root.PegasBV:Destroy() end
                end
                local hum=char:FindFirstChildOfClass("Humanoid")
                if hum then hum.PlatformStand=false end
            end
        end
    end)
end

-- ========================
-- MAIN PAGE
-- ========================
local spdVal = 80
local noclipConn, hjumpConn

makeFlyRow(Pages[1],1)
makeSlider(Pages[1],"Fly speed",10,200,50,2,function(v) flySpeed=v end)

makeToggle(Pages[1],"SPEED",3,function(on)
    local char=LP.Character
    local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed=on and spdVal or 16 end
end)
makeSlider(Pages[1],"Speed value",16,300,80,4,function(v)
    spdVal=v
    if states["SPEED"] then
        local char=LP.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=v end
    end
end)

makeToggle(Pages[1],"NOCLIP",5,function(on)
    if on then
        noclipConn=RunService.Stepped:Connect(function()
            if not states["NOCLIP"] then return end
            local char=LP.Character
            if char then
                for _,p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect();noclipConn=nil end
    end
end)

makeToggle(Pages[1],"INVISIBLE",6,function(on)
    local char=LP.Character
    if char then
        for _,p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=on and 1 or 0 end
        end
    end
end)

makeToggle(Pages[1],"HIGH JUMP",7,function(on)
    if on then
        hjumpConn=UserInputService.JumpRequest:Connect(function()
            if not states["HIGH JUMP"] then return end
            local char=LP.Character; if not char then return end
            local root=char:FindFirstChild("HumanoidRootPart")
            local hum=char:FindFirstChildOfClass("Humanoid")
            if root and hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                local bv=Instance.new("BodyVelocity")
                bv.Velocity=Vector3.new(0,130,0)
                bv.MaxForce=Vector3.new(0,1e6,0)
                bv.Parent=root
                game:GetService("Debris"):AddItem(bv,0.2)
            end
        end)
    else
        if hjumpConn then hjumpConn:Disconnect();hjumpConn=nil end
    end
end)

secLabel(Pages[1],"GRAFIK & LAG",8)
makeToggle(Pages[1],"FIX LAG",9,function(on)
    if on then
        Lighting.GlobalShadows=false; Lighting.FogEnd=9e9
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled=false end
        end
        settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
    else
        Lighting.GlobalShadows=true
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then v.Enabled=true end
        end
        settings().Rendering.QualityLevel=Enum.QualityLevel.Automatic
    end
end)

local spacer=Instance.new("Frame")
spacer.Size=UDim2.new(1,0,0,8)
spacer.BackgroundTransparency=1
spacer.LayoutOrder=10
spacer.Parent=Pages[1]

local discCard=makeCard(Pages[1],11,46)
local discLbl=Instance.new("TextLabel")
discLbl.Size=UDim2.new(1,-90,1,0)
discLbl.Position=UDim2.new(0,14,0,0)
discLbl.BackgroundTransparency=1
discLbl.Text="JOIN DISCORD"
discLbl.TextColor3=WHITE
discLbl.Font=Enum.Font.GothamBold
discLbl.TextSize=13
discLbl.TextXAlignment=Enum.TextXAlignment.Left
discLbl.Parent=discCard
local joinBtn=Instance.new("TextButton")
joinBtn.Size=UDim2.new(0,60,0,28)
joinBtn.Position=UDim2.new(1,-72,0.5,-14)
joinBtn.BackgroundColor3=BLUE
joinBtn.Text="JOIN"
joinBtn.TextColor3=WHITE
joinBtn.Font=Enum.Font.GothamBold
joinBtn.TextSize=11
joinBtn.BorderSizePixel=0
joinBtn.Parent=discCard
corner(joinBtn,8)
joinBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/kjVyy4vxR5")
        joinBtn.Text="COPIED!"
        joinBtn.BackgroundColor3=GREEN
        joinBtn.TextColor3=Color3.fromRGB(0,0,0)
        task.delay(2,function()
            joinBtn.Text="JOIN"
            joinBtn.BackgroundColor3=BLUE
            joinBtn.TextColor3=WHITE
        end)
    end
end)

-- ========================
-- ESP PAGE
-- ========================
local espConn
local espObjects={}
local function clearESP()
    for _,o in ipairs(espObjects) do pcall(function() o:Destroy() end) end
    espObjects={}
end
local function buildESP()
    clearESP()
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP and plr.Character then
            local head=plr.Character:FindFirstChild("Head")
            if head then
                local bb=Instance.new("BillboardGui")
                bb.Size=UDim2.new(0,120,0,20)
                bb.AlwaysOnTop=true
                bb.StudsOffset=Vector3.new(0,3.5,0)
                bb.Adornee=head; bb.Parent=head
                local nl=Instance.new("TextLabel")
                nl.Size=UDim2.new(1,0,1,0)
                nl.BackgroundTransparency=1
                nl.Text=plr.Name
                nl.TextColor3=Color3.fromRGB(255,0,0)
                nl.Font=Enum.Font.GothamBold
                nl.TextScaled=true
                nl.Parent=bb
                table.insert(espObjects,bb)
            end
        end
    end
end
secLabel(Pages[2],"VISUALS",1)
makeToggle(Pages[2],"SKELETON ESP",2,function(on)
    if on then
        buildESP()
        espConn=RunService.Heartbeat:Connect(function()
            if states["SKELETON ESP"] then buildESP() end
        end)
    else
        if espConn then espConn:Disconnect();espConn=nil end
        clearESP()
    end
end)

-- ========================
-- TROLL PAGE (auto player list)
-- ========================
secLabel(Pages[3],"SELECT TARGET",1)

local listCard=makeCard(Pages[3],2,180)
local listScroll=Instance.new("ScrollingFrame")
listScroll.Size=UDim2.new(1,-20,1,-10)
listScroll.Position=UDim2.new(0,10,0,5)
listScroll.BackgroundTransparency=1
listScroll.ScrollBarThickness=2
listScroll.ScrollBarImageColor3=GRAY
listScroll.BorderSizePixel=0
listScroll.Parent=listCard
local listLayout=Instance.new("UIListLayout",listScroll)
listLayout.Padding=UDim.new(0,4)
listLayout.SortOrder=Enum.SortOrder.LayoutOrder

local selectedPlayer=nil
local playerBtns={}

local function refreshPlayerList()
    for _,b in pairs(playerBtns) do b:Destroy() end
    playerBtns={}; selectedPlayer=nil
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            local pb=Instance.new("TextButton")
            pb.Size=UDim2.new(1,0,0,30)
            pb.BackgroundColor3=DARKBG
            pb.Text="  "..plr.Name
            pb.TextColor3=GRAY
            pb.Font=Enum.Font.GothamBold
            pb.TextSize=11
            pb.TextXAlignment=Enum.TextXAlignment.Left
            pb.BorderSizePixel=0
            pb.Parent=listScroll
            corner(pb,6)
            table.insert(playerBtns,pb)
            pb.MouseButton1Click:Connect(function()
                selectedPlayer=plr
                for _,b2 in pairs(playerBtns) do
                    b2.BackgroundColor3=DARKBG
                    b2.TextColor3=GRAY
                end
                pb.BackgroundColor3=Color3.fromRGB(55,55,70)
                pb.TextColor3=WHITE
            end)
        end
    end
    listScroll.CanvasSize=UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y+8)
end
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(function() task.wait(0.1);refreshPlayerList() end)
refreshPlayerList()

local refCard=makeCard(Pages[3],3,36)
local refBtn=Instance.new("TextButton")
refBtn.Size=UDim2.new(1,-28,0,22)
refBtn.Position=UDim2.new(0,14,0.5,-11)
refBtn.BackgroundColor3=Color3.fromRGB(55,55,65)
refBtn.Text="REFRESH LIST"
refBtn.TextColor3=GRAY
refBtn.Font=Enum.Font.GothamBold
refBtn.TextSize=10
refBtn.BorderSizePixel=0
refBtn.Parent=refCard
corner(refBtn,6)
refBtn.MouseButton1Click:Connect(function()
    refreshPlayerList()
    TweenService:Create(refBtn,TweenInfo.new(0.1),{BackgroundColor3=GREEN}):Play()
    task.delay(0.4,function() TweenService:Create(refBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(55,55,65)}):Play() end)
end)

local btnGrid=Instance.new("Frame")
btnGrid.Size=UDim2.new(1,0,0,100)
btnGrid.BackgroundTransparency=1
btnGrid.LayoutOrder=4
btnGrid.Parent=Pages[3]
local gl=Instance.new("UIGridLayout",btnGrid)
gl.CellSize=UDim2.new(0.5,-4,0,44)
gl.CellPadding=UDim2.new(0,6,0,6)

local function mkTrollBtn(parent,label,cb)
    local btn=Instance.new("TextButton")
    btn.BackgroundColor3=CARD; btn.Text=label
    btn.TextColor3=WHITE; btn.Font=Enum.Font.GothamBold
    btn.TextSize=12; btn.BorderSizePixel=0
    btn.Parent=parent
    corner(btn,10); mkStroke(btn,Color3.fromRGB(55,55,60))
    btn.MouseButton1Click:Connect(function()
        if not selectedPlayer then
            btn.Text="NO TARGET"
            TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(160,0,0)}):Play()
            task.delay(1.5,function()
                btn.Text=label
                TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=CARD}):Play()
            end)
            return
        end
        TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=GREEN}):Play()
        task.delay(0.3,function() TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=CARD}):Play() end)
        cb(selectedPlayer)
    end)
end

mkTrollBtn(btnGrid,"TP TO",function(t)
    if not t.Character then return end
    local myChar=LP.Character; if not myChar then return end
    local r=myChar:FindFirstChild("HumanoidRootPart")
    local tr=t.Character:FindFirstChild("HumanoidRootPart")
    if r and tr then r.CFrame=tr.CFrame*CFrame.new(0,3,0) end
end)
mkTrollBtn(btnGrid,"FLING",function(t)
    if not t.Character then return end
    local tr=t.Character:FindFirstChild("HumanoidRootPart")
    if tr then
        local bv=Instance.new("BodyVelocity")
        bv.Velocity=Vector3.new(math.random(-1200,1200),2500,math.random(-1200,1200))
        bv.MaxForce=Vector3.new(1e9,1e9,1e9); bv.Parent=tr
        game:GetService("Debris"):AddItem(bv,0.15)
    end
end)
mkTrollBtn(btnGrid,"SIT HEAD",function(t)
    if not t.Character then return end
    local myChar=LP.Character; if not myChar then return end
    local r=myChar:FindFirstChild("HumanoidRootPart")
    local th=t.Character:FindFirstChild("Head")
    if r and th then
        local w=Instance.new("WeldConstraint")
        w.Part0=r; w.Part1=th; w.Parent=r
        r.CFrame=th.CFrame*CFrame.new(0,2.5,0)
        game:GetService("Debris"):AddItem(w,10)
    end
end)
mkTrollBtn(btnGrid,"EWE",function(t)
    if not t.Character then return end
    local myChar=LP.Character; if not myChar then return end
    local r=myChar:FindFirstChild("HumanoidRootPart")
    local tr=t.Character:FindFirstChild("HumanoidRootPart")
    if r and tr then
        local w=Instance.new("WeldConstraint")
        w.Part0=r; w.Part1=tr; w.Parent=r
        r.CFrame=tr.CFrame*CFrame.new(0,1,-0.5)*CFrame.Angles(0,math.pi,0.3)
        game:GetService("Debris"):AddItem(w,8)
    end
end)

-- CANVAS SIZE
for _,pg in ipairs(Pages) do
    local lay=pg:FindFirstChildOfClass("UIListLayout")
    if lay then
        local function upd() pg.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+16) end
        upd(); lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(upd)
    end
end

-- DRAG PANEL
local drag,dragStart,startPos=false,nil,nil
Header.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        drag=true; dragStart=i.Position; startPos=Panel.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        if not dragStart then return end
        local d=i.Position-dragStart
        Panel.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=false end
end)

-- DRAG MINI
local mdrag,mdStart,mdPos=false,nil,nil
Mini.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        mdrag=true; mdStart=i.Position; mdPos=Mini.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if mdrag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        if not mdStart then return end
        local d=i.Position-mdStart
        Mini.Position=UDim2.new(mdPos.X.Scale,mdPos.X.Offset+d.X,mdPos.Y.Scale,mdPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then mdrag=false end
end)

-- KEY TOGGLE
UserInputService.InputBegan:Connect(function(i,gp)
    if not gp and i.KeyCode==Enum.KeyCode.RightControl then
        if Panel.Visible then Panel.Visible=false; Mini.Visible=true
        else Mini.Visible=false; Panel.Visible=true end
    end
end)
