import SwiftUI


struct CollapsedView: View {
    var viewModel: SensorDetailsVM
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 3.0, alignment: .bottom)
                .foregroundColor(Color.black).padding(.top, 10)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(uiImage: UIImage(named: self.viewModel.image)!)
                        Text("\(self.viewModel.title)").foregroundColor(Color.gray)
                    }
                    HStack {
                        Text(self.viewModel.value).font(.system(size: 40))
                        Text(self.viewModel.unit).padding(.top, 10)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text(self.viewModel.time)
                            Text(self.viewModel.date).foregroundColor(Color.gray)
                        }
                        Image(uiImage: UIImage(named: self.viewModel.image)!)
                    }
                    Spacer().frame(height: 10)
                }
            }.padding([.horizontal], 20)
        }
    }
}
