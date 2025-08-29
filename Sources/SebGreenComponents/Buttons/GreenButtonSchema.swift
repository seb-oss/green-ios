//
//  GreenButtonSchema.swift
//  SebGreenComponents
//
//  Created by Mayur Deshmukh on 2025-08-28.
//


public struct GreenButtonSchema: Decodable {
    public let title: String?
    public let kind: GreenButton.Kind
    public let size: GreenButton.Size
    public let iconSystemName: String?
    public let iconPosition: GreenButton.IconPosition?
    public let enabled: Bool?
}
