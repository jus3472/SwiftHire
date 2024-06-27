//
//  JobDetailView.swift
//  SwiftHire
//
//  Created by Justin Jiang on 6/20/24.
//

import SwiftUI

struct JobDetailView: View {
    var job: Job    // job to display details for

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(job.jobTitle).font(.custom("Vedo", size: 24)).fontWeight(.heavy)
                    .foregroundColor(Color(red: 61/255, green: 61/255, blue: 61/255, opacity: 1)).padding(.top, 9)
                
                Text(job.companyName).font(.custom("AvenirNext-Medium", size: 21))
                    .foregroundColor(Color(red: 244/255, green: 96/255, blue: 54/255, opacity: 1)
                    ).frame(height: 20)
                
                Text(job.location).font(.custom("AvenirNext-Regular", size: 17))
                    .foregroundColor(.gray).frame(width: 140, height: 20)
                
                Divider()
                Group {
                    Text("Description:").font(.custom("HelveticaNeue-Medium", size: 17))
                    Text(job.jobDescription).font(.custom("HelveticaNeue-Italic", size: 15))
                }
                Divider()
                Group {
                    Text("Requirements:").font(.custom("HelveticaNeue-Medium", size: 17))
                    Text(job.requirements).font(.custom("HelveticaNeue-Italic", size: 15))
                }
            }
            .padding()
        }
        .navigationTitle(job.jobTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
