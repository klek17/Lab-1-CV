//
//  ContentView.swift
//  Lab 1 CV
//
//  Created by Kevin Lim on 21/1/26.
//

import SwiftUI
import SwiftData

struct ProfileHeaderView: View {
    let imageName: String
    let name: String
    let role: String
    let city: String
        
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Image(imageName).resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100).clipShape(Circle())
            Text(name).font(.largeTitle).bold()
            Text(role).font(.title2)
            Text(city).font(.title3)
        }
    }
}

struct ActionItemView: View {
    let systemImage: String
    let label: String
    
    var body: some View {
        VStack(spacing: 6){
            Image(systemName: systemImage).font(.title3)
            Text(label).font(.caption)
        }
        .accessibilityElement(children: .combine)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        VStack(spacing: 16){
            
            ProfileHeaderView(
                imageName: "asdf",
                name: "Kevin Lim",
                role: "iOS Student",
                city: "City: Singapore"
            )
            
            VStack(spacing: 12){
                NavigationSplitView {
                    Text("List of previous workplace/school")
                    List {
                        NavigationLink {
                            Text("North View Primary School")
                        } label: {
                            Text("Primary School")
                        }
                        NavigationLink {
                            Text("Presbyterian High School")
                        } label: {
                            Text("Secondary School")
                        }
                        NavigationLink {
                            Text("North View Primary School")
                        } label: {
                            Text("High Sch")
                        }
                        
                        
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            } label: {
                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                } detail: {
                    Text("Select an item")
                }
            }
            
            HStack(spacing: 24){
                ActionItemView(systemImage: "message.fill", label: "Message")
                ActionItemView(systemImage: "phone.fill", label: "Call")
                ActionItemView(systemImage: "envelope.fill", label: "Email")
            }
            .padding(.top, 8)
            Spacer(minLength: 0)
        }
        .padding(20)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
