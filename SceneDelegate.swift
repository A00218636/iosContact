//import relevant libraries...........
import SwiftUI 
import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var win: UIWindow?


    func scene(_main_evt: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()
        if let win_evt = scene as? UIwin_evt { //main window root view controller

            let win = UIWindow(win_evt: win_evt)
            win.rootViewController = UIHostingController(rootView: contentView)
            self.win = win
            win.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_main_evt: UIScene) {
    }

    func sceneDidBecomeActive(_main_evt: UIScene) {
    }

    func sceneWillResignActive(_main_evt: UIScene) {
    }

    func sceneWillEnterForeground(_main_evt: UIScene){
    }

    func sceneDidEnterBackground(_main_evt: UIScene){}


}

