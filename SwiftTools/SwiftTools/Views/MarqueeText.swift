//
//  MarqueeText.swift
//  SwiftTools
//
//  2023-07-11 Created by Blake Davis.
//

import SwiftUI


public struct MarqueeText: View {

    @State private var animate:   Bool   = false
    @State private var text:      String
    @State private var textWidth: CGFloat
    
    private let animation = Animation.linear(duration: 2.5)
                                     .delay(3.5)
                                     .repeatForever(autoreverses: false)

    public init (_ text: String) {
        _text      = State(initialValue: text)
        _textWidth = State(initialValue: text.width(usingFont: UIFont.systemFont(ofSize: 15)))
    }


    public var body: some View {
                
        return ZStack {
        
            GeometryReader { geometry in
            
                Text(self.text).lineLimit(1)
                    .font(.subheadline)
                    .offset(x: self.animate ? -textWidth * 2 : 0)
                    .animation(self.animation)
                    .onAppear() {
                        if geometry.size.width < textWidth {
                             self.animate = true
                        }
                }
                .fixedSize(horizontal: true, vertical: false)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                
                Text(self.text).lineLimit(1)
                    .font(.subheadline)
                    .offset(x: self.animate ? 0 : textWidth * 2)
                    .animation(self.animation)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}



//extension Text {
//
//    func marquee() -> some View {
//        return MarqueeText(self.)
//    }
//}






// =============================================================================
// Preview
// -----------------------------------------------------------------------------

struct MarqueeText_Previews: PreviewProvider {
    static var previews: some View {
        MarqueeText("Preview: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    }
}
