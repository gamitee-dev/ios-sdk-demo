//
//  SceneDelegate.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 01/12/2023.
//
import UIKit
import JoynedMobileSDK
///
///
///
class SceneDelegate : UIResponder
{
    var window : UIWindow?
}
extension SceneDelegate : UISceneDelegate
{
    // Deeplink or Universial Link Open when app is start.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if let _ = (scene as? UIWindowScene)
        {
            
        }
        
        // Universial link Open when app is start.
        if let userActivity = connectionOptions.userActivities.first
        {
            if userActivity.activityType == NSUserActivityTypeBrowsingWeb , let urlinfo = userActivity.webpageURL {
                logger.debug("Universial Link Open at SceneDelegate on App Start ::::::: \(String(describing: urlinfo))")
            }
        }
        
        // Deeplink Open when app is start.
        if let urlContext = connectionOptions.urlContexts.first
        {
            logger.debug("Deeplink Link Open at SceneDelegate on App Start ::::::: \(String(describing: urlContext))")
        }
        
        JoynedSDK.scene(scene, willConnectTo: session, options: connectionOptions)
    }
    
    // Deeplink link Open when app is onPause
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) // Directly when onPause
    {
        if let urlinfo = URLContexts.first?.url {
            logger.debug("Deeplink Open at SceneDelegate on App Pause ::::::: \(String(describing: urlinfo))")
        }
        JoynedSDK.scene(scene, openURLContexts: URLContexts)
    }
    // Universial link Open when app is onPause
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) // Directly when onPause
    {
        // This will allow us to check if we are coming from a universal link
        // and get the url with its components
        
        // The activity type (NSUserActivityTypeBrowsingWeb) is used
        // when continuing from a web browsing session to either
        // a web browser or a native app.
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb , let urlinfo = userActivity.webpageURL
        {
            logger.debug("Universial Link Open at SceneDelegate on App Pause  ::::::: \(urlinfo)")
        }
        JoynedSDK.scene(scene, continue: userActivity)
    }
}
extension SceneDelegate : UIWindowSceneDelegate
{
}
