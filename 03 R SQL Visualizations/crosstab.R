require(tidyr)
require(dplyr)
require(tm)
require(wordcloud)
require(RCurl)
require(plyr)
require(ggplot2)
require(jsonlite)

Traffic <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ROAD_ACCIDENT"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_tl23642', PASS='orcl_tl23642', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

#Cross Tab
straff = ddply(
  Traffic,
  .(SPEED_LIMIT, ROAD_SURFACE_CONDITIONS),
  summarize,
  counting=sum(NUMBER_OF_CASUALTIES),
  cpv = sum(NUMBER_OF_CASUALTIES)/sum(NUMBER_OF_VEHICLES)
  
)

ggplot(straff, aes(y =ROAD_SURFACE_CONDITIONS , x = SPEED_LIMIT)) + geom_text(aes(label = counting, color = cpv))
