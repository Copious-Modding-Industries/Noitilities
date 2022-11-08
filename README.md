# **Noitilities**
*Noitilities is a Noita modding library focused on providing a wide variety of features with minimal overhead and excess files loaded through a modules system.*
***

## **Installation and usage**
The library may be installed and used in one of two methods, both with benefits and drawbacks.
The first method is placing an independent instance of the library in your mod, while the second is sharing an external copy among other mods.

### **Independent library**
* The independent library must be placed inside your mod, but will never be updated without your input. You can confidently use it without needing users to install external additional mods.
* To install, download the library or add it as a submodule to your own mod's repo, anywhere in your mod folder. Initialize the library's dynamic file path system by inserting this line in your `init.lua` file:
    ```lua
    dofile_once("Mods/YOURMOD/Noitilities/NL_Init.lua").Init("FILEPATH/TO/LIBRARY/")
    ```

* You may then load the required modules inside your files with a comma separated list of module names:
    ```lua
    dofile_once("FILEPATH/TO/LIBRARY/NL_ModuleLoader.lua").DofileModules({"ModuleName", "ModuleName2"})
    ```
### **Shared library** 
* The shared library mod must be installed by the user from any of the following links:
    * ~~[Steam Workshop](URLGOESHERE)~~ <sub>(Dead link)</sub>
    * ~~[Modworkshop Mirror](URLGOESHERE)~~ <sub>(Dead link)</sub>
    * ~~[Original github files](URLGOESHERE)~~ <sub>(Dead link)</sub>
* Using the shared library, you must keep your mod maintained as features may be deprecated or rewritten, rendering old code useless and broken. With the shared library, you can access all features of the library without needing to include it in your mod, saving file size while other mods use the same version.
* While not strictly necessary, you are encouraged to put a check in your `init.lua` file to make sure the library is loaded:
    ```lua
    if not ModIsEnabled("Noitilities") then --[[ Optional code to warn users ]] return end
    ```

* You may then load the required modules inside your files with a comma separated list of module names:
    ```lua
    dofile_once("Mods/Noitilities/NL_ModuleLoader.lua").DofileModules({"ModuleName", "ModuleName2"})
    ```
***
## **Modules**
* Modules are single files used to organize and separate the contents of the library. With the Modules system, you don't need to load every single function for irrelevant content just to use one feature.
Below each module and it's functionality will be listed.
### **Vec2**
* The Vec2 Module allows users to manipulate and work with 2 dimensional vectors with ease, which are frequently used in noita's 2D world environment. The Module provides a *Vec2 Metatable*, which can be used to perform many operations on 2D vectors. It also provides easy creation of Vec2 tables, from angle and distance values or x and y values.
In the context of this example, and when working with vectors as a whole, any single dimensional number (such as `2`, `6`, `-5`, `3`) is a scalar, while multiple dimensional numbers (such as `2,5`; `8,3`; `7,0`) are vectors.

    | Method            | Use                       | Description                                                                          |
    | ----------------- | ------------------------- | ------------------------------------------------------------------------------------ |
    | New               | `vec2.new(x, y)`          | Returns a new vector from 2 scalars                                                  |
    | Add               | `vec2 + vec2`             | Returns vector `a` plus vector `b`                                                   |
    | Sub               | `vec2 - vec2`             | Returns vector `a` minus vector `b`                                                  |
    | Mul               | `vec2 * scalar`           | Returns the vector cross product of vector `a` and `b`                               |
    | Div               | `vec2 / vec2`             | Returns vector `a` divided by vector `b`                                             |
    | DotProduct        | `vec2 * vec2`             | Returns the scalar dot product of vector `a` and `b`                                 |
    | Abs               | `vec2:Abs()`              | Returns the absolute vector `a`                                                      |
    | Magnitude         | `vec2:Magnitude()`        | Returns the scalar length of vector `a`                                              |
    | MagnitudeSquared  | `vec2:MagnitudeSquared()` | Returns the scalar length of vector `a` before being square rooted (more performant) |
    | Normalize         | `vec2:Normalize()`        | Returns the unit vector of vector `a` normalized                                     |
    | Equals comparison | `vec2 == vec2`            | Returns `true` if vectors `a` and `b` are identical                                  |
    | Tostring          | `tostring(vec2)`          | Returns the vector formatted as `'(x, y)'`                                           |
    | Call              | `vec2(x, y)`              | Returns a new vector from 2 scalars                                                  |
    | Unary sub         | `-vec2`                   | returns the vector flipped 180 degrees                                               |
    ```lua
    -- Load the module
    dofile_once("mods/YOURMODNAME/Noitilities/NT_ModuleLoader.lua").DofileModules({"Vec2"})

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
    local target_final_add = target + offset
    -- Will output the values '57.006, 47.855'
    print(target_final_add)

    -- Multiply Vector with a Scalar
    local target_final_msc = target * 2
    -- Will output the values '43.302, 25'
    print(target_final_msc)
    ```