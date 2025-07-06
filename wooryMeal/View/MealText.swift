//
//  MealText.swift
//  wooryMeal
//
//  Created by Hyun on 6/20/25.
//

import SwiftUI

struct MealText: View{
    let str: String
    let preferredMenu: Set<String>
    var accent: Bool
    
    init(str: String, with preferredMenu: [String]) {
        self.str = str
        self.preferredMenu = Set(preferredMenu)
        self.accent = false
        
        for menu in preferredMenu{
            if str.contains(menu) {
                self.accent = true
                break
            }else{
                continue
            }
        }
    }
    
    var body: some View {
        if accent {
            Text(str).foregroundStyle(.blue).bold()
        }else{
            Text(str)
        }
    }
}

extension MealText{
    func asText() -> Text {
        if preferredMenu.contains(where: { str.contains($0) }) {
            return Text(str).foregroundStyle(.blue).bold()
        } else {
            return Text(str)
        }
    }
}

#Preview {
}
