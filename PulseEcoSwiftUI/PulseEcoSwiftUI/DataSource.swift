import Foundation
import Combine

class DataSource: ObservableObject {
    @Published var measures: [Measure] = []
    @Published var loading: Bool = true
    private var cancellable: AnyCancellable?
    
    init() {
        self.cancellable = NetworkManager().downloadMeasures().sink(receiveCompletion: { _ in }, receiveValue: { measures in
            self.measures = measures
            self.loading = false
        })
    }
}
