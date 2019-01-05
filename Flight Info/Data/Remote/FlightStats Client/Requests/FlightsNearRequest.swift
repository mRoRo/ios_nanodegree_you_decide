//
//  FlightsNearRequest.swift
//  Flight Info
//
//  Created by Maro on 26/12/2018.
//  Copyright © 2018 Maria Rodriguez. All rights reserved.
//

import RxSwift
import RxAlamofire
import CoreData

final class FlightsNearRequest: NSObject, FlightsNearDataSource {
    
    let maxMilesRadius = 200
    
    // core data
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<Flight>!
    
    override init() {
        super.init()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
        setUpFetchedResultsController()
    }
    
    func getPersistedFlightsNear() -> [NearFlight] {
        // get flights
        guard let flights = fetchedResultsController.fetchedObjects else {
            return [NearFlight] ()
        }
        
        // TODO: move code to mapper
        return flights.compactMap {
                flight -> NearFlight? in
                    let id = flight.fsId
                    let name = flight.name
            let positions = flight.locations?.allObjects as! [FlightLocation]
                    
                    let mappedPositions =  positions.compactMap { position -> FlightPosition? in
                        return FlightPosition(lon: position.lon, lat: position.lat, speedMph: 0, altitudeFt: 0, date: position.date)
                    }
            
                    
            return NearFlight(id: Int(id), positions: mappedPositions, name: name ?? "")
                }
    }
    
    // WS
    func getFlightsNear(lat: Double, lon: Double) -> Observable<FSNearFlightsResponse> {
        
        let parameters = RequestUtils.authParameters()
        
        let latString = String(lat)
        let lonString = String(lon)
        let milesString = String(maxMilesRadius)
        
        // add lat to the method
        var method = RequestUtils.substituteKeyInMethod(FSClientConstants.Methods.FlightsNear, key: FSClientConstants.URLKeys.Lat, value: latString)!
        
        // add lon to the method
        method = RequestUtils.substituteKeyInMethod(method, key: FSClientConstants.URLKeys.Lon, value: lonString)!
        
        // add miles to the method
        method = RequestUtils.substituteKeyInMethod(method, key: FSClientConstants.URLKeys.Miles, value: milesString)!
        
        // compose the url
        let urlString = RequestUtils.urlFromParameters(parameters, withPathExtension: method)
        
        return RxAlamofire.requestData(.get, urlString)
            .mapObject(type: FSNearFlightsResponse.self)
    }
    
    // Core Data
    func setFlightsNear(flights: [NearFlight]) {
        deleteAllFlights()
        saveFlights(flights)
    }
    
    // MARK: - CoreData
    func setUpFetchedResultsController() {
        
        // Sortdescriptor is mandatory in fetchRequest!
        let fetchRequest: NSFetchRequest<Flight> = Flight.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Delete cache ?
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "nearFlights")
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Flights Management
    // Create and persist Flights
    private func deleteAllFlights() {
        
        // create the delete request for the specified entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flight")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // perform the delete
        do {
            try self.dataController.backgroundContext.execute(deleteRequest)
        } catch let error as NSError {
            fatalError("Photos could not be removed: \(error.localizedDescription)")
        }
    }
    
    private func saveFlights(_ flights: [NearFlight]) {
        
        let context = self.dataController.viewContext
        let flightEntity = NSEntityDescription.entity(forEntityName: "Flight", in: context)
        let flightLocationEntity = NSEntityDescription.entity(forEntityName: "FlightLocation", in: context)

        
        for flight in flights{
            let newFlight = NSManagedObject(entity: flightEntity!, insertInto: context)
            newFlight.setValue(flight.id, forKey: "fsId")
            newFlight.setValue(flight.name, forKey: "name")
            for location in flight.positions {
                let newFlightLocation = NSManagedObject(entity: flightLocationEntity!, insertInto: context)
                newFlightLocation.setValue(location.lat, forKey: "lat")
                newFlightLocation.setValue(location.lon, forKey: "lon")
                newFlightLocation.setValue(location.date, forKey: "date")
                newFlightLocation.setValue(newFlight, forKey: "flight")
                
            }
        }
        
        do {
            try context.save()
        } catch {
             fatalError("New flights could not be saved: \(error.localizedDescription)")
        }
        #if DEBUG
        print("Flights and locations have been correctly saved")
        #endif
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension FlightsNearRequest: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    }
}
