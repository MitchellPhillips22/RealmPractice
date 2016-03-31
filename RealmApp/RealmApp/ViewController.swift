//
//  ViewController.swift
//  RealmApp
//
//  Created by Mitchell Phillips on 3/23/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Define your models like regular Swift classes
        class Cult: Object {
            dynamic var name = ""
            dynamic var leader: Cultist?
            dynamic var members = 0
        }
        class Cultist: Object {
            dynamic var name = ""
            dynamic var timeInCult = 0
            let cultists = List<Cult>()
        }
        
        // Use them like regular Swift objects
        let myCult = Cult()
        myCult.name = "The Order of Chaos"
        myCult.members = 838
        print("name of cult: \(myCult.name)")
        
        // Get the default Realm
        let realm = try! Realm()
        
        // Query Realm for all cultists with greater than 2 years time in the cult
        let cultists = realm.objects(Cult).filter("timeInCult > 2")
        cultists.count // => 0 because no cultists have been added to the Realm yet
        
        // Persist your data easily
        try! realm.write {
            realm.add(myCult)
        }
        
        // Queries are updated in real-time
        cultists.count // => 1
        
        // Query and update from any thread
        dispatch_async(dispatch_queue_create("background", nil)) {
            let realm = try! Realm()
            let theCultist = realm.objects(Cultist).filter("timeInCult == 1").first
            try! realm.write {
                theCultist!.timeInCult = 8
            }
        }
        
        func queryRealm() {
            
            let cultists = realm.objects(Cultist).filter("name = 'Mitch'")
            
            for d in cultists {
                print(d.name)
                print(d.timeInCult)
            }
        }
        
        func seedRealm() {
            
            let cultLeader = Cultist()
            cultLeader.name = "Mitch"
            cultLeader.timeInCult = 12

            
            let person = Cult()
            person.leader = cultLeader
            
            
            let cultist1 = Cultist()
            cultist1.name = "Jim"
            cultist1.timeInCult = 5
            
            
            
            let cultist2  = Cultist()
            cultist2.name = "Jessica"
            cultist2.timeInCult = 2
            
            let cultist3 = Cultist()
            cultist3.name = "George"
            cultist3.timeInCult = 1
            
            
        }
    }
}

