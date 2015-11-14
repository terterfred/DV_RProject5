require(tidyr)
require(dplyr)
require(tm)
require(wordcloud)
require(RCurl)
require(plyr)
require(ggplot2)
require(jsonlite)

Traffic <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ROAD_ACCIDENT"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_tl23642', PASS='orcl_tl23642', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

#Bar Chart
chart = ddply(
  Traffic,
  .(WEATHER_CONDITIONS, ROAD_SURFACE_CONDITIONS),
  summarize,
  count=sum(NUMBER_OF_CASUALTIES),
  avg = mean(NUMBER_OF_CASUALTIES)
)

ggplot(chart, aes(x=ROAD_SURFACE_CONDITIONS ,y=count)) + geom_bar(colour="blue", fill = "blue", stat="identity") + facet_wrap(~WEATHER_CONDITIONS) + geom_line(stat = "hline", yintercept = "mean")
