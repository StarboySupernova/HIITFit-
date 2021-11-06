//
//  HIITFitApp.swift
//  HIITFit
//
//  Created by Simbarashe Dombodzvuku on 10/5/21.
//

import SwiftUI

@main
struct HIITFitApp: App {
    init() {
        let historyStore: HistoryStore
        do {
            try historyStore = HistoryStore(withChecking: true)
        } catch {
            print("Could not load history data")
            historyStore = HistoryStore()
        }
        _historyStore = StateObject(wrappedValue: historyStore)
        
        // couldn't use this, historyStore, by dint of being a StateObject property is a get only property. This following code gives an error
        //self.historyStore = historyStore
    }
    
    @StateObject private var historyStore: HistoryStore
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(historyStore) //Here you use the state object instead of creating HistoryStore, when setting up the environment object
                .onAppear {
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
                }
            /*
             Here you use the shared file manager object to list the URLs for the specified directory. There are many significant directories, which you can find in the documentation at https://apple.co/3pTE3U5. Remember that your app is sandboxed, and each app will have its own app directories.
             ➤ Build and run in Simulator. The debug console will print out an array of URLs for your Documents directory path in the specified domain. The domain here, userDomainMask, is the user’s home directory.
             
             */
            // on a related note, Erasing all contents and settings creates a completely new app sandbox, so open the path printed in the console if you do that to access the new info.plist
        }
    }
}
