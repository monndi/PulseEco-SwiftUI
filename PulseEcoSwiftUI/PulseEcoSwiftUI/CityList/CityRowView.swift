
import Foundation
import SwiftUI

struct CityRowView: View {
    
    var viewModel: CityRowVM
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "pin").foregroundColor(Color.white).scaledToFit()
                VStack(alignment: .leading) {
                    Text("\(self.viewModel.siteName)").foregroundColor(Color.white)
                    Text("\(self.viewModel.countryName)").font(.system(size: 12)).foregroundColor(Color.blue)
                }
                Spacer()
            }
            Divider().background(Color.gray)
        }.frame(height: 60)
        .padding(.horizontal, 10)
    }
}
