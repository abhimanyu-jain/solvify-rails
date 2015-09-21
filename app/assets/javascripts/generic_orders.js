/**
 * Created by abhimanyu.jain on 10/08/15.
 */

var availableTags = [
    "Ashok Nagar",
    "Banashankari",
    "Bannerghatta Road",
    "Bommanahalli",
    "BTM Layout",
    "Chamarajpet",
    "Dickenson Road",
    "Electronic City",
    "Hanumanthanagar",
    "HSR Layout",
    "J P Nagar",
    "Jayachamaraja Road",
    "Kasturba Road",
    "Kumaraswamy Layout",
    "Langford Town",
    "Madivala",
    "Magrath Road",
    "Mahatma Gandhi Road",
    "Mission Road",
    "Museum Road",
    "Padmanabhanagar",
    "Peenya",
    "Raj Bhavan Road",
    "Raja Rajeshwari Nagar",
    "Residency Road",
    "Sampangiram Nagar",
    "Sankey Road",
    "Sarjapur Road",
    "St. Mark's Road",
    "Ulsoor",
    "Uttarahalli",
    "VV Puram",
    "Wilson Garden",
    "Avenue Road",
    "Basavanagudi",
    "Church Street",
    "Commercial Street",
    "Crescent Road",
    "Cunningham",
    "High Grounds",
    "Infantry Road",
    "Kumara Krupa Road",
    "Lady Curzon Road",
    "Lavelle Road",
    "Magadi Road",
    "Palace Road",
    "R.T. Nagar",
    "Rajaji Nagar",
    "Richmond Road",
    "Richmond Town",
    "Seshadri Road",
    "Vittal Mallya Road",
    "Koramangala",
    "Bellandur",
    "Brigade Road",
    "Brookefield",
    "C.V. Raman Nagar",
    "Domlur Layout",
    "Jayamahal Road",
    "Jeevan Bheema Nagar",
    "Kadugodi",
    "Mahadevapura",
    "Marathahalli",
    "Old Airport Road",
    "Ramamurthy Nagar",
    "Thippasandra",
    "Varthur",
    "Vimanapura",
    "Indiranagar",
    "Jayanagar",
    "other"
];

$(document).ready(function() {
    $( "#locality" ).autocomplete({
        source: availableTags
    });

});

function verify_data() {
    var _gaq = _gaq || [];
    _gaq.push(['_trackEvent', 'Booking initiated']);
    var service_name = $("#service_name").val();
    var locality = $("#locality").val();
    if(service_name == 'Service')
    {
        document.getElementById('Error_Text').innerHTML = "Select a service first...";
        return;
    }
    if(locality == 'Locality')
    {
        document.getElementById('Error_Text').innerHTML = "Select a locality first...";
        return;
    }
}

function back_to_homepage() {
    window.location = "http://www.solvify.in";
}

