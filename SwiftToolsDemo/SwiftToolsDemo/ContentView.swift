//
//  ContentView.swift
//  SwiftToolsDemo
//
//  2023-09-27 Created by Blake.
//

import SwiftTools
import SwiftUI


struct ContentView: View {


    var body: some View {
    
        DynamicStack(.vertical) {
           
            let text =  """
                <h1>Here is a Title</h1>
                <p>This is a paragraph.</p>
                """
            
            AttributedText(text)
                .border(.red)
           
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
