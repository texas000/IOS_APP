//
//  Explore_view.swift
//  test
//
//  Created by JIN KIM on 12/7/19.
//  Copyright © 2019 JINNY. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation
import SDWebImageSwiftUI

struct Explore_view: View {
    
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var name = ""
    @State var show = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                NavigationLink(destination: MapView(manager: $manager, alert: $alert)){
                MapView(manager: $manager, alert: $alert)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 250)
            }
                
            Text("Find More").fontWeight(.heavy).font(.largeTitle).padding(.top,15)
                
            VStack(alignment: .leading){
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Image("example-room").resizable().aspectRatio(contentMode: .fit)
                        .overlay(
                            Text("Mac OS Catalina")
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                        ,alignment: .bottomTrailing)
                    }.buttonStyle(PlainButtonStyle())
                    Text("Hello world").fontWeight(.heavy)
                    
                    HStack(spacing: 5){
                        Image(systemName: "heart")
                        Text("Torrance, CA")
                    }
            }
                
            VStack(alignment: .leading){
                Button(action: {
                    
                }) {
                    Image("turtlerock").resizable().aspectRatio(contentMode: .fit)
                }.buttonStyle(PlainButtonStyle())
                Text("Hello world").fontWeight(.heavy)
                
                HStack(spacing: 5){
                    Image(systemName: "heart")
                    Text("Torrance, CA")
                    }
                }
            }
        }.sheet(isPresented: $show) {
            Detail()
        }
    }
}

struct Explore_view_Previews: PreviewProvider {
    static var previews: some View {
        Explore_view()
    }
}

struct Detail : View {
    
    var body: some View{
        VStack{
            Image("example-room").resizable().frame(width: UIScreen.main.bounds.width, height: 500).aspectRatio(1.35, contentMode: .fill).offset(y: -200).padding(.bottom, -200)
            GeometryReader{geo in
                VStack{
                    Detail_top()
                }
            }.background(Color.white)
            .clipShape(Rounded())
            .padding(.top, -70)
        }
    }
}

struct Detail_top : View{
    var body: some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Something").fontWeight(.heavy).font(.largeTitle)
                    Text("Something").fontWeight(.heavy).font(.largeTitle)
                }
                
                Spacer()
                
                Text("$299").foregroundColor(Color.gray).font(.largeTitle)
                
            }
        }
    }
}

struct Rounded : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width:40, height: 40))
        return Path(path.cgPath)
    }
}

    
    
struct MapView : UIViewRepresentable {
    @Binding var manager : CLLocationManager
    @Binding var alert : Bool
    let map = MKMapView()
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        map.showsUserLocation = true

        // Ask for Authorisation from the User.
        self.manager.requestAlwaysAuthorization()

        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
             self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
             self.manager.startUpdatingLocation()

            //Temporary fix: App crashes as it may execute before getting users current location

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                let locValue:CLLocationCoordinate2D = self.manager.location!.coordinate
                print("CURRENT LOCATION = \(locValue.latitude) \(locValue.longitude)")

                let coordinate = CLLocationCoordinate2D(
                    latitude: locValue.latitude, longitude: locValue.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                uiView.setRegion(region, animated: true)
            })
        }
    }
    
    func makeCoordinator() -> MapView.Coordinator{
        return MapView.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        
        //map.centerCoordinate = CLLocationCoordinate2D(latitude: map.centerCoordinate.latitude, longitude: map.centerCoordinate.longitude)
        //map.setRegion(MKCoordinateRegion(center: map.centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        return map
    }
    
    
    
    class Coordinator : NSObject, CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied {
                print("denied")
            }
            if status == .authorizedWhenInUse{
                print("location success")
            }
        }
        //func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //    let last = locations.last
            //print(last!)
        //}
    }
}

