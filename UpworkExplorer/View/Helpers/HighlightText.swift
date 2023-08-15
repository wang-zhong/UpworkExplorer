//
//  HighlightText.swift
//  UpworkExplorer
//
//  Created by wang on 2023/8/11.
//

import SwiftUI

struct HighlightText: View {
    var text: String
    var term: String
    
    func getOriginalString(_ cursor: Int, _ length: Int) -> Substring {
        let startIndex = text.index(text.startIndex, offsetBy: cursor)
        let endIndex = text.index(startIndex, offsetBy: length)
        let range: Range<String.Index> = startIndex..<endIndex

        return text[range]
    }
    
    func highlightText (_ text: String, _ term: String ) -> Text {
        if term.isEmpty {
            return Text(text)
        }
        
        let arr = text.lowercased().split(separator: term.lowercased(), omittingEmptySubsequences: false)
        var result = Text("")
        var cursor = 0
        for (index, element) in arr.enumerated() {
            if index == 0 {
                result = result + Text(getOriginalString(cursor, element.count))
                cursor += element.count
            } else {
                var backgroundText = AttributedString(getOriginalString(cursor, term.count))
                backgroundText.backgroundColor = .lightGray
                result = result + Text(backgroundText) + Text(getOriginalString(cursor + term.count, element.count))
                
                cursor += term.count + element.count
            }
        }
        
        return result
    }
    
    var body: some View {
        highlightText(text, term)
    }
}

struct HighlightText_Previews: PreviewProvider {
    static var previews: some View {
        HighlightText(text: "Highlight. Convert any String of code into a syntax highlighted AttributedString. Automatic language detection; Works for 50 common", term: "Highlight")
    }
}
