# Projector
### Forget the Simulator, swap your aspect ratio instead!

For a similar and newer SwiftUI project, check out https://github.com/YusukeHosonuma/SwiftUI-Simulator.

---

Projector is an experimental project (don't use it in production!) that lets you simulate *any* iPhone or iPad on your device. Because the simulator is slow, doesn't have a camera, and is terrible with gestures, I had to find an alternative. Here it is!

Projector works by directly modifying the root window.

![](https://raw.githubusercontent.com/aheze/DeveloperAssets/master/AdvancedProjector.png)


## Article
I wrote an article about this on [Medium](https://medium.com/macoclock/test-your-app-on-different-screen-sizes-without-the-simulator-ce1ebfdfac22?source=friends_link&sk=db88b92c6cbb4bc1675da8e7d3cb54f6)!

Also, for an easier-to-understand but simpler version, check out [ProjectorExample](https://github.com/aheze/ProjectorExample) (which follows along the Medium article linked above)!

## Installation
Drag [Source](https://github.com/aheze/Projector/tree/master/Projector/Source) into your project.

## How To Use
Inside SceneDelegate.swift, display the root window using Projector.

```Swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        /// ADD THIS
        projectorActivated = true
        
        if let rootWindow = self.window {
            let settings = ProjectorSettings()
            
            /// if true, the view will stop at the status bar's edge. If false, the view will go under the status bar.
            settings.shouldStopAtStatusBar = true
            
            /// for devices that are skinnier than the physical one, options are .left, .centered, ,right.
            /// for devices that are wider than the physical one, options are .top, .centered, ,bottom.
            settings.position = .right 
            
            /// device to project
            settings.defaultDeviceToProject = .iPhoneX
            
            /// show controls to have an on-screen control panel (allow to edit settings.position and settings.defaultDeviceToProject )
            settings.shouldShowControls = false
            
            Projector.display(rootWindow: rootWindow, settings: settings)
        }
        
    }
...
```

## License
Projector is licensed under the MIT license.

```
MIT License

Copyright (c) 2021 A. Zheng

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

![](https://komarev.com/ghpvc/?username=testing&label=Views)
