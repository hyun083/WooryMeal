//
//  ContentView.swift
//  wooryMeal
//
//  Created by Hyun on 12/16/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject private var menuVM = MenuViewModel()
    
    var body: some View {
        NavigationView(){
            VStack{
                HStack{
                    Text("금일식단")
                        .font(.title2)
                    Spacer()
                }
                .padding(.leading, 20)
                HStack{
                    MenuView(meal: menuVM.todayMenu?.meals.lunch ?? Meal(), type: "점심")
                    MenuView(meal: menuVM.todayMenu?.meals.dinner ?? Meal(), type: "저녁")
                    Spacer()
                }
                Spacer()
                WeeklyView(menus: menuVM.menus)
            }
            //.navigationTitle(Text("금일 식단"))
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear(){
            menuVM.fetchMenus()
            print(scenePhase, "<- onAppear")
        }
        .onChange(of: scenePhase) {
            print(scenePhase)
            if scenePhase == .inactive {
                menuVM.fetchMenus()
            }
        }

        Spacer()
    }
}

#Preview {
    ContentView()
}
