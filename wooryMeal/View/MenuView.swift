//
//  MenuView.swift
//  wooryMeal
//
//  Created by Hyun on 1/4/25.
//

import SwiftUI

struct MenuView: View {
    let mealData:Meal?
    let type:String
    let preferredMenu:[String]
    
    var body: some View {
        GroupBox(label: Text(type)
            .padding(.vertical,2.5)
            .padding(.horizontal, 7)
            .overlay(content: { RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray)
            })
        ){
            if let meal = mealData{
                ScrollView(content: {
                    VStack(alignment: .leading){
                        meal.rice.reduce(Text("")){res, riceStr in
                            let value = MealText(str: riceStr, with: preferredMenu).asText()
                            return res + value + (meal.rice.last == riceStr ? Text("") : Text(", "))
                        }
                        MealText(str: meal.soup, with: preferredMenu)
                        ForEach(meal.dishes, id: \.self){ dish in
                            MealText(str: dish, with: preferredMenu)
                        }
                        MealText(str:meal.kimchi, with: preferredMenu)
                        ForEach(meal.plusCorner, id: \.self){ dish in
                            MealText(str: dish, with: preferredMenu)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                })
            }else{
                VStack(alignment: .center){
                    Spacer()
                    Text("미운영")
                    Spacer()
                }
            }
        }
        .overlay(content: { RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
        })
        .frame(height: 250, alignment: .topLeading)
        .padding(.bottom, 10)
    }
}

#Preview {
    let meal = Meal(rice: ["쌀밥","현미밥"], soup: "곤약어묵탕", dishes: ["국물떡볶이", "모둠튀김", "봄동겉절이"], kimchi: "깍두기", plusCorner: ["그린샐러드","매실주스"])
    MenuView(mealData: meal, type: "점심", preferredMenu: ["김","떡","밥"])
}
