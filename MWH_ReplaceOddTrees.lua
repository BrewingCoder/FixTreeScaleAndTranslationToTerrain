-- Author:Scott
-- Name:MWH_ReplaceOddTrees
-- Description:
-- Icon:
-- Hide: no

local worldRootNode = getRootNode();
local Map = getChildAt(worldRootNode,0);

-- Name of root terrain node, case sensitive.  Typically 'terrain'
local Terrain = getChild(Map,"terrain");

-- Parent node off root.  Actually trees should be 2 levels below.. 
-- Note that there are two 'trees' transform groups off the root node.  one must be renamed to something else.  Run this once
-- against 'trees' then change the following line to whatever you renamed the second trees to and run it once more.
local mapGroup = getChild(Map,"MidwestHorizon");
local treesGroup = getChild(mapGroup,"trees");

local pine_stage5_model = 30427;
local removeTrees= {}
local treeCount = 0;

function in_array(tbl, item)
    if tbl then
        for key, value in pairs(tbl) do
            if value == item then
                return key
            end
        end
    end
    return false
end


print("looking for all 'volumeTree' models and replacing with pine_stage_5");
for n=0, getNumOfChildren(treesGroup)-1 do
    local treeGroup = getChildAt(treesGroup,n);
    local treeGroupName = getName(treeGroup);
    print("tree group name: "..treeGroupName);
    for x=0, getNumOfChildren(treeGroup)-1 do
        local treeGroup2 = getChildAt(treeGroup,x);
        if(getName(treeGroup2)=='Lod distance 21') then
            print(".....group name: ".. getName(treeGroup2));
            for y=0, getNumOfChildren(treeGroup2)-1 do
                local tree = getChildAt(treeGroup2,y);
                local treeName = getName(tree);
                print(".........tree name:" .. treeName);
                --local treeName = getName(tree);
                if(treeName == "volumeTree") then   
                    if in_array(removeTrees,tree) == false then
                        removeTrees[treeCount+1] = tree;
                        treeCount=treeCount+1;

                        local newTree = clone(pine_stage5_model, true);
                        local tx,ty,tz = getTranslation(tree);
                        local rx,ry,rz = getRotation(tree);
                        setRotation(newTree,rx,ry,rz);
                        setTranslation(newTree,tx,ty,tz);
                        link(treeGroup2,newTree);
                    end
                end
            end
        end
    end
end

if removeTrees then
    for key,value in pairs(removeTrees) do
        delete(value)
    end
end

