--function make_window()
if gameroot==nil then dofile(getSceneInfo(IG3D_ROOT).."Data/game script.lua") end
-- wButtonProperties
function wButtonProperties(w)
local wimage=w:image()
local isw=w:image():w()
local ish=w:image():h()
local n=w:label()
local x=w:x()
local y=w:y()
local height=w:h()
local width=w:w()
end
-- fix Icons
function fixIcons()

local sw=UIMainTools:w()
local sh=UIMainTools:h()
local sx=UIMainTools:x()
local sy=UIMainTools:y()

local x=5
local y=31
for i=1,#toolButton.button,1 do
local w=toolButton.button[i]

local wimage=w:image()
local isw=w:image():w()
local ish=w:image():h()
local n=w:label()

if isw >= 23 or ish  >= 23 then 
w:image(w:image():copy(22,22));
end
if x>=sw-23 then x=5 
y=y+24 
end

w:resize(x,y,24,24);
w:redraw();
srh=y+32
x=x+24
end

menuBar:resize(0,0,UIMainTools:w(),30)
menuBar:redraw();

if srh>sh then UIMainTools:resize(sx,sy,sw,srh) end
UIMainTools:redraw();

end
defaultmenuFunctions={"entities","objects","file","mesh","library","levels","edit","level","fluid","particles","main"}
for i=1,#defaultmenuFunctions,1 do
mFunctionPath=gameroot.."Data/Scripts/Functions/Menus/"..defaultmenuFunctions[i].."_menu_functions.lua"
---print(defaultmenuFunctions[i])
dofile(mFunctionPath)
end
-- UIMainToolsCB  
function UIMainToolsCB(w)
resetFunctions()
UIMainTools:make_current();
fixIcons()
screen_x= Fl:event_x()
screen_y = Fl:event_y()


if gEditingMode == "edit_entitydrop" then
collideWithScene = false
--print(screen_x, screen_y, collideWithScene)
dropatx, dropaty, dropatz = ig3d_Get3DPositionFrom2DCoordinates_2ib_3f(screen_x, screen_y, collideWithScene)
--print(dropatx, dropaty, dropatz)
end
fltk_update();
--print(w,os.time())
 if oldgame~=nil then oldgame() end
end
oldgame=game_func
--RUN
oldgame=game_func
UI_MAINTOOLS_WINDOW();
--end
Fl:run()
