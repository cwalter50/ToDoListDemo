//
//  ContentView.swift
//  ToDoList
//
//  Created by Christopher Walter on 11/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var names = ["Tess", "Gorman", "Bobby", "Michael"]
    
    @State var showAlert = false
    
    @State var newName = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(names, id: \.self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Names")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+") {
                        showAlert.toggle()
                    }
                    .font(.title)

                }
            }
            .listStyle(.plain)
        }
        .alert("Add Name", isPresented: $showAlert, actions: {
                    TextField("Enter Name", text: $newName)
                    Button("Add", action: {
                        addName()
                    })
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please enter a new name 😀.")
                })
        .onAppear(perform: loadFromUserDefaults)
        
    }
    
    func addName(){
        withAnimation {
            names.append(newName)
            newName = ""
        }
        saveToUserDefaults()
        
    }
    
    
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(names, forKey: "savedNames")
        
    }
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        
        if let foundNames = defaults.array(forKey: "savedNames") as? [String] {
            names = foundNames
        }
        else {
            names = []
            saveToUserDefaults()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
