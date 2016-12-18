# Introduction
Team Foundation Build (TFBuild) task for easy updating of assembly information.

This build task updates all AssemblyInfo files while your build is running.
There is no more need to adjust each attribute of each project in your solution manually.
Just leave them as they are and let the build process do the work.

The build task can also be very helpful if you want to update your version number automatically.
For example, you can use _GitVersion.exe_ to calculate the next version number and then use this build task to add it to each _AssemblyInfo_ file
(yes, _GitVersion.exe_ also offers an AssemblyInfo update mechanism, but it does currently not let you define the schema of the _Version_ and `FileVersion_ attribute). 

## Configuration

1. Go to your build definition and edit it
2. Press `Add build Step` to open the task catalogue
3. Select the task `Update AssemblyInfo` within the `build` category and press `Add`
4. Move the task to the appropriate position via drag&drop (first position is always good :) )
5. Select the task and configure the attributes you want to update:
![buildtask-configuration](images/configuration.png)

If an attribute is not configured (left empty) in the build task configuration, it will be skipped for update and therefore the original value will be kept.

If a file does not contain a specific attribute, the attribute is not added to the file. This is to prevent a build failure in case of projects with multiple _AssemblyInfo_ files.

## Which Files are Updated
The build task updates all files that match the `File pattern`  in the `Root folder` recursive. 

If the file pattern is left empty, the build task updates all _AssemblyInfo.cs_ and _AssemblyInfo.vb_ files.

In case you have a _GlobalAssemblyInfo_ file, you can adjust the `File pattern` to e.g. _*AssemblyInfo.cs_ in order to update this one as well.

If you only want to update specific files, you can adjust the `Root folder` accordingly.

It is also possible to add the build task multiple times to update different files with different content.