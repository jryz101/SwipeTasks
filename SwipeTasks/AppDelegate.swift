//  AppDelegate.swift
//  SwipeTasks
//  Created by Jerry Tan on 01/06/2019.
//  Copyright © 2019 Starknet Technologies®. All rights reserved.


import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //Tells the delegate that the launch process is almost done and the app is almost ready to run.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Locate the local URL of the Realm file. Mutually exclusive with inMemoryIdentifier and syncConfiguration.
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        ////REALM-1
        //Do-Catch-Methods for initialising Realm dadabase.
        do {
            _ = try Realm( )
        } catch {
            print("ERROR INITIALISING REALM, \(error)")
        }
        return true
        }
    }

