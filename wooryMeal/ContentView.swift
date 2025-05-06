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
                    Text(menuVM.todayMenu?.order.joined(separator: " → ") ?? "")
                }
                .padding(.horizontal, 20)
                HStack{
                        MenuView(mealData: menuVM.todayMenu?.meals.lunch, type: "오늘 점심")
                        MenuView(mealData: menuVM.todayMenu?.meals.dinner, type: "오늘 저녁")
                }
                .padding(.horizontal,15)
                Spacer()
                WeeklyView(menus: menuVM.menus)
            }
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
