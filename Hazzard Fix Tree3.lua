-- Author:Scott
-- Name:Hazzard Fix Tree3
-- Description:
-- Icon:
-- Hide: no

local worldRootNode = getRootNode();
local Map = getChildAt(worldRootNode,0);

local Terrain = getChild(Map,"terrain");

local TreeGroup = getChild(Map,"TreesImport");
local DestGroup = getChild(Map,"trees_residential");


print("TreesImport group: "..TreeGroup);
print("Destination Group: "..DestGroup);

local numChildren = getNumOfChildren(TreeGroup);
local toMove = {};
local toMoveIndex=0;

for x=0, numChildren-1 do
local tree = getChildAt(TreeGroup,x);
    table.insert(toMove,tree);
end
for x,tree in ipairs(toMove) do
    print("-----------------------------------------------------");
    print(tree);
    setScale(tree,1,1,1);
    local tx,ty,tz = getTranslation(tree);
    print("Tree translation: "..tx..","..ty..","..tz);
    local wx,wy,wz = localToWorld(TreeGroup,tx,ty,tz);
    print("world translation: "..wx..","..wy..","..wz);  
    local worldHeight = getTerrainHeightAtWorldPos(Terrain,wx,wy,wz);  
    print("world height at translation:"..worldHeight);
    unlink(tree);
    link(DestGroup,tree);
    setTranslation(tree,wx,worldHeight,wz);
    print("-----------------------------------------------------");
end