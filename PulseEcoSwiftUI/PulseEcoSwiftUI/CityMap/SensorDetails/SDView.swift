import SwiftUI

struct SDView: View {
    @State var offset = UIHeight / 3
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var dataSource: DataSource
    @ObservedObject var viewModel: ExpandedVM
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20){
                CollapsedView(viewModel: SensorDetailsVM(sensor: self.appVM.selectedSensor ?? SensorVM(), sensorsData: self.dataSource.sensorsData24h, selectedMeasure: self.dataSource.getCurrentMeasure(selectedMeasure: self.appVM.selectedMeasure))).padding(.top, 5)
                
               
                VStack {
                     Rectangle().frame(width: 300,height: 200)
                Text(self.viewModel.disclaimerMessage)
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(self.viewModel.color)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20).fixedSize(horizontal: false, vertical: true)
                HStack {
                    Text("Details").font(.system(size: 13, weight: .medium))
                    Text("|").font(.system(size: 13, weight: .medium))
                    Text("Privacy Policy").font(.system(size: 13, weight: .medium))
                }.foregroundColor(self.viewModel.color)
                }.scaledToFit()
                Spacer()
            }.frame(width: geo.size.width, height: geo.size.height * 0.7)
            .background(RoundedCorners(tl: 40, tr: 40, bl: 0, br: 0).fill(Color.white))
            .offset(y: self.offset + geo.size.height / 2)
                .transition(.scale)
                .animation(.linear)
            .gesture(
                    DragGesture()
                        .onChanged {
                            value in
                            if value.translation.height < 0 {
                                if (self.offset > 0 )
                                {
                                    if (self.offset + value.translation.height) > 0 {
                                        self.offset += value.translation.height
                                    }
                                    else {
                                        self.offset += value.translation.height  - (self.offset + value.translation.height)
                                    }
                                }
                            } else {
                                if (self.offset < geo.size.height/3 )
                               {
                                    if (value.translation.height + self.offset) < geo.size.height/3 {
                                       self.offset += value.translation.height
                                    }
                               }
                            }
                    }
                        .onEnded { value in
                            if value.translation.height < 0 {
                                self.offset = CGSize.zero.height - geo.size.height/7
                            } else {
                                self.offset = geo.size.height/3
                            }
                    }
            )
                .onAppear{
                    self.offset = geo.size.height/3
            }
        }
    }
}

