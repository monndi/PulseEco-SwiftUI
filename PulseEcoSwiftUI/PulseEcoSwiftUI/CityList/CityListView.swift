
import SwiftUI

struct CityListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataSource: DataSource
    @ObservedObject var viewModel: CityListVM
    @ObservedObject var userSettings: UserSettings
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                Text("Search city, or choose suggested").foregroundColor(Color.white)
                SearchBar(text: self.$viewModel.searchText, placeholder: "Search city or country")
            .padding(.horizontal, 10)
                Text(self.viewModel.text).font(.headline).foregroundColor(Color.white)
            }.padding(.top, 10)
          //  List {
            ScrollView {
                if self.viewModel.searchText.isEmpty {
                    ForEach(Array(self.viewModel.countries.enumerated()), id: \.element) { indx, elem in
                        Section(header: HStack {
                            Text("\(elem)")
                                //.font(.headline)
                                .foregroundColor(.white)
                                .padding()

                                Spacer()
                        }.frame(height: 30)
                            .background(Color(AppColors.lightPurple))
                        .listRowInsets(EdgeInsets(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0))
                        ) {
                            ForEach(self.viewModel.cities.filter {
                                 elem == $0.countryName
                            }, id: \.id) { city in
                                CityRowView(viewModel: city).onTapGesture {
                                    if let city = self.viewModel.cityModel.first(where: { $0.cityName == city.cityName }) {
                                        self.userSettings.favouriteCities.insert(city)
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                     // self.userSettings.favouriteCities.removeAll()
                                }
                            }
                        }
                    }
                } else {
                    self.listCities
                }
            }
        }.background(Color(AppColors.darkblue))
        .edgesIgnoringSafeArea(.all)
    }
    
    var listCities: some View {

        return ForEach(self.viewModel.cities.filter{ $0.cityName.lowercased().contains(self.viewModel.searchText.lowercased()) || $0.countryName.lowercased().contains(self.viewModel.searchText.lowercased())
        }, id: \.id) { city in
            CityRowView(viewModel: city).onTapGesture {
                if let city = self.viewModel.cityModel.first(where: { $0.cityName == city.cityName }) {
                    self.userSettings.favouriteCities.insert(city)
                    self.presentationMode.wrappedValue.dismiss()
                }
                // self.userSettings.favouriteCities.removeAll()
            }
        }
    }
}
