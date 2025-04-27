//
//  MenuView.swift
//  wooryMeal
//
//  Created by Hyun on 1/4/25.
//

import SwiftUI

struct MenuView: View {
    let meal:Meal
    let type:String
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray)
            .frame(width:140, height: 230,alignment: .topLeading)
            .shadow(radius: 1, x: 1.5, y: 1.5)
            .overlay(alignment: .leading, content: {
                VStack(alignment: .leading){
                    Text(type)
                        .padding(.vertical,2.5)
                        .padding(.horizontal, 7)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray)
                        })
                    Text(meal.rice.joined(separator: ", "))
                    Text(meal.soup)
                    ForEach(meal.dishes, id: \.self){ dish in
                        Text(dish)
                    }
                    Text(meal.kimchi)
                    ForEach(meal.plusCorner, id: \.self){ dish in
                        Text(dish)
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top,10)
            })
            .padding(.leading, 15)
    }
}

#Preview {
    let meal = Meal(rice: ["햄야채볶음밥1111111"], soup: "곤약어묵탕", dishes: ["국물떡볶이", "모둠튀김", "봄동겉절이"], kimchi: "깍두기", plusCorner: ["그린샐러드","매실주스"])
    MenuView(meal: meal, type: "점심")
}
