CREATE INDEX FOR (p:POI) ON (p.osmid);
CREATE INDEX FOR (c:Crash) ON (c.date);


CALL gds.graph.list() YIELD graphName AS toDrop
CALL gds.graph.drop(toDrop) YIELD graphName
RETURN "Dropped " + graphName;

MATCH (c:Crash)
set c.formattedDate = date(substring(c.date, 6, 4) + '-' + substring(c.date, 0, 2) + '-' + substring(c.date, 3,2))

MATCH (n:Intersection)
WHERE n.traveltime IS NOT NULL AND n.traveltime <> 'NaN'
SET n:ValidIntersection;

CALL gds.graph.project(
    'Intersections',
    'Intersection',
    {ROAD_SEGMENT: {orientation: 'NATURAL'}},
    {
        relationshipProperties: ['length', 'traveltime']
    }
);