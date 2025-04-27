//
//  MenuViewModel.swift
//  wooryMeal
//
//  Created by Hyun on 12/23/24.
//

import Foundation

class MenuViewModel: ObservableObject {
    @Published var menus: [Table] = []
    @Published var errorMessage: String?
    @Published var todayMenu: Table?
    
    var calender = Calendar.current
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    func fetchMenus() {
        TableManager.shared.fetchMenuData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let menus):
                    let now = Date()
                    print("success on \(self.dateFormatter.string(from: now))")
                    self.menus = []
                    for menu in menus{
                        /*
                        if menu.date == "2025-03-31"{
                            self.todayMenu = menu
                        }else if menu.date > "2025-03-31"{
                            self.menus.append(menu)
                        }
                         */
                        if menu.date == self.dateFormatter.string(from: now){
                            self.todayMenu = menu
                        }else if menu.date > self.dateFormatter.string(from: now){
                            self.menus.append(menu)
                        }
                        print(menu.date,menu.order)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchMenus(on date: String) {
        TableManager.shared.fetchMenuData(on: date) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let menus):
                    self.menus = menus
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
