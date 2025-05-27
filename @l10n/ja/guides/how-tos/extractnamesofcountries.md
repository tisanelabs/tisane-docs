# Detecting Countries

Tisane can extract country names, but we do not assign a special type exclusively for them. To avoid arguments over legitimacy of this or that geopolical entity, countries contain two elements in their `type` array:

* `organization`
* `place`

This approach:

* helps avoid disputes over sovereignty or status
* does not require making a special exception when a country is to be treated as an organization (e.g. for decision making) or as a place 
