# Copi_Lib
*Noita modding library focused on providing a wide variety of content with minimal impact on performance through a modules system.*

## Installation
To install, download the library or add it as a submodule to your own mod's repo, anywhere in your mod folder. Initialize the library's dynamic file path system by typing `dofile_once("Mods/YOURMOD/Copi_Lib/CL_Init.lua").Init("FILEPATH/TO/LIBRARY/")`.

You may then load the required modules inside your files with a comma separated list of module names, such as `dofile_once("FILEPATH/TO/LIBRARY/CL_ModuleLoader.lua").DofileModules({"ModuleName", "ModuleName2"})`.

A list of modules will be featured below.

## Modules
Modules are single files used to organize and separate the contents of the library. With the Modules system, you don't need to load every single function for irrelevant content just to use one feature.
Below each module and it's functionality will be listed.

### Vec2
The Vec2 Module allows users to manipulate and work with 2 dimensional vectors with ease, which are frequently used in noita's 2D world environment. The Module provides a *Vec2 Metatable*, which can be used to perform many operations on 2D vectors. It also provides easy creation of Vec2 tables, from angle and distance values or x and y values.
```lua
-- Load the module
dofile_once("mods/YOURMODNAME/Copi_Lib/CL_ModuleLoader.lua").DofileModules({"Vec2"})

-- Get entity coordinates
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

-- Create a Vec2 using the coordinates
local position = Vec2:NewFromCoords(x, y)
-- Will output the values of 'x, y'
print(position)

-- Create a vec2 using a distance and an angle in degrees
local target = Vec2:NewFromAngleDeg(25, 30)
-- Will output the values of '21.651, 12.5'
print(target)

-- Create a vec2 using a distance and an angle in radians
local offset = Vec2:NewFromAngleRad(50, math.pi/4)
-- Will output the values '35.355, 35.355'
print(offset)

-- Add Vectors
local target_final = target + offset
-- Will output the values '57.006, 47.855'
print(target_final)