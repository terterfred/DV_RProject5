require(tidyr)
require(dplyr)
require(tm)
require(wordcloud)
require(RCurl)
require(plyr)
require(ggplot2)
require(jsonlite)


Traffic <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ROAD_ACCIDENT"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_tl23642', PASS='orcl_tl23642', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


#Scatter plot
straff = ddply(
  Traffic,
  .(SPEED_LIMIT, ROAD_SURFACE_CONDITIONS),
  summarize,
  count=sum(NUMBER_OF_CASUALTIES)
)

ggplot(straff, aes(y=ROAD_SURFACE_CONDITIONS, x=SPEED_LIMIT, size = count)) + geom_point(shape=1, color = "blue")



