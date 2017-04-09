# Introduction
Team Foundation Build (TFBuild) task for easy updating of assembly information.

This build task updates all AssemblyInfo files while your build is running.
There is no more need to adjust each attribute of each project in your solution manually.
Just leave them as they are and let the build process do the work.

The build task can also be very helpful if you want to update your version number automatically.
For example, you can use _GitVersion.exe_ to calculate the next version number and then use this build task to add it to each _AssemblyInfo_ file
(yes, _GitVersion.exe_ also offers an AssemblyInfo update mechanism, but it does currently not let you define the schema of the *Version* and *FileVersion* attribute). 

# Release Notes
## 1.2.0 (09-Apr-2017)
- Added a *Custom attributes* field to update assembly attributes based on key-value pairs
- Improved logging to powershell console during build process

## 1.1.2 (11-Mar-2017)
- Fixed an issue where Visual Basic projects did not build properly due to invalid AssemblyInfo attribute content.

## 1.1.1 (04-Mar-2017)
- Fixed a issue where projects did not build properly when AssemblyInfo attributes were replaced with content containing an escape character.

## 1.1.0 (21-Jan-2017)
- Added _AssemblyDescription_ attribute to the list of attributes which can be updated during build process

## 1.0.0 (19-Dec-2016)
- Initial version

# Getting Started
1. Go to your build definition and edit it
2. Press `Add build Step` to open the task catalogue
3. Select the task `Update AssemblyInfo` within the `build` category and press `Add`
4. Move the task to the appropriate position via drag&drop (first position is always good :) )
5. Select the task and configure the attributes you want to update:
![buildtask-configuration](img/configuration.gif)

If an attribute is not configured (left empty) in the build task configuration, it will be skipped for update and therefore the original value will be kept.  

If a file does not contain a specific attribute, the attribute is not added to the file. This is to prevent a build failure in case of projects with multiple _AssemblyInfo_ files.


The build task updates all files that match the `File pattern`  in the `Root folder` recursive. 

If the file pattern is left empty, the build task updates all _AssemblyInfo.cs_ and _AssemblyInfo.vb_ files.

In case you have a _GlobalAssemblyInfo_ file, you can adjust the `File pattern` to e.g. _*AssemblyInfo.cs_ in order to update this one as well.

If you only want to update specific files, you can adjust the `Root folder` accordingly.

It is also possible to add the build task multiple times to update different files with different content.

You can also update any other assembly attribute via the *Custom attributes* field using the pattern 'AssemblyAttribute=value', each key-value pair separated by a semicolon (e.g. 'FirstNameAssemblyAttribute=John;LastNameAssemblyAttribute=Doe').