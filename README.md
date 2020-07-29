# Projector
Forget the Simulator, swap your aspect ratio instead! Warning: This is an experimental project that shouldn’t be used in production.

## Installation
Drag [Source](https://github.com/aheze/Projector/tree/master/Projector/Source) into your project.

## How To Use
Inside SceneDelegate.swift, 

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
Projector is licensed under --TODO--
