--function make_window()
function buttonClick(w)
L=w:label()
if L == "Start Server" then 
w:label("Reset Server")
oldgame=game_func
game_func=telnetLevel
else
w:label("Start Server")
gTelnetServer:close()
gTelnetServer=nil 
    	
for i=1,numConnections,1 do
if connections[i]~=nil then connections[i].tcpsocket:close() end
end

end
     		
     
end
do telnetserver= fltk:Fl_Double_Window(0,0,0,0,"")
telnetserver:label("Telnet Server")
telnetserver:resize(175,151,133,164)
--telnetserver:show()
do serverStart= fltk:Fl_Button(0,0,0,0,"")
serverStart:label("Start Server")
serverStart:callback(buttonClick)
serverStart:resize(5,5,125,20)
serverStart:labelsize(11)
Fl_Group:current(Fl_Group:current():parent())
end
Fl_Group:current(Fl_Group:current():parent())
end

telnetserver:show();
if console==nil then dofile(gameroot.."Data/Fluid/console/console.fl") end

--dofile(gameroot.."Data/Scripts/Functions/telnet_functions.lua")
dofile(gameroot.."Data/Levels/default/default_Globals.lua")

setSceneInfo(IG3D_RUN_IN_BACKGROUND, true) --server needs to be able to run in background

function telnetLevel()	
if oldgame ~= nil then oldgame() end;
      ig3d_chatserver()
     fltk_update()
end
--end
