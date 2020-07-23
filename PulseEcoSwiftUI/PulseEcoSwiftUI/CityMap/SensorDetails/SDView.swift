import SwiftUI
import Charts
import Foundation

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
                    
                     //Rectangle().frame(width: 300,height: 200)
                    LineChartSwiftUI().frame(width: 300,height: 200)
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

struct LineChartSwiftUI: UIViewRepresentable {
    let lineChart = LineChartView()
    @EnvironmentObject var dataSource: DataSource
    @EnvironmentObject var appVM: AppVM
    func makeUIView(context: UIViewRepresentableContext<LineChartSwiftUI>) -> LineChartView {
        var sensorName = self.appVM.selectedSensor?.sensorID ?? "empty"
        let sensorReadings = self.dataSource.sensorsData24h.filter{
        
            $0.sensorID == sensorName
        }
        let measure = self.dataSource.getCurrentMeasure(selectedMeasure: self.appVM.selectedMeasure)
        setUpChart(for: sensorReadings, measure: measure)
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChartSwiftUI>) {

    }

    func setUpChart(for sensorReadings: [Sensor], measure: Measure) {
        lineChart.noDataText = "No Data Available"
        //let dataSets1 = [getLineChartDataSet()]
        var dataSets = [IChartDataSet]()
        let colors = [AppColors.purple, AppColors.blue, AppColors.darkred, AppColors.darkgreen, AppColors.red]
        var iterator = colors.makeIterator()
       // for _ in sensorReadings {

            var dataEntries: [ChartDataEntry] = []
            let readingsForType = sensorReadings.filter { sensorReading in
                sensorReading.type == measure.id
            }

            for i in readingsForType {
                var dataEntry = ChartDataEntry()
                let date = DateFormatter.iso8601Full.date(from: i.stamp) ?? Date()
                let x = date.timeIntervalSince1970
                let y = Double(i.value)!
                dataEntry = ChartDataEntry(x: x, y: y)
                dataEntries.append(dataEntry)
            }

        let sensorName = self.dataSource.citySensors.first{
            $0.sensorID == readingsForType[0].sensorID
              // $0.sensorID == "1002"
            }?.description ?? "Unknown"
            let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: sensorName)

            lineChartDataSet.setColor(iterator.next()!)

            lineChartDataSet.mode = .cubicBezier
            lineChartDataSet.drawCirclesEnabled = false
            lineChartDataSet.drawValuesEnabled = false
            lineChartDataSet.lineWidth = 2.0
            lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
            lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false

            dataSets.append(lineChartDataSet)
       // }
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        lineChart.data = data
    }

    func getChartDataPoints(sessions: [Int], accuracy: [Double]) -> [ChartDataEntry] {
        var dataPoints: [ChartDataEntry] = []
        for count in (0..<sessions.count) {
            dataPoints.append(ChartDataEntry.init(x: Double(sessions[count]), y: accuracy[count]))
        }
        return dataPoints
    }

    func getLineChartDataSet() -> LineChartDataSet {
        let dataPoints = getChartDataPoints(sessions: [0,1,2], accuracy: [100.0, 20.0, 30.0])
        let set = LineChartDataSet(entries: dataPoints, label: "DataSet")
        set.lineWidth = 2.5
        set.circleRadius = 4
        set.circleHoleRadius = 2
        let color = ChartColorTemplates.vordiplom()[0]
        set.setColor(color)
        set.setCircleColor(color)
        return set
    }
}
