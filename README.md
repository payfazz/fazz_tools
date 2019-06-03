# Flutter Debugging Tools

This library depend on fazz_tools_ui as GUI(Graphical User Interface) for showing the output to developer from the app, check fazz_tools_ui repo at <a href="https://github.com/payfazz/fazz_tools_ui">here</a>

# Features

1. Log print
2. Show http request to web service

# How To Install ?

1. Open your pubspec.yaml
2. Paste this code inside depedencies scope
   <pre>
   fazz_tools:
     git:
       url: https://github.com/payfazz/fazz_tools.git
   </pre>
3. The library already installed

# How to use it ?

See examples folder in this repository, but if you want some explaination follow some steps below :

1. Create object fazz tools in specific file
   <pre>
     import 'package:fazz_tools/fazz_tools.dart';
     .............
     
     FazzTools fazzTools = FazzTools(host: {YOUR_CURRENT_IP_ADDRESS_NOT_LOCALHOST}, isDebug: true)
   </pre>
2. If you want to use object fazzTools just import from that file

<b>
  Note: if isDebug equal to false you want to build in production dont worry to remove this code, cause this code dont do anything in production
</b>

# Log

Log in this library similiar with console.log in javascript, here the features :

1. Print text
2. Print text and show it as table (you need to pass map data type)
3. Print group
4. Print start time and end time to check your execution time for the function or other

# If you find bug, or feature for this library please throw it as an issue. And we are need for contributor here :)
