
import SwiftUI

struct CityListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataSource: DataSource
    @State private var searchText : String = ""
    @ObservedObject var viewModel: CityListVM
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        VStack() {
            HStack {
                SearchBar(text: $searchText)
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            }.padding(.horizontal, 10)
            List {
                ForEach(self.viewModel.cities.filter {
                    self.searchText.isEmpty ? true : $0.cityName.lowercased().contains(self.searchText.lowercased()) || $0.countryName.lowercased().contains(self.searchText.lowercased())
                }, id: \.id) { city in
                    CityRowView(viewModel: city).onTapGesture {
                        if let city = self.viewModel.cityModel.first(where: { $0.cityName == city.cityName }) {
                            self.userSettings.favouriteCities.insert(city)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                      //  self.userSettings.favouriteCities.removeAll()
                    }
                }
            }
        }
    }
}
