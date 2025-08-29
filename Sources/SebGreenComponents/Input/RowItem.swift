//
//  RowItem.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-22.
//

import SwiftUI
import SwiftUICore

extension View {
    public func icon(_ icon: Image) -> some View {
        HStack(spacing: .spaceS) {
            icon
            
            self
        }
    }
    
    public func subheadline(_ subheadline: String) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            self
            
            Text(subheadline)
                .typography(.subhead)
                .foregroundStyle(Color.contentNeutral02)
        }
    }
    
    public func disclosureIcon(_ icon: Image) -> some View {
        HStack(spacing: .zero) {
            self
            
            Spacer()
            
            icon
        }
    }
    
    public func toggleAccessory(_ isOn: Binding<Bool>) -> some View {
        HStack(spacing: .zero) {
            self
            
            Spacer()
            
            Toggle("", isOn: isOn)
        }
    }
    
    public func rowItem() -> some View {
        self
            .padding(.vertical, .spaceS)
    }
}

struct RowItem_Previews: PreviewProvider {
    static var previews: some View {
        List(1...10, id: \.self) { int in
            switch int {
            case 1:
                Text("Headline")
                    .rowItem()
            case 2:
                Text("Headline")
                    .icon(Image(systemName: "chart.line.text.clipboard.fill"))
                    .rowItem()
            case 3:
                Text("Headline")
                    .subheadline("Subheadline")
                    .rowItem()
            case 4:
                Text("Headline")
                    .subheadline("Subheadline")
                    .icon(Image(systemName: "chart.line.text.clipboard.fill"))
                    .disclosureIcon(Image(systemName: "chevron.right"))
                    .rowItem()
            case 5:
                Text("Headline")
                    .rowItem()
                    .disclosureIcon(Image(systemName: "chevron.right"))
            case 6:
                Text("Headline")
                    .icon(Image(systemName: "chart.line.text.clipboard.fill"))
                    .disclosureIcon(Image(systemName: "info.circle"))
                    .rowItem()
            case 7:
                Text("Headline")
                    .subheadline("Subheadline")
                    .disclosureIcon(Image(systemName: "chevron.right"))
                    .rowItem()
            case 8:
                Text("Headline")
                    .subheadline("Subheadline")
                    .icon(Image(systemName: "chart.line.text.clipboard.fill"))
                    .disclosureIcon(Image(systemName: "info.circle"))
                    .rowItem()
            case 9:
                Text("Headline")
                    .toggleAccessory(.constant(true))
                    .rowItem()
            case 10:
                Text("Headline")
                    .icon(Image(systemName: "chart.line.text.clipboard.fill"))
                    .toggleAccessory(.constant(true))
                    .rowItem()
            default:
                Text("")
            }
        }
        
    }
}
