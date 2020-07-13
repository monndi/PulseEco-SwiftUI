
import Foundation
import SwiftUI

struct CityRowView: View {
    
    var viewModel: CityRowVM
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(self.viewModel.siteName), \(self.viewModel.countryName)").foregroundColor(Color.gray)
            }.frame(height: 40)
            .padding(.horizontal, 10)
            
    }
}
