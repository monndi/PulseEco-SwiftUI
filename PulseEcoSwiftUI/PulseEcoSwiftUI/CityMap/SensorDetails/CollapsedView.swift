import SwiftUI


struct CollapsedView: View {
    var sensorDetailsVM: SensorDetailsVM
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 3.0, alignment: .bottom)
                .foregroundColor(Color.black).padding(.top, 10)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Image(uiImage: UIImage(named: self.sensorDetailsVM.image)!)
                        Text("\(self.sensorDetailsVM.title) \(self.sensorDetailsVM.sensorID)").foregroundColor(Color.gray)
                    }
                    HStack {
                        Text(self.sensorDetailsVM.value).font(.system(size: 40))
                        Text(self.sensorDetailsVM.unit).padding(.top, 10)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text(self.sensorDetailsVM.time)
                            Text(self.sensorDetailsVM.date).foregroundColor(Color.gray)
                        }
                        Image(uiImage: UIImage(named: self.sensorDetailsVM.image)!)
                    }
                    Spacer().frame(height: 10)
                }
            }.padding([.horizontal], 20)
        }
    }
}
