//
//  AttributedText.swift
//  SwiftTools
//
//  2023-09-08 Created by Blake.
//

import Foundation
import SwiftUI


public struct AttributedText: View {

    public static var tags: Dictionary<String, (Text) -> (Text)> = [

        "h1": { $0.font(.largeTitle) },
        "h2": { $0.font(.title) },
        "h3": { $0.font(.headline) },
        "h4": { $0.font(.subheadline) },
        "h5": { $0.font(.callout) },
        "h6": { $0.font(.caption) },
        
        "i": { $0.italic() },
        "u": { $0.underline() },
        "s": { $0.strikethrough() },
        "b": { $0.fontWeight(.bold) },
        
        "p":      { $0 + Text("\n") },
        "br":     { $0 + Text("\n") },
        "strong": { $0.fontWeight(.bold) },
        "em":     { $0.italic() },
                        
        "sup": { $0.baselineOffset(10).font(.footnote) },
        "sub": { $0.baselineOffset(-10).font(.footnote) }
    ]

    private let text: Text

    public init(_ htmlString: String, tags: Dictionary<String, (Text) -> (Text)>? = nil) {
        let editedString = htmlString.decodeHTML()
        let parser = HTML2TextParser(editedString, availableTags: tags == nil ? AttributedText.tags : tags!)
        parser.parse()
        text = parser.formattedText
    }

    public var body: some View {
        text
    }
}
