//
//  LaunchScreenView.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/27/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false // controls transition to main view
    @State private var size = 0.7   // initial scale factor for logo
    @State private var opacity = 0.4    // initial opacity for elements
    
    var body: some View {
        if isActive {
            JobListView()   // transition to main app view when isActive is true
        }
        else {
            VStack{
                VStack{
                    Image(systemName: "hare.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255))
                    Text("SwiftHire")
                        .font(.custom("Futura", size:30))
                        .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255).opacity(0.80))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration:1.2)){
                        self.size = 0.9 // end scale
                        self.opacity = 1.0  // end opacity
                    }
                }
            }
            .onAppear {
                // delay activation of main view
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // executes after 2 seconds
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
