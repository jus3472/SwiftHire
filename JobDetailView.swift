//
//  JobDetailView.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import SwiftUI

struct JobDetailView: View {
    var job: Job    // job to display details for
    @State private var appear = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(job.jobTitle).font(.custom("Vedo", size: 24)).fontWeight(.heavy)
                    .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255, opacity: 1)).padding(.top, 9)
                    .opacity(appear ? 1 : 0)
                    .animation(Animation.easeIn(duration: 0.5).delay(0.1), value: appear)
                
                Text(job.companyName).font(.custom("AvenirNext-Medium", size: 21))
                    .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255, opacity: 1)
                    ).frame(height: 20)
                    .opacity(appear ? 1 : 0)
                    .animation(Animation.easeIn(duration: 0.5).delay(0.3), value: appear)
                
                Text(job.location).font(.custom("AvenirNext-Regular", size: 17))
                    .foregroundColor(.gray).frame(width: 140, height: 20)
                    .opacity(appear ? 1 : 0)
                    .animation(Animation.easeIn(duration: 0.5).delay(0.5), value: appear)
                
                
                Group {
                    Divider()
                    Text("Description:").font(.custom("HelveticaNeue-Medium", size: 17))
                    Text(job.jobDescription).font(.custom("HelveticaNeue-Italic", size: 15))
                }
                .opacity(appear ? 1 : 0)
                .animation(Animation.easeIn(duration: 0.5).delay(0.7), value: appear)
                
                Group {
                    Divider()
                    Text("Requirements:").font(.custom("HelveticaNeue-Medium", size: 17))
                    Text(job.requirements).font(.custom("HelveticaNeue-Italic", size: 15))
                }
                .opacity(appear ? 1 : 0)
                .animation(Animation.easeIn(duration: 0.5).delay(0.9), value: appear)
                
                Spacer(minLength: 495)
                Section(footer: Text("© 2024 Justin Jiang. All rights reserved.")
                    .font(.custom("Futura", size:15))
                    .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255))
                    .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    EmptyView()
                }
                .opacity(appear ? 1 : 0)
                .animation(Animation.easeIn(duration: 0.5).delay(1.1), value: appear)
            }
            .padding()
            .onAppear {
                appear = true
            }
        }
        .navigationTitle(job.jobTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
