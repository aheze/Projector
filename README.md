# Projector
Forget the Simulator, swap your aspect ratio instead!
Warning: This is an experimental project that shouldn’t be used in production.

## Article
I wrote an article about this [on Medium](https://medium.com/macoclock/test-your-app-on-different-screen-sizes-without-the-simulator-ce1ebfdfac22?source=friends_link&sk=db88b92c6cbb4bc1675da8e7d3cb54f6)!

Also, for an easier-to-understandd but simpler version, check out [ProjectorExample](https://github.com/aheze/ProjectorExample) (which follows along the Medium article linked above)!

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
            settings.shouldStopAtStatusBar = true
            settings.position = .right
            settings.defaultDeviceToProject = .iPhoneX
            settings.shouldShowControls = false
            Projector.display(rootWindow: rootWindow, settings: settings)
        }
        
    }
...
```

## License
Projector is licensed under the MIT license.

 
MIT License

Copyright (c) 2020 zjohnzheng

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
