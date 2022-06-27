//
//  TabMenuView.swift
//  FC_MyAsset
//
//  Created by Morgan Kang on 2022/03/05.
//

import SwiftUI

struct TabMenuView: View {
    var tabs: [String]
    @Binding var selectedTab: Int
    @Binding var updated: CreditCardAmount?
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { columns in Button (
                action: {
                    selectedTab = columns
                    UserDefaults.standard.set(true, forKey: "credit_card_update_checked: \(columns)")
                },
                label: {
                    VStack(spacing: 0) {
                        HStack {
                            if updated?.id == columns {
                                let checked = UserDefaults.standard.bool(forKey: "credit_card_update_checked: \(columns)")
                                Circle()
                                    .fill(!checked ? Color.red : Color.clear)
                                    .frame(width: 6, height: 6)
                                    .offset(x: 2, y: -8)
                            } else {
                                Circle()
                                    .fill(Color.clear)
                                    .frame(width: 6, height: 6)
                                    .offset(x: 2, y: -8)
                            }
                            Text(tabs[columns])
                                .font(.system(.headline))
                                .foregroundColor(selectedTab == columns ? .accentColor : .gray)
                                .offset(x: -4, y: 0)
                        }
                        .frame(
                            width: nil,
                            height: 52,
                            alignment: .center
                        )
                        Rectangle()
                            .fill(
                                selectedTab == columns ? Color.secondary : Color.clear
                            )
                            .frame(
                                width: nil,
                                height: 3,
                                alignment: .center
                            )
                            .offset(x: 4, y: 0)
                    }
                }
            )
            .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height: 55)
    }
}

struct TabMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TabMenuView(tabs: ["지난달 결제", "이번달 결제", "다음달 결제"], selectedTab: .constant(1), updated: .constant(.currentMonth(amount: "10,000원")))
    }
}
