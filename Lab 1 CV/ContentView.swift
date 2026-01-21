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
    let city: String
        
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            Image(imageName).resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 100).clipShape(Circle())
            Text(name).font(.largeTitle).bold()
            HStack{
                Text(city).font(.title2)
                Text("🇸🇬")
            }
            
        }.padding(30)
            .background(RoundedRectangle(cornerRadius: 16).fill(.teal.opacity(0.35)))
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
                city: "Singapore"
            )
            
            Divider()
            
            VStack(spacing: 12){
                NavigationSplitView {
                    Text("List of previous workplace/school")
                    List {
                        NavigationLink {
                            List{
                                NavigationLink {
                                    Text("North View Primary School")
                                } label: {
                                    Text("Age 7 - 12")
                                }
                                NavigationLink {
                                    Text("Presbyterian High School")
                                } label: {
                                    Text("Age 13 - 16")
                                }
                                NavigationLink {
                                    Text("Ngee Ann Polytechnic")
                                } label: {
                                    Text("Age 17 - 19")
                                }
                                NavigationLink {
                                    Text("Nanyang Technological University")
                                } label: {
                                    Text("Age 22 - Current")
                                }
                            }
                        } label: {
                            Text("Previous Schools")
                        }
                        
                        NavigationLink {
                            List{
                                Text("9S Seafood Automation Developer")
                                Text("NPRobotics Temporary Staff")
                                Text("Intern at DSTA")
                                Text("Intern at AbbVie")
                            }
                        } label: {
                            Text("Previous Workplaces")
                        }
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
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
