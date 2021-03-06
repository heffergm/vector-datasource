SELECT name, kind, admin_level, __geometry__

FROM
(
    --
    -- Place Border
    --
    SELECT  
    name,
    boundary AS kind,
    admin_level, 
    way AS __geometry__ 
  
    FROM planet_osm_polygon 
    
    WHERE way && !bbox! 

    AND boundary='administrative' 

    AND admin_level = '4' -- state
    
    --
    -- Place Name
    --
    UNION

    SELECT 
      name, 
      place AS kind,
      '' AS admin_level,
      way AS __geometry__ 

    FROM planet_osm_point 

    WHERE name IS NOT NULL 

    AND place IN (
      'ocean', 
      'country',
      'state',
      'island',
      'gulf',
      'sea',
      'bay',
      'archipelago'
    )

    AND way && !bbox!

) AS places
