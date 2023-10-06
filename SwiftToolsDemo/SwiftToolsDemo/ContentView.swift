//
//  ContentView.swift
//  SwiftToolsDemo
//
//  2023-09-27 Created by Blake.
//

import SwiftTools
import SwiftUI


struct ContentView: View {

    let viewToOverlay: AnyView =
        AnyView(
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Image(systemName: "checkmark.circle")
                    Text("Overlay custom views")
                }
                HStack(spacing: 2) {
                    Image(systemName: "checkmark.circle")
                    Text("Additional overlay")
                }
            }
        )


    var body: some View {
    
        DynamicStack(.vertical) {
           
            let text =  """
                <h1>Attributed Text</h1>
                <h2>Subheading</h2>
                <h3>Heading3</h3>
                <p>This is a paragraph.</p>
                <b>Bold</b>
                <i>Italics</i>
                <u>Underline</u>
                <s>Strikethrough</s>
                <sup>Superscript</sup>
                <sub>Subscript</sub>
                """
            
            AttributedText(text)
           
            DynamicStack(.horizontal) {
                StatusView("Success", status: .success)
                    .padding()
                StatusView("Failure", status: .failure)
                    .padding()
                StatusView("In progress", status: .inProgress)
                    .padding()
                StatusView("None", status: .none)
                    .padding()
            }
            .padding()
        }
        .overlayAppInfo(include: viewToOverlay)
    }
}





// =============================================================================
// MARK: - Previews
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

struct ContentView_Previews: PreviewProvider {
  
    static var previews: some View {
       
        ContentView()
    }
}
