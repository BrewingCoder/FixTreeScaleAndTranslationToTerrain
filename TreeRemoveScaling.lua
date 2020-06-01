-- Author: BrewingCoder
-- Name:TreeRemoveScalingAndFixVerticalTranslation
-- Description:  Sets all scaling to 1/1/1 on trees so they can be cut.  This is a short term fix.  
--              Next option is to import smaller trees (example: need oak_stage_2,pine_stage_1, etc.)
--              Then replace trees with like breed but different stage.
--              Note: This does allow non-logging trees to be cut down in the Hazzard map but isn't ideal
--              since it will add a more uniform look to tree lines.  Removing the variation scaling gave you
--              does impact the visual.  However, as we realized, scaling big tree down too far removes it's ability
--              to be cut because the LOD objects are scaled too small to be effective.
--              
-- Icon:
-- Hide: no

local treeFloatFix = 0;
local treeScaleFix = 0;
local totalCount = 0;

local worldRootNode = getRootNode();
local Map = getChildAt(worldRootNode,0);

-- Name of root terrain node, case sensitive.  Typically 'terrain'
local Terrain = getChild(Map,"terrain");

-- Parent node off root.  Actually trees should be 2 levels below.. 
-- Note that there are two 'trees' transform groups off the root node.  one must be renamed to something else.  Run this once
-- against 'trees' then change the following line to whatever you renamed the second trees to and run it once more.

local TreeGroups = getChild(ParentGroup,"trees");

local TreeGroupName = getName(TreeGroups);
print("Tree Group Name: "..TreeGroupName);

print("Looking for Trees...");
local numChildren = getNumOfChildren(TreeGroups);
print("Number of children under trees: "..numChildren);
for g=0, getNumOfChildren(TreeGroups)-1 do
    local TreeGroup = getChildAt(TreeGroups,g);
    local groupName = getName(TreeGroup);

    print("     ID:"..TreeGroup.."  Name:"..groupName);
    local gx,gy,gz = getTranslation(TreeGroups);
    local px,py,pz = getTranslation(TreeGroup);

    
    for n=0, getNumOfChildren(TreeGroup)-1 do
        local Tree = getChildAt(TreeGroup,n);
        local TreeName = getName(Tree);
        
        --We have to filter object name because there are non-tree objects under the trees transform group
        if( (string.match(TreeName,"maple") ~= nil) or
            (string.match(TreeName,"oak") ~= nil) or
            (string.match(TreeName,"birch") ~= nil) or
            (string.match(TreeName,"pine") ~= nil) or
            (string.match(TreeName,"spruce") ~= nil) or
            (string.match(TreeName,"poplar") ~= nil) )then
            
            if(Tree==180640) then
                print("   Tree Name: "..TreeName.."  ID: "..Tree);

                --Fix Scaling, set all scaling to 1/1/1
                local sx,sy,sz = getScale(Tree)
                print("             Scale: "..sx..","..sy..","..sz);
                if ((sx ~= 1) or (sy ~= 1) or (sz ~= 1)) then
                        setScale(Tree,1,1,1);
                        treeScaleFix = treeScaleFix +1;
                        print("          Returning Tree Scale to Zero...");
                end;
 
                --Fix the floating Trees; Lots of trees feet or yards above terrain level.
                local x,y,z = getTranslation(Tree);
                --local terrainHeight = getTerrainHeightAtWorldPos(Terrain,x+px+gx,y+py+gy,z+pz+gz);
                local terrainHeight = getTerrainHeightAtWorldPos(Terrain,px+x,py+y,pz+z);

                        print("          Terrain height: "..terrainHeight);
                        print("             Tree height: "..y);
                if y~= terrainHeight then
                    setTranslation(Tree,x,terrainHeight-py-gy-my,z);
                    treeFloatFix = treeFloatFix+1;
                    print("          Floating Tree Fix...");
                end;
                totalCount = totalCount+1;
            end;
        end;
    end;
end;
print("Total Trees Found: "..totalCount);
print("Tree Y axis fixed: "..treeFloatFix);
print("Tree Scale Fixed : "..treeScaleFix);