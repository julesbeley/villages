// Overpass Turbo

[out:json][timeout:25];
{{geocodeArea:Relevant}}->.searchArea;
(
    way["highway"](area.searchArea);-
    way["highway"~"motorway|motorway_link|trunk|trunk_link"](area.searchArea);
);
out body;
>;
out skel qt;

// Overpass API (checking département and city name)

http://overpass-api.de/api/interpreter?data=
[out:json];
area[name="Ain"]->.b;
rel(area.b)[name="Plagne"];
map_to_area -> .a;
(way(area.a)["highway"];-
 way(area.a)["highway"~"motorway|motorway_link|trunk|trunk_link"];);
out;