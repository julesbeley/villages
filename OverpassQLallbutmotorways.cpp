[out:json][timeout:25];
{{geocodeArea:Relevant}}->.searchArea;
(
    way["highway"](area.searchArea);-
    way["highway"~"motorway|motorway_link|trunk|trunk_link"](area.searchArea);
);
out body;
>;
out skel qt;