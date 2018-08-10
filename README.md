<p align="center">
  <img src ="https://s3.eu-west-2.amazonaws.com/welpnathan-images/mew.png"/>
</p>

# Introduction
[![Code Standard](https://img.shields.io/badge/code%20style-lua--users-brightgreen.svg)](http://lua-users.org/wiki/LuaStyleGuide)
[![Experimental Mode](https://img.shields.io/badge/experimental-off-brightgreen.svg)](https://en.help.roblox.com/hc/en-us/articles/115003766763-Experimental-Mode)
[![Current Libraries](https://img.shields.io/badge/libraries-0-red.svg)](http://localhost)
![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg)


These modules were designed to help make development on the Roblox platform as easy and simple as possible. The singular RemoteEvent and RemoteFunction was designed to make your ReplicatedStorage as less cluttered as possible cause lets face it, no one likes things being disorganised.

## How does it work?
Roblox was very kind and added the instance of [ModuleScripts](https://wiki.roblox.com/index.php?title=API:Class/ModuleScript) in Version [0.131](https://anaminus.github.io/api/diff.html#v0.131) (late 2013), this made development a lot easier and reduced the amount of global variables needed to call functions and such. This project utilises these ModuleScripts to give you a simple library to use. Installation of the library is incredibly simple and usually takes a few seconds to add into your game.

## Getting started
Installing the library can be done by the Roblox HttpService which simply requests the installation lua file from the GitHub directory. For this, the ``HttpService`` needs to be enabled to request the data. If this is not enabled, it will cause an error and the installation will not proceed. You can enable the service by going to the Game Settings tab in Roblox Studio.
```lua
loadstring(game:GetService('HttpService'):GetAsync("localhost"))
```
