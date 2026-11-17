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
local LOGO  = "rbxassetid://6023426923"

local function corner(p,r) Instance.new("UICorner",p).CornerRadius=UDim.new(0,r or 12) end
local function mkStroke(p,c,t) local s=Instance.new("UIStroke",p);s.Color=c;s.Thickness=t or 1 end

-- ========================
-- MINI BADGE — draggable bulat
-- ========================
local Mini = Instance.new("Frame")
Mini.Size = UDim2.new(0,68,0,68)
Mini.Position = UDim2.new(0,16,0.5,-34)
Mini.BackgroundColor3 = Color3.fromRGB(10,10,12)
Mini.BorderSizePixel = 0
Mini.Visible = false
Mini.ZIndex = 999
Mini.Parent = GUI
corner(Mini,34)
mkStroke(Mini,Color3.fromRGB(120,120,130),2)

local MiniImg = Instance.new("ImageLabel")
MiniImg.Size = UDim2.new(1,0,1,0)
MiniImg.BackgroundTransparency = 1
MiniImg.Image = LOGO
MiniImg.ScaleType = Enum.ScaleType.Crop
MiniImg.ZIndex = 1000
MiniImg.Parent = Mini
corner(MiniImg,34)

-- TextButton di atas untuk handle drag + tap
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
Panel.Size = UDim2.new(0,340,0,560)
Panel.Position = UDim2.new(0.5,-170,0.5,-280)
Panel.BackgroundColor3 = BG
Panel.BorderSizePixel = 0
Panel.ZIndex = 100
Panel.Parent = GUI
corner(Panel,16)
mkStroke(Panel,Color3.fromRGB(55,55,60))

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,56)
Header.BackgroundColor3 = CARD
Header.BorderSizePixel = 0
Header.ZIndex = 101
Header.Parent = Panel
corner(Header,16)

local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0,40,0,40)
LogoFrame.Position = UDim2.new(0,10,0.5,-20)
LogoFrame.BackgroundColor3 = Color3.fromRGB(10,10,12)
LogoFrame.BorderSizePixel = 0
LogoFrame.ZIndex = 102
LogoFrame.Parent = Header
corner(LogoFrame,20)
mkStroke(LogoFrame,Color3.fromRGB(120,120,130),2)

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

-- MINIMIZE: sembunyikan panel, tampilkan badge
MinBtn.MouseButton1Click:Connect(function()
    Panel.Visible = false
    Mini.Visible = true
    -- reset posisi badge ke tengah kiri
    Mini.Position = UDim2.new(0,16,0.5,-34)
end)

-- ========================
-- DRAG BADGE (mini) — mouse & touch
-- ========================
local miniDragging = false
local miniDragStart = nil
local miniStartPos = nil
local miniMoved = false

MiniBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        miniDragging = true
        miniMoved = false
        miniDragStart = i.Position
        miniStartPos = Mini.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if not miniDragging then return end
    if i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch then
        if not miniDragStart then return end
        local delta = i.Position - miniDragStart
        -- anggap moved jika gerak > 5px
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            miniMoved = true
        end
        Mini.Position = UDim2.new(
            miniStartPos.X.Scale,
            miniStartPos.X.Offset + delta.X,
            miniStartPos.Y.Scale,
            miniStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        if miniDragging and not miniMoved then
            -- tap tanpa geser = buka panel
            Mini.Visible = false
            Panel.Visible = true
        end
        miniDragging = false
        miniMoved = false
    end
end)

-- DIVIDER
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

for i,name in ipairs({"MAIN","ESP","TROLL"}) do
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

-- HELPERS
local states = {}

local function secLabel(p,text,order)
    local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,0,0,18)
    l.BackgroundTransparency=1; l.Text=text; l.TextColor3=GRAY
    l.Font=Enum.Font.GothamBold; l.TextSize=11
    l.TextXAlignment=Enum.TextXAlignment.Left; l.LayoutOrder=order; l.Parent=p
end

local function makeCard(p,order,h)
    local c=Instance.new("Frame"); c.Size=UDim2.new(1,0,0,h or 46)
    c.BackgroundColor3=CARD; c.BorderSizePixel=0; c.LayoutOrder=order; c.Parent=p
    corner(c,12); return c
end

local function makeToggle(parent,label,order,callback)
    local c=makeCard(parent,order)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-60,1,0); lbl.Position=UDim2.new(0,14,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=label; lbl.TextColor3=WHITE
    lbl.Font=Enum.Font.GothamBold; lbl.TextSize=13; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=c
    local track=Instance.new("TextButton"); track.Size=UDim2.new(0,44,0,26)
    track.Position=UDim2.new(1,-54,0.5,-13); track.BackgroundColor3=Color3.fromRGB(55,55,60)
    track.Text=""; track.BorderSizePixel=0; track.Parent=c; corner(track,13)
    local knob=Instance.new("Frame"); knob.Size=UDim2.new(0,20,0,20)
    knob.Position=UDim2.new(0,3,0.5,-10); knob.BackgroundColor3=WHITE
    knob.BorderSizePixel=0; knob.Parent=track; corner(knob,10)
    states[label]=false
    track.MouseButton1Click:Connect(function()
        states[label]=not states[label]; local on=states[label]
        TweenService:Create(track,TweenInfo.new(0.15),{BackgroundColor3=on and GREEN or Color3.fromRGB(55,55,60)}):Play()
        TweenService:Create(knob,TweenInfo.new(0.15),{Position=on and UDim2.new(0,21,0.5,-10) or UDim2.new(0,3,0.5,-10)}):Play()
        callback(on)
    end)
    return c
end

local function makeSlider(parent,label,minV,maxV,defV,order,callback)
    local c=makeCard(parent,order,62)
    local topRow=Instance.new("Frame"); topRow.Size=UDim2.new(1,-28,0,18)
    topRow.Position=UDim2.new(0,14,0,10); topRow.BackgroundTransparency=1; topRow.Parent=c
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(0.7,0,1,0); lbl.BackgroundTransparency=1
    lbl.Text=label; lbl.TextColor3=GRAY; lbl.Font=Enum.Font.Gotham; lbl.TextSize=11
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=topRow
    local valLbl=Instance.new("TextLabel"); valLbl.Size=UDim2.new(0.3,0,1,0)
    valLbl.Position=UDim2.new(0.7,0,0,0); valLbl.BackgroundTransparency=1
    valLbl.Text=tostring(defV); valLbl.TextColor3=WHITE; valLbl.Font=Enum.Font.GothamBold
    valLbl.TextSize=12; valLbl.TextXAlignment=Enum.TextXAlignment.Right; valLbl.Parent=topRow
    local tf=Instance.new("Frame"); tf.Size=UDim2.new(1,-28,0,5); tf.Position=UDim2.new(0,14,0,38)
    tf.BackgroundColor3=Color3.fromRGB(55,55,60); tf.BorderSizePixel=0; tf.Parent=c; corner(tf,3)
    local fill=Instance.new("Frame"); fill.Size=UDim2.new((defV-minV)/(maxV-minV),0,1,0)
    fill.BackgroundColor3=WHITE; fill.BorderSizePixel=0; fill.Parent=tf; corner(fill,3)
    local thumb=Instance.new("TextButton"); thumb.Size=UDim2.new(0,20,0,20)
    thumb.AnchorPoint=Vector2.new(0.5,0.5); thumb.Position=UDim2.new((defV-minV)/(maxV-minV),0,0.5,0)
    thumb.BackgroundColor3=WHITE; thumb.Text=""; thumb.BorderSizePixel=0
    thumb.Parent=tf; corner(thumb,10); mkStroke(thumb,GRAY,1.5)
    local curVal=defV; local dragging=false
    local function setVal(rel)
        rel=math.clamp(rel,0,1); curVal=math.floor(minV+(maxV-minV)*rel)
        fill.Size=UDim2.new(rel,0,1,0); thumb.Position=UDim2.new(rel,0,0.5,0)
        valLbl.Text=tostring(curVal); callback(curVal)
    end
    thumb.MouseButton1Down:Connect(function() dragging=true end)
    tf.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            setVal((i.Position.X-tf.AbsolutePosition.X)/tf.AbsoluteSize.X); dragging=true
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if not dragging then return end
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            setVal((i.Position.X-tf.AbsolutePosition.X)/tf.AbsoluteSize.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)
end

-- ========================
-- MAIN PAGE
-- ========================
local flyCard=makeCard(Pages[1],1)
local flyLbl=Instance.new("TextLabel"); flyLbl.Size=UDim2.new(1,-100,1,0); flyLbl.Position=UDim2.new(0,14,0,0)
flyLbl.BackgroundTransparency=1; flyLbl.Text="FLY"; flyLbl.TextColor3=WHITE
flyLbl.Font=Enum.Font.GothamBold; flyLbl.TextSize=13; flyLbl.TextXAlignment=Enum.TextXAlignment.Left; flyLbl.Parent=flyCard
local flyExec=Instance.new("TextButton"); flyExec.Size=UDim2.new(0,76,0,28); flyExec.Position=UDim2.new(1,-88,0.5,-14)
flyExec.BackgroundColor3=Color3.fromRGB(74,74,85); flyExec.Text="EXECUTE"; flyExec.TextColor3=WHITE
flyExec.Font=Enum.Font.GothamBold; flyExec.TextSize=10; flyExec.BorderSizePixel=0; flyExec.Parent=flyCard; corner(flyExec,8)
flyExec.MouseButton1Click:Connect(function()
    flyExec.BackgroundColor3=GREEN; flyExec.TextColor3=Color3.fromRGB(0,0,0); flyExec.Text="RUNNING"
    task.spawn(function()
        loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-FLY-GUI-V3-V4-(MOBILE)-230975"))()
    end)
    task.delay(3,function()
        flyExec.BackgroundColor3=Color3.fromRGB(74,74,85); flyExec.TextColor3=WHITE; flyExec.Text="EXECUTE"
    end)
end)

local spdVal=80
makeToggle(Pages[1],"SPEED",2,function(on)
    local char=LP.Character; local hum=char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed=on and spdVal or 16 end
end)
makeSlider(Pages[1],"Speed value",16,300,80,3,function(v)
    spdVal=v
    if states["SPEED"] then
        local char=LP.Character; local hum=char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed=v end
    end
end)

local noclipConn
makeToggle(Pages[1],"NOCLIP",4,function(on)
    if on then
        noclipConn=RunService.Stepped:Connect(function()
            if not states["NOCLIP"] then return end
            local char=LP.Character
            if char then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
        end)
    else if noclipConn then noclipConn:Disconnect();noclipConn=nil end end
end)

makeToggle(Pages[1],"INVISIBLE",5,function(on)
    local char=LP.Character
    if char then for _,p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=on and 1 or 0 end
    end end
end)

local hjumpConn
makeToggle(Pages[1],"HIGH JUMP",6,function(on)
    if on then
        hjumpConn=UserInputService.JumpRequest:Connect(function()
            if not states["HIGH JUMP"] then return end
            local char=LP.Character; if not char then return end
            local root=char:FindFirstChild("HumanoidRootPart")
            local hum=char:FindFirstChildOfClass("Humanoid")
            if root and hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                local bv=Instance.new("BodyVelocity"); bv.Velocity=Vector3.new(0,130,0)
                bv.MaxForce=Vector3.new(0,1e6,0); bv.Parent=root
                game:GetService("Debris"):AddItem(bv,0.2)
            end
        end)
    else if hjumpConn then hjumpConn:Disconnect();hjumpConn=nil end end
end)

secLabel(Pages[1],"GRAFIK & LAG",7)
makeToggle(Pages[1],"FIX LAG",8,function(on)
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

local sp=Instance.new("Frame"); sp.Size=UDim2.new(1,0,0,8); sp.BackgroundTransparency=1; sp.LayoutOrder=9; sp.Parent=Pages[1]
local dc=makeCard(Pages[1],10,46)
local dl=Instance.new("TextLabel"); dl.Size=UDim2.new(1,-90,1,0); dl.Position=UDim2.new(0,14,0,0)
dl.BackgroundTransparency=1; dl.Text="JOIN DISCORD"; dl.TextColor3=WHITE
dl.Font=Enum.Font.GothamBold; dl.TextSize=13; dl.TextXAlignment=Enum.TextXAlignment.Left; dl.Parent=dc
local jb=Instance.new("TextButton"); jb.Size=UDim2.new(0,60,0,28); jb.Position=UDim2.new(1,-72,0.5,-14)
jb.BackgroundColor3=BLUE; jb.Text="JOIN"; jb.TextColor3=WHITE; jb.Font=Enum.Font.GothamBold
jb.TextSize=11; jb.BorderSizePixel=0; jb.Parent=dc; corner(jb,8)
jb.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/kjVyy4vxR5")
        jb.Text="COPIED!"; jb.BackgroundColor3=GREEN; jb.TextColor3=Color3.fromRGB(0,0,0)
        task.delay(2,function() jb.Text="JOIN"; jb.BackgroundColor3=BLUE; jb.TextColor3=WHITE end)
    end
end)

-- ========================
-- ESP PAGE
-- ========================
local espConn; local espObjects={}
local function clearESP() for _,o in ipairs(espObjects) do pcall(function() o:Destroy() end) end espObjects={} end
local function buildESP()
    clearESP()
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP and plr.Character then
            local head=plr.Character:FindFirstChild("Head")
            if head then
                local bb=Instance.new("BillboardGui"); bb.Size=UDim2.new(0,120,0,20)
                bb.AlwaysOnTop=true; bb.StudsOffset=Vector3.new(0,3.5,0); bb.Adornee=head; bb.Parent=head
                local nl=Instance.new("TextLabel"); nl.Size=UDim2.new(1,0,1,0); nl.BackgroundTransparency=1
                nl.Text=plr.Name; nl.TextColor3=Color3.fromRGB(255,0,0); nl.Font=Enum.Font.GothamBold; nl.TextScaled=true; nl.Parent=bb
                table.insert(espObjects,bb)
            end
        end
    end
end
secLabel(Pages[2],"VISUALS",1)
makeToggle(Pages[2],"SKELETON ESP",2,function(on)
    if on then buildESP(); espConn=RunService.Heartbeat:Connect(function() if states["SKELETON ESP"] then buildESP() end end)
    else if espConn then espConn:Disconnect();espConn=nil end clearESP() end
end)

-- ========================
-- TROLL PAGE
-- ========================
secLabel(Pages[3],"SELECT TARGET",1)
local listCard=makeCard(Pages[3],2,180)
local listScroll=Instance.new("ScrollingFrame"); listScroll.Size=UDim2.new(1,-20,1,-10)
listScroll.Position=UDim2.new(0,10,0,5); listScroll.BackgroundTransparency=1
listScroll.ScrollBarThickness=2; listScroll.ScrollBarImageColor3=GRAY; listScroll.BorderSizePixel=0; listScroll.Parent=listCard
local listLayout=Instance.new("UIListLayout",listScroll); listLayout.Padding=UDim.new(0,4); listLayout.SortOrder=Enum.SortOrder.LayoutOrder

local selectedPlayer=nil; local playerBtns={}
local function refreshPlayerList()
    for _,b in pairs(playerBtns) do b:Destroy() end
    playerBtns={}; selectedPlayer=nil
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            local pb=Instance.new("TextButton"); pb.Size=UDim2.new(1,0,0,30); pb.BackgroundColor3=DARKBG
            pb.Text="  "..plr.Name; pb.TextColor3=GRAY; pb.Font=Enum.Font.GothamBold; pb.TextSize=11
            pb.TextXAlignment=Enum.TextXAlignment.Left; pb.BorderSizePixel=0; pb.Parent=listScroll; corner(pb,6)
            table.insert(playerBtns,pb)
            pb.MouseButton1Click:Connect(function()
                selectedPlayer=plr
                for _,b2 in pairs(playerBtns) do b2.BackgroundColor3=DARKBG; b2.TextColor3=GRAY end
                pb.BackgroundColor3=Color3.fromRGB(55,55,70); pb.TextColor3=WHITE
            end)
        end
    end
    listScroll.CanvasSize=UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y+8)
end
Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(function() task.wait(0.1); refreshPlayerList() end)
refreshPlayerList()

local refCard=makeCard(Pages[3],3,36)
local refBtn=Instance.new("TextButton"); refBtn.Size=UDim2.new(1,-28,0,22); refBtn.Position=UDim2.new(0,14,0.5,-11)
refBtn.BackgroundColor3=Color3.fromRGB(55,55,65); refBtn.Text="REFRESH LIST"; refBtn.TextColor3=GRAY
refBtn.Font=Enum.Font.GothamBold; refBtn.TextSize=10; refBtn.BorderSizePixel=0; refBtn.Parent=refCard; corner(refBtn,6)
refBtn.MouseButton1Click:Connect(function()
    refreshPlayerList()
    TweenService:Create(refBtn,TweenInfo.new(0.1),{BackgroundColor3=GREEN}):Play()
    task.delay(0.4,function() TweenService:Create(refBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(55,55,65)}):Play() end)
end)

local btnGrid=Instance.new("Frame"); btnGrid.Size=UDim2.new(1,0,0,100)
btnGrid.BackgroundTransparency=1; btnGrid.LayoutOrder=4; btnGrid.Parent=Pages[3]
local gl=Instance.new("UIGridLayout",btnGrid); gl.CellSize=UDim2.new(0.5,-4,0,44); gl.CellPadding=UDim2.new(0,6,0,6)

local function mkTrollBtn(parent,label,cb)
    local btn=Instance.new("TextButton"); btn.BackgroundColor3=CARD; btn.Text=label
    btn.TextColor3=WHITE; btn.Font=Enum.Font.GothamBold; btn.TextSize=12
    btn.BorderSizePixel=0; btn.Parent=parent; corner(btn,10); mkStroke(btn,Color3.fromRGB(55,55,60))
    btn.MouseButton1Click:Connect(function()
        if not selectedPlayer or not selectedPlayer.Character then
            local orig=btn.Text; btn.Text="NO TARGET"
            TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(160,0,0)}):Play()
            task.delay(1.5,function() btn.Text=orig; TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=CARD}):Play() end)
            return
        end
        TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=GREEN}):Play()
        task.delay(0.3,function() TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundColor3=CARD}):Play() end)
        cb(selectedPlayer)
    end)
end

mkTrollBtn(btnGrid,"TP TO",function(t)
    local myChar=LP.Character; if not myChar then return end
    local r=myChar:FindFirstChild("HumanoidRootPart")
    local tr=t.Character:FindFirstChild("HumanoidRootPart")
    if r and tr then r.CFrame=tr.CFrame*CFrame.new(0,3,0) end
end)
mkTrollBtn(btnGrid,"FLING",function(t)
    local myRoot=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    local tRoot=t.Character:FindFirstChild("HumanoidRootPart")
    if not tRoot or tRoot==myRoot then return end
    local bv=Instance.new("BodyVelocity")
    bv.Velocity=Vector3.new(math.random(-1200,1200),2500,math.random(-1200,1200))
    bv.MaxForce=Vector3.new(1e9,1e9,1e9); bv.Parent=tRoot
    game:GetService("Debris"):AddItem(bv,0.15)
end)
mkTrollBtn(btnGrid,"SIT HEAD",function(t)
    local myChar=LP.Character; if not myChar then return end
    local r=myChar:FindFirstChild("HumanoidRootPart")
    local th=t.Character:FindFirstChild("Head")
    if r and th then
        local w=Instance.new("WeldConstraint"); w.Part0=r; w.Part1=th; w.Parent=r
        r.CFrame=th.CFrame*CFrame.new(0,2.5,0)
        game:GetService("Debris"):AddItem(w,10)
    end
end)
mkTrollBtn(btnGrid,"EWE",function(t)
    local myChar=LP.Character; if not myChar then return end
    local r=myChar:FindFirstChild("HumanoidRootPart")
    local tr=t.Character:FindFirstChild("HumanoidRootPart")
    if r and tr and tr~=r then
        local w=Instance.new("WeldConstraint"); w.Part0=r; w.Part1=tr; w.Parent=r
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

-- KEY TOGGLE
UserInputService.InputBegan:Connect(function(i,gp)
    if not gp and i.KeyCode==Enum.KeyCode.RightControl then
        if Panel.Visible then
            Panel.Visible=false; Mini.Visible=true
            Mini.Position=UDim2.new(0,16,0.5,-34)
        else
            Mini.Visible=false; Panel.Visible=true
        end
    end
end)
