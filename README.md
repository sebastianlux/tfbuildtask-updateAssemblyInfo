# tfbuildstep-updateAssemblyInfo
Team Foundation Build (TFBuild) step for easy updating of assembly information.

This build step updates all AssemblyInfo files while your build is running.
There is no more need to adjust each attribute of each project in your solution manually.
Just leave them as they are and let the build process do the work.

The build step can also be very helpful if you want to update your version number automatically.
For example, you can use _GitVersion.exe_ to calculate the next version number and then use this build step to add it to each _AssemblyInfo_ file
(yes, _GitVersion.exe_ also offers an AssemblyInfo update mechanism, but it does currently not let you define the schema of the _Version_ and `FileVersion_ attribute). 

## Which Files are Updated
The build step updates all files that match the `file pattern`  in the `root folder` recursive. 

If the file pattern is left empty, the build step updates all _AssemblyInfo.cs_ and _AssemblyInfo.vb_ files.

In case you have a _GlobalAssemblyInfo_ file, you can adjust the `file pattern` to e.g. _*AssemblyInfo.cs_ in order to update this one as well.

If you only want to update specific files, you can adjust the `root folder` accordingly.

It is also possible to add the build step multiple times to update different files with different content.

## Assembly Attributes
The following assembly information attributes can be updated with user defined values during build.
```
[assembly: AssemblyProduct("")]
[assembly: AssemblyCopyright("")]
[assembly: AssemblyCompany("")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyVersion("")]
[assembly: AssemblyFileVersion("")]
[assembly: AssemblyInformationalVersion("")]
```
If an attribute is not configured (left empty) in the build step configuration, it will be skipped for update and therefore the original value will be kept.

If a file does not contain a specific attribute, it is also not updated (not added to the file).
