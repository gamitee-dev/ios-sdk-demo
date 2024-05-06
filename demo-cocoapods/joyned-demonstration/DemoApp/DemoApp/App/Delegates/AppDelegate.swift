//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Arkadi Yoskovitz on 01/12/2023.
//
import Foundation
import UIKit
// import Firebase
import JoynedMobileSDK
///
///
///
@main
class AppDelegate : UIResponder
{
    
}

extension AppDelegate : UIApplicationDelegate
{
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        logger.debug()
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        logger.debug()
        
        // Override point for customization after application launch.
        // FirebaseApp.configure()
        
        DataService.shared.triggerDataLoad()
        
        JoynedSDK.delegate = self
        
        // DEVELOPER
        // JoynedSDK.activate(with: "Z2FtaXRlZS1kZW1vOmm3HXn4IQ")
        // STAGING
        // JoynedSDK.activate(with: "dm95YWdlLWRlbW86giVSNSnTY8D-hwUqvr6PNTGGfZ_PphmGZUvdPi8_Shw")
        // PRODUCTION
        JoynedSDK.activate(with: "dm95YWdlLWRlbW86-pL7Mtc8q13aFLrDSZFz2rmT021NdWGqwNpAwsOnRI0")
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>)
    {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
extension AppDelegate : JoynedSDKDelegate
{
    func mobileSDKDidActivateSuccessfully()
    {
        logger.debug()
    }
    
    func mobileSDKDidFailToActivate()
    {
        logger.debug()
    }
    
    func mobileSDKLocaleForPresentingContent(given computedLocale: String) -> String
    {
        logger.debug()
        return computedLocale.replacingOccurrences(of: "_", with: "-")
    }
    
    func mobileSDKDidTriggerNavigation(for navigationPayload: JoynedMobileSDK.JoynedOfferingResponse)
    {
        logger.debug()
        guard let targetUrl = navigationPayload.directUrl      else { return }
        guard let keyWindow = UIApplication.shared.v_keyWindow else { return }
        
        if let topVC = keyWindow.v_topViewController {
            topVC.tabBarController?.selectedIndex = 0
        }
        
        if let topVC = keyWindow.v_topViewController {
            topVC.navigationController?.popToRootViewController(animated: true)
        }
        
        guard let vc = keyWindow.v_topViewController             else { return }
        guard let dealsVC = vc as? DealsFeedViewController       else { return }
        guard let item = DataService.shared.item(for: targetUrl) else { return }
        
        logger.info(targetUrl)
        
        dealsVC.present(selected: item)
        
        JoynedSDK.minimizeDisplay()
    }
}
// MARK: - Lifecycle methods
fileprivate extension AppDelegate
{
    func setupApplicationNotificationObserver() {
        
        let pairs : [NSNotification.Name: Selector] = [
            UIApplication.didEnterBackgroundNotification : #selector(didEnterBackground (_:)),
            UIApplication.willEnterForegroundNotification: #selector(willEnterForeground(_:)),
            UIApplication.didBecomeActiveNotification    : #selector(didBecomeActive    (_:)),
            UIApplication.willResignActiveNotification   : #selector(willResignActive   (_:)),
            UIApplication.willTerminateNotification      : #selector(willTerminate      (_:)),
        ]
        
        let center = NotificationCenter.default
        for (name,selector) in pairs
        {
            center.addObserver(self, selector: selector, name: name, object: nil)
        }
    }
    // UIApplication notification handling
    @objc private func didEnterBackground (_ notification: Notification) { }
    @objc private func willEnterForeground(_ notification: Notification) { }
    @objc private func didBecomeActive    (_ notification: Notification) { }
    @objc private func willResignActive   (_ notification: Notification) { }
    @objc private func willTerminate      (_ notification: Notification) { }
   
    func setupSceneNotificationObserver()
    {
        let aKey = "UIApplicationSceneManifest"
        let info = Bundle.main.infoDictionary
        
        guard #available(iOS 13.0, *) , let withManifest = info?.contains(where: { $0.key == aKey }) , withManifest else { return }
        
        let pairs : [NSNotification.Name: Selector] = [
            UIScene.willConnectNotification        : #selector(sceneWillConnect        (_:)),
            UIScene.didDisconnectNotification      : #selector(sceneDidDisconnect      (_:)),
            UIScene.didActivateNotification        : #selector(sceneDidActivate        (_:)),
            UIScene.willDeactivateNotification     : #selector(sceneWillDeactivate     (_:)),
            UIScene.willEnterForegroundNotification: #selector(sceneWillEnterForeground(_:)),
            UIScene.didEnterBackgroundNotification : #selector(sceneDidEnterBackground (_:))
        ]
        
        let center = NotificationCenter.default
        for (name,selector) in pairs
        {
            center.addObserver(self, selector: selector, name: name, object: nil)
        }
    }
     
    // UIScene notification handling
    @objc private func sceneWillEnterForeground (_ notification: Notification) { }
    @objc private func sceneDidEnterBackground  (_ notification: Notification) { }
    @objc private func sceneWillConnect         (_ notification: Notification) { }
    @objc private func sceneDidDisconnect       (_ notification: Notification) { }
    @objc private func sceneDidActivate         (_ notification: Notification) { }
    @objc private func sceneWillDeactivate      (_ notification: Notification) { }
}
