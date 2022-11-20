--function make_window()
function disa(w)
w:enable(false)
end
local i,ii,iii
local maxHumans, maxZombies, maxCars, maxBuildings = 20,20,12,15
local  numcars,numzombies, numbuildings, numguns = 0,0,0,1
zgsHumans={"mcTrueBones","Officer","jackytruebones","chick"}
zgsZombies={"zombie","zombiechick","zombiechick_alt","zombiechick_alt2"}
zgsWeapons={"gloc"}
zgsBuildings={"building4x2x4a","building4x2x4b","building4x4x4a","building8x2x2"};  
 -- {"building24x24x24a"}
zgsWallsLong={"brickwallp5x1x8","fencep25x2x16" , "fencep25x2x14"  , "pumpkin08"};  
zgsWallsWide={"brickwall8x1xp5","fence16x2xp25", "fence11x2xp25", "pumpkin08" };  

 
-- buildingsTypes={"a","b","d","e","f"}

-- for i=1,#buildingsTypes,1 do
-- local bstring = "building16x8x16"..buildingsTypes[i]
-- table.insert(zgsBuildings,bstring)
-- local bstring = "fence16x8x16"..buildingsTypes[i]
-- table.insert(zgsBuildings,bstring)
-- end

zgsCars={"vehicle","BHWarthog1k7"}

entityPos={}
levelInput = ""




zObjectWTFs={"Misc/selectionRect.wtf","Characters/mcTrueBones.wtf","Weapons/gloc.wtf"}
zObjectNames={"selectionRect1","masterchief","gun1"}
zObjectColls={false,true,true}
zObjectPositions={{0.0,0.0,0.0},{1.0,1.0,1.0},{1.5,1.5,1.5}}
zObjectRotations={}
zObjectHuds={}

math.randomseed(os.time())
local LevelComplexity=math.random(4,12)
local plx,plz 
local ply = 3.0
local blx,blz = 0,0
print("LevelComplexity=",LevelComplexity)

housePos ={}
-- create house positions on 5x5 map at 64 units per square
for i = -160,160,64 do
for ii = -160,160,64 do
table.insert(housePos,{i,ii})
end
end
-- ZGS template load Script loadMesh in [1]

zgsLoadScript={}
zgsLoadScript[1]='loadMesh("Data/WTF/Locations/streetMap384x384A.wtf")\n'
-- sounds, fonts and camera in [2]
zgsLoadScript[2]=[[
gSoundFiles={"Data/Sounds/bodyhit.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/zombie.ogg"}
for i=1,#gSoundFiles,1 do
	loadSound(gSoundFiles[i])
end
gFontFiles={{"Data/FontPngs/default32_1.png","Data/FontPngs/default32_2.png"}}
for i=1,#gFontFiles,1 do
	loadFont(gFontFiles[i][1],gFontFiles[i][2])
end
setCameraInfo(IG3D_POSITION, 0.0, 12.901425, 0.0)
setCameraInfo(IG3D_ROTATION, 37.666630, -77.404633, 0.000000)
]] -- end of [2]
--  object generation here at [3]

zgsLoadScript[3]=[[

gObjects={}
for i=1,#gObjectWTFs,1 do
	gObjects[i]={}
	gObjects[i].cObj=make(ig3d_object, gObjectWTFs[i])
	setObjectInfo(gObjects[i].cObj, IG3D_NAME, gObjectNames[i])
	setObjectInfo(gObjects[i].cObj, IG3D_POSITION, gObjectPositions[i][1],gObjectPositions[i][2],gObjectPositions[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_ROTATION, gObjectRotations[i][1],gObjectRotations[i][2],gObjectRotations[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_SIZE, gObjectSizes[i][1],gObjectSizes[i][2],gObjectSizes[i][3])
	setObjectInfo(gObjects[i].cObj, IG3D_COLL, gObjectColls[i])
	setObjectInfo(gObjects[i].cObj, IG3D_HUD, gObjectHUDs[i])
end
]]
-- the rest of autoscript goes here in [4]
zgsLoadScript[4] = [[
gNumObjects=#gObjectWTFs
gParticleNamesAndEMTs={{"Bullets","Data/Emitters/pistol.emt"},{"TireTraces","Data/Emitters/tiretrace.emt"},{"Blood","Data/Emitters/blood.emt"},{"MoreBlood","Data/Emitters/blood2.emt"},{"Muzzleflash","Data/Emitters/muzzleflash.emt"},{"Unitmarker","Data/Emitters/unitmarker.emt"},{"Unitmarker2","Data/Emitters/unitmarker2.emt"}}
gParticlePositions={{-34.501820,-2.745420,-11.845739},{-185.062057,-2.428456,-0.457016},{-29.986479,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739},{-34.501820,-2.745420,-11.845739}}
gParticleRotations={{-9.058784,168.954941,-0.000000},{17.067825,64.048012,-0.000000},{-29.986481,-2.190553,-33.200272},{-0.182363,0.522658,-0.518280},{-0.182363,0.522658,-0.518280},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gParticleEmitters={}
for i=1,#gParticleNamesAndEMTs,1 do
	gParticleEmitters[i]=make(ig3d_particle_emitter, gParticleNamesAndEMTs[i][1], gParticleNamesAndEMTs[i][2])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_POSITION, gParticlePositions[i][1],gParticlePositions[i][2],gParticlePositions[i][3])
	setParticle_emitterInfo(gParticleEmitters[i], IG3D_ROTATION, gParticleRotations[i][1],gParticleRotations[i][2],gParticleRotations[i][3])
end
gNumParticleEmitters=#gParticleNamesAndEMTs
gSoundEmitterNames={"emt1","emt2","emt3","emt4","emt5","emt6","emt7","emt8","emt9","emt10","emt11","emt12","emt13","emt14","emt15","emt16","emt17","emt18","emt19","emt20","emt21","emt22","emt23","emt24","emt25","emt26","emt27","emt28","emt29","emt30","emt31","emt32","emt33","emt34","emt35","emt36","emt37","emt38","emt39","emt40","emt41","emt42","emt43","emt44","emt45","emt46","emt47","emt48","emt49","emt50","emt51","emt52","emt53","emt54","emt55","emt56","emt57","emt58","emt59","emt60"}
gSoundEmitterPositions={{-34.501820,-2.745420,-11.845739},{-79.557938,-0.000000,1.835643},{-179.351593,-1.875124,1.645756},{-179.351593,-1.875124,1.645756},{-9.479267,-0.000000,-2.248839},{-1.771667,-0.000000,2.347483},{57.685104,-2.986562,-58.026970},{-37.328007,-3.404095,-0.246476},{-54.438046,-2.877837,30.954058},{-30.368822,-2.469231,-33.033920},{32.548939,-2.700276,-37.814537},{-33.527245,-3.116081,-11.320180},{132.915329,-4.007683,-118.504578},{132.915329,-4.007683,-118.504578},{-1.719807,-0.000000,3.347189},{-1.965025,-0.000000,4.364202},{-2.171625,-0.000000,5.881331},{-2.020918,-0.000000,6.366313},{-1.885633,-0.000000,7.027786},{-37.270939,-3.423660,-0.301831},{-2.008939,-0.000000,1.896740},{-29.986479,-2.190553,-33.200272},{-2.569049,-0.000000,1.660343},{-3.330672,-0.000000,1.618744},{-33.932728,0.861009,-14.321043},{-4.007217,-0.000000,1.596008},{-4.999723,-0.000000,1.790151},{-1.846931,-0.000000,8.136511},{-5.835466,-0.000000,1.726959},{-1.531549,-0.000000,8.353496},{-6.867738,-0.000000,1.713369},{-1.312039,-0.000000,9.042771},{-8.192620,-0.000000,1.852457},{-1.836934,-0.000000,10.522897},{-9.186561,-0.000000,1.817939},{-1.929190,-0.000000,11.671301},{-10.078955,-0.000000,1.707725},{-1.921479,-0.000000,12.318409},{-11.144773,-0.000000,1.682763},{-2.149908,-0.000000,14.025126},{-12.026814,-0.000000,1.628878},{-13.171659,-0.000000,1.599076},{-14.931591,-0.000000,1.687620},{-17.153421,-0.000000,1.811627},{-20.307222,-0.000000,1.930817},{-2.148632,-0.000000,15.640233},{-2.103099,-0.000000,17.291697},{-2.182349,-0.000000,16.747002},{-2.027389,-0.000000,17.991289},{-1.914886,-0.000000,18.929188},{-1.887625,-0.000000,19.839075},{-1.607615,-0.000000,20.566446},{-1.705121,-0.000000,21.748552},{-20.684217,-0.000000,1.312660},{-0.209051,-0.000000,17.709719},{-0.744054,-0.000000,12.465975},{-0.329400,-0.000000,6.651788},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000},{-0.000000,-0.000000,-0.000000}}
gSoundEmitterSamples={"Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/zombie.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/skid.ogg","Data/Sounds/engine.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/colt45.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","Data/Sounds/bodyhit.ogg","","","","",""}
gSoundEmitters={}
for i=1,#gSoundEmitterNames,1 do
	gSoundEmitters[i]=make(ig3d_sound_emitter, gSoundEmitterNames[i])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_POSITION, gSoundEmitterPositions[i][1],gSoundEmitterPositions[i][2],gSoundEmitterPositions[i][3])
	setSound_emitterInfo(gSoundEmitters[i], IG3D_SAMPLE, gSoundEmitterSamples[i])
end
gNumSoundEmitters=#gSoundEmitterNames
gGroups={}
gNumGroups=0
gTextboxFonts={"Data/FontPngs/default32_1.png"}
gTextboxPositions={{50,50}}
gTextboxSizes={10}
gTextboxColors={{1.000000,1.000000,1.000000,1.000000}}
gTextboxes={}
for i=1,#gTextboxFonts,1 do
	gTextboxes[i]=make(ig3d_text_box, gTextboxFonts[i])
	setText_boxInfo(gTextboxes[i], IG3D_POSITION, gTextboxPositions[i][1],gTextboxPositions[i][2])
	setText_boxInfo(gTextboxes[i], IG3D_SIZE, gTextboxSizes[i])
	setText_boxInfo(gTextboxes[i], IG3D_COLOR, gTextboxColors[i][1],gTextboxColors[i][2],gTextboxColors[i][3], gTextboxColors[i][4])
end
gNumTextboxes=#gTextboxFonts
setSceneInfo(IG3D_TINT_COLOR, 1.000000,1.000000,1.000000)
setSceneInfo(IG3D_FOG, false,0.562000,0.488000,0.050000,-0.000000,200.000000)
setSceneInfo(IG3D_BACKGROUND_COLOR, 0.562000,0.488000,0.050000)
setSceneInfo(IG3D_FOV, true, 90.000000)
setLightInfo(1, IG3D_ENABLED, true)
setLightInfo(1, IG3D_POSITION, 250.000000,250.000000,250.000000,1.000000)
setLightInfo(1, IG3D_AMBIENT, 0.400000,0.400000,0.400000,1.000000)
setLightInfo(1, IG3D_DIFFUSE, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_SPECULAR, 1.000000,1.000000,1.000000,1.000000)
setLightInfo(1, IG3D_CONSTANT_ATTENUATION, 1.000000)
setLightInfo(1, IG3D_LINEAR_ATTENUATION, -0.000000)
setLightInfo(1, IG3D_QUADRATIC_ATTENUATION, -0.000000)
setLightInfo(1, IG3D_SPOTLIGHT, -0.000000,-0.000000,-0.000000,180.000000,-0.000000)
setLightInfo(2, IG3D_ENABLED, false)
setLightInfo(3, IG3D_ENABLED, false)
setLightInfo(4, IG3D_ENABLED, false)
setLightInfo(5, IG3D_ENABLED, false)
setLightInfo(6, IG3D_ENABLED, false)
setLightInfo(7, IG3D_ENABLED, false)
setLightInfo(8, IG3D_ENABLED, false)
-- End of auto-script
]] -- end of zgsLoadScript[4]
-- init files and game func in [5]
zgsLoadScript[5]=[[
dofile(gameroot.."Data/Scripts/RTS_Functions/RTS_Init.lua")
-- handle_zgs in RTS_Functons/RTS_Game.lua
game_func = handle_RTS
]]
function AutoLevelName()
Brnd = BuildingsFld:value()
Hrnd = HumansFld:value()
Grnd = GunsFld:value()
Crnd = CarsFld:value()
Zrnd = ZombiesFld:value()
levelName = "B"..Brnd.."_".."H"..Hrnd.."_".."G"..Grnd.."_".."C"..Crnd.."_".."Z"..Zrnd.."_ZGS"
LevelNameFld:value(levelName) 
ZGS_Maker:redraw()
return levelName
end
function updateTotal()
totalObjs= BuildingsFld:value()+HumansFld:value()+GunsFld:value()+CarsFld:value()+ZombiesFld:value()

TotalFld:value(totalObjs)
end
function randomizeit()
Brnd = math.random(1,20)
Hrnd = math.random(1,20)
Grnd = math.random(1,20)
Crnd = math.random(1,20)
Zrnd = math.random(1,20)
BuildingsFld:value(Brnd)
HumansFld:value(Hrnd)
GunsFld:value(Grnd)
CarsFld:value(Crnd)
ZombiesFld:value(Zrnd)
levelName = "B"..Brnd.."_".."H"..Hrnd.."_".."G"..Grnd.."_".."C"..Crnd.."_".."Z"..Zrnd.."_ZGS"
LevelNameFld:value(levelName)
updateTotal()
PlayBtn:hide()
end
-- create houses first to clear housePos tables, entities exist in the remaining spaces

function createBuildings()
local i,ii,iii
numwalls = 0
maxBuildings = BuildingsFld:value()


	for iii = 1,maxBuildings,1 do	
	    numbuildings = numbuildings + 1
		local rndB = math.random(1,#zgsBuildings)
		local	tObj, tNam = "Buildings/"..zgsBuildings[rndB]..".wtf", "building"..numbuildings
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam )
		table.insert(zObjectColls,true)
-- set position	
	
	local rndPos = math.random(1,#housePos)
	local blx = housePos[rndPos][1]
	local blz = housePos[rndPos][2]
	table.insert(zObjectPositions,{blx,3.0,blz})
	table.remove(housePos,rndPos)
	local HouseWallMap={}
	table.insert(HouseWallMap,{8,0})
	table.insert(HouseWallMap,{-8,0})
	table.insert(HouseWallMap,{0,-8})
	table.insert(HouseWallMap,{0,8})

	
	
	for i =1,4,1 do
	wallWTF = nil
	 rndWallChance = math.random(1,4)
	if rndWallChance ~= 1 then 
	rndWall = math.random(1,#HouseWallMap)
	local tlx = HouseWallMap[rndWall][1]
	local tlz = HouseWallMap[rndWall][2]
	
	
	if tlz ~= 0 then
	nwall =   math.random(1,#zgsWallsWide)
	wallWTF = zgsWallsWide[nwall] -- "brickwall8x1xp5"
	wlx = blx
	wlz = blz+tlz
	end
	
	if tlx ~= 0 then
	nwall =   math.random(1,#zgsWallsLong)
	wallWTF =   zgsWallsLong[nwall]
	wlx = blx+tlx
	wlz = blz
	end
	
	

	
		
		table.insert(zObjectPositions,{wlx,3.0,wlz})
		numwalls = numwalls + 1
		local	tObj, tNam = "Buildings/"..wallWTF..".wtf", "wall"..numwalls
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam )
		table.insert(zObjectColls,true)
		table.remove(HouseWallMap,rndWall) 
		end
	
	end
	
	end
	
	
	
end
-- generate entity spaces from the remaining empty housePos values 

function EntityLocations()

for i=1,#housePos-1,1 do
	local ex,ez = housePos[i][1],housePos[i][2]
	print(ex,ez)
	for ii = ex-28,ex+28,4 do
		for iii = ez-28,ez+28,4 do
		table.insert(entityPos,{ii,iii})
		end
	end
end
end
-- get positions from a defined table of spaces that don't have houses
function setEntityPos()

local rndPos = math.random(1,#entityPos)
plx = entityPos[rndPos][1]
plz = entityPos[rndPos][2]
table.remove(entityPos,rndPos) 
table.insert(zObjectPositions,{plx,3.0,plz})
return plx,plz
end
-- generate zombies
function createZombies()
maxZombies=ZombiesFld:value()
	for ii = 1,maxZombies,1 do
		numzombies=numzombies+1
		local rndZ = math.random(1,#zgsZombies)
		local tObj,tNam = "Characters/"..zgsZombies[rndZ]..".wtf", zgsZombies[rndZ]..numzombies
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam)
		table.insert(zObjectColls,true)
		
	end
			
end
-- generate humans and guns	
function createEntities()	
maxHumans=HumansFld:value()
maxCars=CarsFld:value()
maxGuns=GunsFld:value()
		
for i = 1,maxHumans,1 do
	local rndH = math.random(1,#zgsHumans)
	local tObj,tNam ="Characters/"..zgsHumans[rndH]..".wtf" , "human"..i
	table.insert(zObjectWTFs, tObj)
	table.insert(zObjectNames,tNam)
	table.insert(zObjectColls,true)
	--plx,plz = setEntityPos()
end

for ii = 1,maxGuns,1 do
	-- one gun for every human, wether they carry it or not
	local rndW = math.random(1,#zgsWeapons)
	local tObj,tNam = "Weapons/"..zgsWeapons[rndW]..".wtf", "gun"..ii+1
	table.insert(zObjectWTFs, tObj )
	table.insert(zObjectNames,tNam)
	table.insert(zObjectColls,true)
		--plx,plz = setEntityPos()	
	end
	

	
	-- generate  cars
	for iii = 1,maxCars,1 do
	
	 plx,plz = setEntityPos()
		numcars = numcars + 1 
		local rndC = math.random(1,#zgsCars)
		local	tObj, tNam = "Vehicles_land/"..zgsCars[rndC]..".wtf"  , "car"..numcars
		table.insert(zObjectWTFs,tObj)
		table.insert(zObjectNames,tNam )
		table.insert(zObjectColls,true)
			--plx,plz = setEntityPos()
	end
end
function getAllObjectInfo()


local o,n,p,r,s,c,h = 'gObjectWTFs={', 'gObjectNames={', 'gObjectPositions={', 'gObjectRotations={', 'gObjectSizes={', 'gObjectColls={', 'gObjectHUDs={'

for i=1,#zObjectWTFs,1 do
local x,y,z=zObjectPositions[i][1],zObjectPositions[i][2],zObjectPositions[i][3]

o=o..'"'..zObjectWTFs[i]..'"';
p=p.."{"..x..","..y..","..z.."}";
n=n..'"'..zObjectNames[i]..'"';
c=c..tostring(zObjectColls[i]);
r=r.."{0.0,0.0,0.0}";
s=s.."{100.0,100.0,100.0}";
h=h.."false";
	if i ~= #zObjectWTFs then
	o=o..",";
	p=p..",";
	n=n..",";
	c=c..",";
	r=r..",";
	s=s..",";
	h=h..",";
	else
	
	o=o.."\}".."\n"
	p=p.."\}".."\n"
	n=n.."\}".."\n"
	c=c.."\}".."\n"
	r=r.."\}".."\n"
	s=s.."\}".."\n"
	h=h.."\}".."\n"
	objectInfoOut = o..n..p..r..s..c..h
	--print(objectInfoOut)
	end
end
return objectInfoOut
	
end
-- saveLoadScript
function saveLoadScript()


math.randomseed(os.time())
createBuildings();
EntityLocations();
createEntities();
createZombies();

for i=1,#zObjectWTFs,1 do
	setEntityPos()
	end
	
allobjectinfo = getAllObjectInfo();
zgsLoadScriptOut = "-".."- Begin of auto-script\n"..zgsLoadScript[1]..zgsLoadScript[2]..allobjectinfo..zgsLoadScript[3]..zgsLoadScript[4]..zgsLoadScript[5]


	if  string.len(LevelNameFld:value()) <= 4  then
	levelName  = AutoLevelName() 
	LevelNameFld:add(leveName)
	print(levelName)
	end
	

	levelName = LevelNameFld:value()
	




ig3d_CreateDirectory_s(gameroot.."Data/Levels/"..levelName) --create folder 



levelFile = gameroot.."Data/Levels/"..levelName.."/load script.lua"




local f=io.open(levelFile, "w")
if f ~= nil then 
	f:write(zgsLoadScriptOut)

	f:close()
	end



--print(zgsLoadScriptOut)

PlayBtn:show()
end
function playZGS()
cLevel = ig3d_GetLevelName__s()


if Fl:event_key() == 32 then return end

zgsMakerLevel = "Data/Levels/"..LevelNameFld:value()
--if cLevel ~= zgsMakerLevel then
loadLevel(zgsMakerLevel)
--end



end
do ZGS_Maker= fltk:Fl_Double_Window(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "ZGS_Maker")
ZGS_Maker:label(gLabelTable[#gLabelTable])
ZGS_Maker:resize(632,50,186,164)
ZGS_Maker:when(6)
--ZGS_Maker:show()
do BuildingsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Buildings:")
BuildingsFld:label(gLabelTable[#gLabelTable])
BuildingsFld:callback(updateTotal)
BuildingsFld:resize(60,3,25,17)
BuildingsFld:labelsize(11)
BuildingsFld:minimum(1)
BuildingsFld:maximum(20)
BuildingsFld:step(1)
BuildingsFld:value(1)
BuildingsFld:textsize(11)
end

do HumansFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Humans:")
HumansFld:label(gLabelTable[#gLabelTable])
HumansFld:callback(updateTotal)
HumansFld:resize(60,23,25,17)
HumansFld:labelsize(11)
HumansFld:minimum(1)
HumansFld:maximum(20)
HumansFld:step(1)
HumansFld:value(1)
HumansFld:textsize(11)
end

do GunsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Guns:")
GunsFld:label(gLabelTable[#gLabelTable])
GunsFld:callback(updateTotal)
GunsFld:resize(60,43,25,17)
GunsFld:labelsize(11)
GunsFld:minimum(1)
GunsFld:maximum(20)
GunsFld:step(1)
GunsFld:value(1)
GunsFld:textsize(11)
end

do CarsFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Cars:")
CarsFld:label(gLabelTable[#gLabelTable])
CarsFld:callback(updateTotal)
CarsFld:resize(145,3,25,17)
CarsFld:labelsize(11)
CarsFld:minimum(1)
CarsFld:maximum(20)
CarsFld:step(1)
CarsFld:value(1)
CarsFld:textsize(11)
end

do ZombiesFld= fltk:Fl_Value_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Zombies:")
ZombiesFld:label(gLabelTable[#gLabelTable])
ZombiesFld:callback(updateTotal)
ZombiesFld:resize(145,23,25,17)
ZombiesFld:labelsize(11)
ZombiesFld:minimum(1)
ZombiesFld:maximum(20)
ZombiesFld:step(1)
ZombiesFld:value(1)
ZombiesFld:textsize(11)
end

do LevelNameFld= fltk:Fl_Input(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Level Name:")
LevelNameFld:label(gLabelTable[#gLabelTable])
LevelNameFld:resize(15,128,160,17)
LevelNameFld:labelsize(11)
LevelNameFld:align(1)
LevelNameFld:textsize(11)
end

do TotalFld= fltk:Fl_Value_Output(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Total::")
TotalFld:label(gLabelTable[#gLabelTable])
TotalFld:resize(145,43,25,17)
TotalFld:labelsize(11)
TotalFld:textsize(11)
end

do SaveBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Save")
SaveBtn:label(gLabelTable[#gLabelTable])
SaveBtn:callback(saveLoadScript)
SaveBtn:resize(25,90,60,20)
SaveBtn:labelsize(10)
end

do PlayBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Play")
PlayBtn:label(gLabelTable[#gLabelTable])
PlayBtn:callback(playZGS)
PlayBtn:resize(110,90,60,20)
PlayBtn:labelsize(10)
end

do Randomize= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Randomize")
Randomize:label(gLabelTable[#gLabelTable])
Randomize:callback(randomizeit)
Randomize:resize(25,65,60,20)
Randomize:labelsize(10)
end

do AutoBtn= fltk:Fl_Button(0,0,0,0,"")
if gLabelTable==nil then gLabelTable={} end
table.insert(gLabelTable, "Auto Name")
AutoBtn:label(gLabelTable[#gLabelTable])
AutoBtn:callback(AutoLevelName)
AutoBtn:tooltip("Auto Name Based On Fields Values")
AutoBtn:resize(110,65,60,20)
AutoBtn:labelsize(10)
end
end
ZGS_Maker:show()

ZGS_Maker:show();
PlayBtn:hide();
ZGS_Maker:make_current();
--end
Fl:run()
