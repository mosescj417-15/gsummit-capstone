CALL gds.graph.list() YIELD graphName AS toDrop
CALL gds.graph.drop(toDrop) YIELD graphName
RETURN "Dropped " + graphName;

CALL gds.graph.project(
    'Intersections',
    'Intersection',
    {ROAD_SEGMENT: {orientation: 'NATURAL'}},
    {
        relationshipProperties: ['length', 'traveltime']
    }
);