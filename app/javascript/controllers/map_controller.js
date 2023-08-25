import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }
  static targets = ["map"]

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
                                             mapboxgl: mapboxgl }))

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.showInfoWindow()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html


      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)

       /*  newMarker.getElement().dataset.markerId = marker.id;
        // Put a microphone on the new marker listening for a mouseenter event
        newMarker.getElement().addEventListener('mouseenter', (e) => this.#toggleCardHighlighting(e) );
        // We put a microphone on listening for a mouseleave event
        newMarker.getElement().addEventListener('mouseleave', (e) => this.#toggleCardHighlighting(e) ); */
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  showInfoWindow() {
    const cards = document.querySelectorAll('.card');
    cards.forEach((card, index) => {
      // Put a microphone on each card listening for a mouseenter event
      card.addEventListener('mouseenter', () => {
        document.querySelector(`#marker-${card.id}`).click();
      });
      // We also put a microphone listening for a mouseleave event to close the modal when user doesn't hover the card anymore
      card.addEventListener('mouseleave', () => {
        document.querySelector(".mapboxgl-popup-content").remove();
      });
    });
  }

  // #toggleCardHighlighting(event){
  //   // We select the card corresponding to the marker's id
  //   const card = document.querySelector(`[data-bike-id="${event.currentTarget.dataset.markerId}"]`);
  //   // Then we toggle the class "highlight github" to the card
  //   card.classList.toggle('highlight');
  // }
}
