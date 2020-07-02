//
//  Disclaimer.swift
//  PulseEcoSwiftUI
//
//  Created by Monika Dimitrova on 6/25/20.
//  Copyright © 2020 Monika Dimitrova. All rights reserved.
//

import Foundation
import SwiftUI

struct Disclaimer: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(uiImage: UIImage(named: "disclaimerClose")!)
                        .padding([.top, .trailing], 26.0)
                        .frame(width: 20.0, height: 22.0)
                }
            }
            Spacer()
            Image(uiImage: UIImage(named: "disclaimerImage")!)
            Text("Disclaimer").foregroundColor(Color(AppColors.darkblue)).padding(.vertical, 20)
            Text("The data collected are not manipulated in any way. We do not guarantee of their correctness. The MOEPP sensor data are stored as receiver from their service, while the pulse.eco devices depend on the correctness of the used sensors: Nova PM SDS011/SDS021, DHT22 and Grove Sounds sensor. Please refer to their data sheets for details.").font(.system(size: 14)).foregroundColor(Color(AppColors.darkblue)).lineLimit(nil).multilineTextAlignment(.center)
                .padding(.horizontal, 20).fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
    }
}
