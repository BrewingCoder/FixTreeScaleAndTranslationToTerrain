# FixTreeScaleAndTranslationToTerrain
A Giants Editor LUA Script that sets all tree scales to 1.0 and then fixes their translation (relative position) to terrain height

#Installation
Either copy and paste the script file into Giants Editor or copy the script file to C:\Users\[Your Profile Name]\AppData\Local\GIANTS Editor 64Bit 8.1.0\scripts

#Why you need it
Some map authors use the same tree model for larger and smaller trees.  They do this by adjusting the scale property of the tree.  When this happens it also scales the LOD objects and attachments under the tree which are the mechanisms that provide the ability to cut it down.  When those objects scale too big or too small you notice things like not being able to cut the tree down, or when cutting with a chainsaw the cut marker doesn't align with the tree but is well outside the visual model.
This leads to major heartache on maps where you can't remove trees properly with forestry equipment.

Examples of this can be found in:  Hazzard County GA v1 (prevalent throughout non forestry areas) and Tyrolean ALps (not as prevalent, but exists)

