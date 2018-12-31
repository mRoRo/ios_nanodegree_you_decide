//
//  DetailsVC.swift
//  Flight Info
//
//  Created by Maro on 29/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift

class DetailsVC: UIViewController, AlertPresenter, ActivityIndicatorPresenter {
    
    @IBOutlet var flightNameLabel: UILabel!
    @IBOutlet var flightStatusLabel: UILabel!
    @IBOutlet var airlineLabel: UILabel!
    @IBOutlet var departureAirportLabel: UILabel!
    @IBOutlet var arrivalAirportLabel: UILabel!
    @IBOutlet var delaysLabel: UILabel!
    @IBOutlet var departureGateDelayLabel: UILabel!
    @IBOutlet var departureRunwayDelayLabel: UILabel!
    @IBOutlet var arrivalGateDelayLabel: UILabel!
    @IBOutlet var arrivalRunwayDelayLabel: UILabel!
    
    
    internal var activityIndicator = UIActivityIndicatorView()
    internal var flightId: String? = ""
    internal var flightName: String? = ""
    
    private let disposeBag = DisposeBag()
    private var viewModel: DetailsViewModel = DetailsViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewStateObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        style()
        viewModel.getFlightTrack(id: flightId!)
    }
    
    // MARK: - Rx
    private func setupViewStateObserver() {
        viewModel.detailsViewStateObservable
            .subscribe(onNext: { state in
                switch(state) {
                    
                case .getFlightTrackStarted:
                    self.showActivityIndicator()
                    
                case .getFlightTrackEnded(let flightTrack):
                    self.hideActivityIndicator()
                    self.updateFlightTrack(flightTrack: flightTrack)
                    
                case .getFlightTrackError(let message):
                    self.showAlert(message: message)
                    self.hideActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
    }
    @IBAction func refreshAction(_ sender: Any) {
        viewModel.getFlightTrack(id:flightId!)
    }
    
    // MARK: - UI updates
    func updateFlightTrack(flightTrack: FlightTrack) {
        
        // Labels
        let flightStatusString = NSLocalizedString("status", comment: "status")
        let airlineString = NSLocalizedString("airline", comment: "airline")
        let deptAirportString = NSLocalizedString("departure_airport", comment: "departure_airport")
        let arrivalAirportString = NSLocalizedString("arrival_airport", comment: "arrival_airport")
        let deptGateDelayString = NSLocalizedString("departure_gate_delay", comment: "departure_gate_delay")
        let arrivalGateDelayString = NSLocalizedString("arrival_gate_delay", comment: "arrival_gate_delay")
        let deptRunwayDelayString = NSLocalizedString("departure_runway_delay", comment: "departure_runway_delay")
        let arrivalRunwayDelayString = NSLocalizedString("arrival_runway_delay", comment: "arrival_runway_delay")
        
        
        let statusString = NSLocalizedString(String(describing: flightTrack.status), comment: String(describing: flightTrack.status)).capitalized
        flightStatusLabel.text = String(format: "%@: %@", flightStatusString.capitalized, statusString)
        
        airlineLabel.text = String(format: "%@: %@", airlineString.capitalized, flightTrack.airline)
        
        departureAirportLabel.text = String(format: "%@: %@", deptAirportString.capitalized, flightTrack.departureAirport)
        arrivalAirportLabel.text = String(format: "%@: %@", arrivalAirportString.capitalized, flightTrack.arrivalAirport)
        
        departureGateDelayLabel.text = String(format: "%@: %@", deptGateDelayString.capitalized, flightTrack.departureGateDelayMinutes ?? "-")
        arrivalGateDelayLabel.text = String(format: "%@: %@", arrivalGateDelayString.capitalized, flightTrack.arrivalGateDelayMinutes ?? "-")
        departureRunwayDelayLabel.text = String(format: "%@: %@", deptRunwayDelayString.capitalized, flightTrack.departureRunwayDelayMinutes ?? "-")
        arrivalRunwayDelayLabel.text = String(format: "%@: %@", arrivalRunwayDelayString.capitalized, flightTrack.arrivalRunwayDelayMinutes ?? "-")
    }
    
    private func style() {
        title = NSLocalizedString("details_view_title", comment: "details_view_title")
        delaysLabel.text = NSLocalizedString("delays", comment: "delays")
        let flightnameString = NSLocalizedString("flight_name", comment: "flight_name")
        flightNameLabel.text = String(format: "%@: %@", flightnameString.capitalized, flightName ?? "-")
    }
}
